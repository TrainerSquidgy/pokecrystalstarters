import re
import sys
import os
from pathlib import Path

# Resolve repo root based on script location
SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parents[1]

# === File Paths (relative to repo root) ===
BASE_DIR = REPO_ROOT / "data/pokemon/base_stats"
EVOS_ATTACKS_PATH = REPO_ROOT / "data/pokemon/evos_attacks.asm"
MOVES_PATH = REPO_ROOT / "data/moves/moves.asm"
CONSTANTS_PATH = REPO_ROOT / "constants/move_constants.asm"
TM_LIST_PATH = REPO_ROOT / "Python Scripts/ROM Hacking Learnsets/Gen 2 - Gen 2 TMs/constants/gen2alltms.txt"

# === Settings ===
TUTOR_LOOKUP = {"FLAMETHROWER": "TU01", "ICE_BEAM": "TU02", "THUNDERBOLT": "TU03"}
TYPE_OVERRIDES = {"CURSE_TYPE": "???", "PSYCHIC_TYPE": "Psychic", "PSYCHIC_M": "Psychic"}
HM_OVERRIDES = {
    "TM51": "HM01", "TM52": "HM02", "TM53": "HM03",
    "TM54": "HM04", "TM55": "HM05", "TM56": "HM06", "TM57": "HM07"
}

def format_type(t):
    return TYPE_OVERRIDES.get(t.upper(), t.title())

def get_category(power):
    try: return "Damaging" if int(power) > 0 else "Status"
    except: return "Status"

def load_moves(move_path):
    move_info = {}
    with open(move_path, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line.startswith("move "):
                parts = line.split()
                if len(parts) < 2:
                    continue
                move = parts[1].rstrip(',')
                fields = line.split(",")
                if len(fields) >= 6:
                    try:
                        power = int(fields[2].strip())
                        move_type = fields[3].strip()
                        accuracy = int(fields[4].strip())
                        pp = int(fields[5].strip())
                        move_info[move] = {
                            "Power": power,
                            "Type": move_type,
                            "Accuracy": f"{accuracy}%",
                            "PP": pp
                        }
                    except ValueError:
                        continue
    return move_info

def load_tm_map(tm_path):
    tm_map = {}
    with open(tm_path, encoding="utf-8") as f:
        for line in f:
            if " - " in line:
                num, move = line.strip().split(" - ")
                label = f"TM{int(num):02}"
                move_key = move.upper().replace(" ", "_").replace("-", "_")
                tm_map[move_key] = (label, move)
    return tm_map

def parse_levelup_moves(pokemon_name, evos_path, move_info):
    with open(evos_path, encoding="utf-8") as f:
        data = f.read()
    block = re.search(rf"{pokemon_name}EvosAttacks:(.*?)db 0 ; no more level-up moves", data, re.DOTALL)
    table = []
    if block:
        for line in block.group(1).strip().splitlines():
            match = re.search(r"db (\d+), ([A-Z_]+)", line)
            if match:
                level, move = int(match[1]), match[2].upper()
                info = move_info.get(move, {"Power": "-", "Type": "-", "Accuracy": "-", "PP": "-"})
                table.append({
                    "Level": level,
                    "Move": move.replace("_", " ").title(),
                    "Type": format_type(info["Type"]),
                    "Category": get_category(info["Power"]),
                    "Power": info["Power"],
                    "Accuracy": info["Accuracy"],
                    "PP": info["PP"]
                })
    return sorted(table, key=lambda x: x["Level"])

def parse_tm_tutor_from_line(line, move_info, tm_map):
    raw = line.replace("tmhm", "").strip()
    all_moves = [m.strip().upper() for m in raw.split(",") if m.strip()]

    tutors = {"FLAMETHROWER": "TU01", "ICE_BEAM": "TU02", "THUNDERBOLT": "TU03"}
    tutor_moves = []
    tm_moves = []

    for move in all_moves:
        if move in tutors:
            tutor_moves.append(move)
        else:
            tm_moves.append(move)

    tm_table = []
    for move in tm_moves:
        entry = tm_map.get(move)
        if not entry:
            continue
        label, display_name = entry
        info = move_info.get(move, {"Power": "-", "Type": "-", "Accuracy": "-", "PP": "-"})
        tm_table.append({
            "TM": label,
            "Move": display_name,
            "Type": format_type(info["Type"]),
            "Category": get_category(info["Power"]),
            "Power": info["Power"],
            "Accuracy": info["Accuracy"],
            "PP": info["PP"]
        })

    tutor_table = []
    for move in tutor_moves:
        label = tutors[move]
        info = move_info.get(move, {"Power": "-", "Type": "-", "Accuracy": "-", "PP": "-"})
        tutor_table.append({
            "Tutor": label,
            "Move": move.replace("_", " ").title(),
            "Type": format_type(info["Type"]),
            "Category": get_category(info["Power"]),
            "Power": info["Power"],
            "Accuracy": info["Accuracy"],
            "PP": info["PP"]
        })

    return tm_table, tutor_table

def extract_pokemon_types(base_stats_lines):
    line = base_stats_lines[5]  # line 6 = index 5
    parts = line.strip().split()
    if len(parts) >= 3:
        _, type1_raw, type2_raw = parts[:3]
        type1 = format_type(type1_raw.replace(",", ""))
        type2 = format_type(type2_raw.replace(",", ""))
        return list({type1, type2}) if type1 != type2 else [type1]
    return []

def to_wikitext(table, label, pokemon_types=None):
    pokemon_types = pokemon_types or []

    header = f"""{{| class="learnset" style="text-align:center"
|+ {label} Learnset
|-
! class="learnset-header" | {label} !! Move !! Type !! Category !! Power !! Acc. !! PP"""
    rows = [header]

    for row in table:
        type_class = f'{row["Type"].lower()}bg'

        is_damaging = False
        try:
            is_damaging = int(row["Power"]) > 0
        except ValueError:
            pass  # Skip if not a number (like '-')

        def maybe_bold(value):
            return f"'''{value}'''" if is_damaging else value

        rows.append(
            f"""|-
| {maybe_bold(row[label])} || {maybe_bold(row["Move"])} || class="{type_class}" | {maybe_bold(row["Type"])} || {maybe_bold(row["Category"])} || {maybe_bold(row["Power"])} || {maybe_bold(row["Accuracy"])} || {maybe_bold(row["PP"])}"""
        )

    rows.append("|}")
    return "\n".join(rows)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python generate_wiki_learnset.py <PokemonName>")
        sys.exit(1)

    poke = sys.argv[1].strip().capitalize()
    move_info = load_moves(MOVES_PATH)
    tm_map = load_tm_map(TM_LIST_PATH)

    levelup = parse_levelup_moves(poke, EVOS_ATTACKS_PATH, move_info)
    base_path = BASE_DIR / f"{poke.lower()}.asm"
    with open(base_path, encoding="utf-8") as f:
        base_lines = f.readlines()

    pokemon_types = extract_pokemon_types(base_lines)
    line_20 = base_lines[19]
    tm, tutor = parse_tm_tutor_from_line(line_20, move_info, tm_map)

    print("\n=== Level-Up Learnset ===\n")
    print(to_wikitext(levelup, "Level", pokemon_types))

    print("\n=== TM/HM Learnset ===\n")
    print(to_wikitext(tm, "TM", pokemon_types))

    print("\n=== Tutor Learnset ===\n")
    print(to_wikitext(tutor, "Tutor", pokemon_types))

# Save output to a file
output_file = SCRIPT_DIR / "WikiMoves.txt"
with open(output_file, "w", encoding="utf-8") as f:
    f.write("=== Level-Up Learnset ===\n\n")
    f.write(to_wikitext(levelup, "Level") + "\n\n")
    f.write("=== TM/HM Learnset ===\n\n")
    f.write(to_wikitext(tm, "TM") + "\n\n")
    f.write("=== Tutor Learnset ===\n\n")
    f.write(to_wikitext(tutor, "Tutor") + "\n")
print(f"\n✅ Learnsets saved to {output_file}")