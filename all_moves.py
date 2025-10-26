import os
import re

# Adjust these if needed
BASE_PATH = os.getcwd()
EVOS_ATTACKS_PATH = os.path.join(BASE_PATH, "data/pokemon/evos_attacks.asm")
EGG_MOVES_PATH = os.path.join(BASE_PATH, "data/pokemon/relearned_egg_moves.asm")
GEN1_TM_PATH = os.path.join(BASE_PATH, "data/pokemon/gen1_tmattacks.asm")
EGG_POINTERS_PATH = os.path.join(BASE_PATH, "data/pokemon/relearned_egg_move_pointers.asm")
GEN1_TM_POINTERS_PATH = os.path.join(BASE_PATH, "data/pokemon/gen1_tmattacks_pointers.asm")
BASE_STATS_DIR = os.path.join(BASE_PATH, "data/pokemon/base_stats")

# Preload species with egg/gen1tm blocks
def load_pointer_species(path):
    with open(path, "r") as f:
        return {
            line.split("::")[0].strip()
            for line in f if "::" in line
        }

species_with_egg_moves = load_pointer_species(EGG_POINTERS_PATH)
species_with_gen1_tm = load_pointer_species(GEN1_TM_POINTERS_PATH)

# Extract level-up moves
def extract_levelup_moves(path, mon):
    with open(path, "r") as f:
        lines = f.readlines()
    start_pattern = re.compile(rf"^{mon}EvosAttacks:", re.IGNORECASE)
    in_block = False
    moves = []
    for line in lines:
        line = line.strip()
        if start_pattern.match(line):
            in_block = True
            continue
        if in_block:
            # Stop at next label
            if re.match(r"^\w+EvosAttacks:", line):
                break
            # Match move line
            match = re.match(r"db\s+\d+,\s*(\w+)", line)
            if match:
                moves.append(match.group(1))
    return moves

# Extract TM/HM moves from base_stats file
def extract_tm_moves(file_path):
    with open(file_path, "r") as f:
        lines = f.readlines()
    moves = []
    in_tm_block = False
    for line in lines:
        if line.strip().lower().startswith("tmhm"):
            in_tm_block = True
            parts = line.strip()[5:].split(",")
            moves.extend([p.strip() for p in parts if p.strip()])
        elif in_tm_block:
            if line.strip().endswith("\\"):
                parts = line.strip()[:-1].split(",")
                moves.extend([p.strip() for p in parts if p.strip()])
            else:
                parts = line.strip().split(",")
                moves.extend([p.strip() for p in parts if p.strip()])
                break
    return moves

# Forgiving egg/gen1tm extractors — skip db 0, stop at next label
def extract_egg_moves_forgiving(file_path, mon):
    with open(file_path, "r") as f:
        lines = f.readlines()
    label = f"{mon}RelearnedEggMoves:"
    in_block = False
    moves = []
    for line in lines:
        if line.strip().lower().startswith(label.lower()):
            in_block = True
            continue
        if in_block:
            if re.match(r"^\w+:", line.strip()):
                break
            match = re.match(r"db 1, (\w+)", line.strip())
            if match:
                moves.append(match.group(1))
    return moves

def extract_gen1_tm_moves_forgiving(file_path, mon):
    with open(file_path, "r") as f:
        lines = f.readlines()
    label = f"{mon}Gen1TMAttacks:"
    in_block = False
    moves = []
    for line in lines:
        if line.strip().lower().startswith(label.lower()):
            in_block = True
            continue
        if in_block:
            if re.match(r"^\w+:", line.strip()):
                break
            match = re.match(r"db 1, (\w+)", line.strip())
            if match:
                moves.append(match.group(1))
    return moves

# Find matching stats file
def find_mon_stat_file(mon, base_dir):
    lower_name = mon.lower() + ".asm"
    for fname in os.listdir(base_dir):
        if fname.lower() == lower_name:
            return os.path.join(base_dir, fname)
    return None

# Main generator
def generate_all_mon_moves_fixed():
    with open(EVOS_ATTACKS_PATH, "r") as f:
        lines = f.readlines()

    species_list = []
    for line in lines:
        mon_match = re.match(r"^\s*(\w+)EvosAttacks:", line)
        if mon_match:
            species_list.append(mon_match.group(1))

    output_blocks = []
    for mon in species_list:
        mon_moves = set()

        # Level-up
        mon_moves.update(extract_levelup_moves(EVOS_ATTACKS_PATH, mon))

        # TM/HM
        mon_file = find_mon_stat_file(mon, BASE_STATS_DIR)
        if mon_file:
            mon_moves.update(extract_tm_moves(mon_file))

        # Egg
        if mon in species_with_egg_moves:
            mon_moves.update(extract_egg_moves_forgiving(EGG_MOVES_PATH, mon))

        # Gen1 TMs
        if mon in species_with_gen1_tm:
            mon_moves.update(extract_gen1_tm_moves_forgiving(GEN1_TM_PATH, mon))

        # Final output
        block = [f"{mon}AllMoves::"]
        for move in sorted(mon_moves):
            block.append(f"    db 1, {move}")
        block.append("    db 0\n")
        output_blocks.append("\n".join(block))

    return "\n".join(output_blocks)

# Write to file
if __name__ == "__main__":
    all_data = generate_all_mon_moves_fixed()
    with open("all_moves.asm", "w", encoding="utf-8") as f:
        f.write(all_data)
    print("✅ All moves written to all_moves.asm")
