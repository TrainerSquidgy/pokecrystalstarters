# filename: all_moves.py
import os
import re

# Base paths (run this script from the repo root)
BASE_PATH = os.getcwd()
EVOS_ATTACKS_PATH = os.path.join(BASE_PATH, "data/pokemon/evos_attacks.asm")
EGG_MOVES_PATH = os.path.join(BASE_PATH, "data/pokemon/relearned_egg_moves.asm")
EGG_POINTERS_PATH = os.path.join(BASE_PATH, "data/pokemon/relearned_egg_move_pointers.asm")
GEN1_TM_PATH = os.path.join(BASE_PATH, "data/pokemon/gen1_tmattacks.asm")
BASE_STATS_DIR = os.path.join(BASE_PATH, "data/pokemon/base_stats")

# ---------------------------------------------------------------------------

def read_lines(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.readlines()

def get_species_list_from_evos_attacks(path):
    out = []
    pat = re.compile(r"^\s*(\w+)EvosAttacks:", re.IGNORECASE)
    for line in read_lines(path):
        m = pat.match(line)
        if m:
            out.append(m.group(1))
    return out

# --- Level-up moves (untouched) --------------------------------------------
def extract_levelup_moves(path, mon):
    lines = read_lines(path)
    start_pattern = re.compile(rf"^{mon}EvosAttacks:", re.IGNORECASE)
    in_block = False
    moves = []
    for raw in lines:
        line = raw.strip()
        if start_pattern.match(line):
            in_block = True
            continue
        if in_block:
            if re.match(r"^\w+EvosAttacks:", line):
                break
            m = re.match(r"db\s+\d+\s*,\s*([A-Z_][A-Z0-9_]*)\b", line)
            if m:
                token = m.group(1)
                if token.isupper():
                    moves.append(token)
    return moves

# --- TM/HM moves (untouched) -----------------------------------------------
def extract_tm_moves(file_path):
    lines = read_lines(file_path)
    moves = []
    in_tm = False
    for raw in lines:
        line = raw.strip()
        if not in_tm and line.lower().startswith("tmhm"):
            in_tm = True
            payload = line[5:]
        elif in_tm:
            payload = line
        else:
            continue
        trailing = payload.endswith("\\")
        payload = payload[:-1] if trailing else payload
        parts = [p.strip() for p in payload.split(",") if p.strip()]
        moves.extend(parts)
        if in_tm and not trailing:
            break
    return moves

# --- File matching helpers --------------------------------------------------
def normalise_name(name: str) -> str:
    """Strip punctuation, underscores, and spaces, lowercased for fuzzy file/label matching."""
    return re.sub(r"[^a-z0-9]", "", name.lower())

def find_mon_stat_file(mon, base_dir):
    """
    Fuzzy-match the correct base_stats file for each Pokémon.
    Handles cases like Nidoran♀/♂, Farfetch'd, Ho-oh, Mr. Mime, etc.
    """
    norm_mon = normalise_name(mon)
    for fname in os.listdir(base_dir):
        base = os.path.splitext(fname)[0].lower()
        if normalise_name(base) == norm_mon:
            return os.path.join(base_dir, fname)
    # special handling for gendered Nidoran if fuzzy match fails
    if mon.lower() == "nidoranf":
        return os.path.join(base_dir, "nidoran_f.asm")
    if mon.lower() == "nidoranm":
        return os.path.join(base_dir, "nidoran_m.asm")
    return None

# --- Gen 1 TM moves ---------------------------------------------------------
def extract_gen1_tm_moves_for_mon(file_path, mon):
    lines = read_lines(file_path)
    label = f"{mon}Gen1TMAttacks:"
    in_block = False
    moves = []
    for raw in lines:
        line = raw.strip()
        if line.lower() == label.lower():
            in_block = True
            continue
        if in_block:
            if re.match(r"^\w+:", line):
                break
            m = re.match(r"db\s+1\s*,\s*([A-Z_][A-Z0-9_]*)\b", line)
            if m:
                moves.append(m.group(1))
    return moves

# --- Relearned Egg Moves ----------------------------------------------------
def parse_egg_pointer_labels(ptrs_path):
    labels = []
    pat = re.compile(r"^\s*dw\s+(\w+)\s*$")
    for raw in read_lines(ptrs_path):
        m = pat.match(raw)
        if m:
            labels.append(m.group(1))
    return labels

def extract_moves_by_label(file_path, label):
    lines = read_lines(file_path)
    in_block = False
    moves = []
    for raw in lines:
        line = raw.strip()
        if line.lower() == (label + ":").lower():
            in_block = True
            continue
        if in_block:
            if re.match(r"^\w+:", line):
                break
            m = re.match(r"db\s+1\s*,\s*([A-Z_][A-Z0-9_]*)\b", line)
            if m:
                moves.append(m.group(1))
    return moves

# --- Main assembly ----------------------------------------------------------
def generate_all_mon_moves_fixed():
    species_list = get_species_list_from_evos_attacks(EVOS_ATTACKS_PATH)

    egg_labels_in_order = parse_egg_pointer_labels(EGG_POINTERS_PATH)
    egg_label_by_species = {}
    for idx, mon in enumerate(species_list):
        egg_label_by_species[mon] = (
            egg_labels_in_order[idx] if idx < len(egg_labels_in_order) else "NoRelearnedEggMoves"
        )

    output_blocks = []
    for mon in species_list:
        ordered = []
        seen = set()

        # Level-up
        for mv in extract_levelup_moves(EVOS_ATTACKS_PATH, mon):
            if mv not in seen:
                ordered.append(mv)
                seen.add(mv)

        # TM/HM
        stat_file = find_mon_stat_file(mon, BASE_STATS_DIR)
        if stat_file:
            for mv in extract_tm_moves(stat_file):
                if mv not in seen:
                    ordered.append(mv)
                    seen.add(mv)

        # Gen 1 TMs
        for mv in extract_gen1_tm_moves_for_mon(GEN1_TM_PATH, mon):
            if mv not in seen:
                ordered.append(mv)
                seen.add(mv)

        # Relearned Egg Moves
        egg_label = egg_label_by_species.get(mon, "NoRelearnedEggMoves")
        if egg_label != "NoRelearnedEggMoves":
            for mv in extract_moves_by_label(EGG_MOVES_PATH, egg_label):
                if mv not in seen:
                    ordered.append(mv)
                    seen.add(mv)

        block = [f"{mon}AllMoves::", "    db 0"]  # <-- Added start sentinel
        for mv in ordered:
            block.append(f"    db 1, {mv}")
        block.append("    db 0\n")
        output_blocks.append("\n".join(block))

    return "\n".join(output_blocks)

# --- Entry ------------------------------------------------------------------
if __name__ == "__main__":
    all_data = generate_all_mon_moves_fixed()
    with open("all_moves.asm", "w", encoding="utf-8") as f:
        f.write(all_data)
    print("✅ All moves written to all_moves.asm")
