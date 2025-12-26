import subprocess
import os
from pathlib import Path

REPO_PATH = Path(r"C:\users\callum\documents\github\pokecrystalstarters")
BASE_STATS = REPO_PATH / "data" / "pokemon" / "base_stats"
SCRIPT = REPO_PATH / "Python Scripts" / "WikiLearnset" / "generate_wiki_learnset.py"

branches = subprocess.check_output(
    ["git", "-C", str(REPO_PATH), "branch", "--format=%(refname:short)"],
    text=True
).splitlines()

for branch in branches:
    if branch.strip() in {"main", "master"}:
        continue

    print(f"\n=== Checking out {branch} ===")
    subprocess.run(["git", "-C", str(REPO_PATH), "checkout", branch])

    for asm_file in BASE_STATS.glob("*.asm"):
        pokemon = asm_file.stem.capitalize()  # turns 'beldum' into 'Beldum'
        print(f"Generating learnset for {pokemon}...")
        subprocess.run(["python", str(SCRIPT), pokemon])
        # Optionally rename or move WikiMoves.txt after each one
        wiki_output = REPO_PATH / "Python Scripts" / "WikiLearnset" / "WikiMoves.txt"
        dest = wiki_output.with_name(f"WikiMoves-{pokemon}.txt")
        wiki_output.rename(dest)
