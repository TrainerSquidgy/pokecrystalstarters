# Read the constant moves list from the "gen2teachable.txt" file
with open("constants/gen2alltms.txt", "r") as file:
    predefined_moves = [line.strip().split(" - ")[1].lower() for line in file]

# Read the input moves from the "UnsortedMoves.txt" file
with open("Gen2-TMs-UnsortedMoves.txt", "r") as file:
    input_moves = [line.strip().lower() for line in file]

# Replace "Focus Punch" with "DynamicPunch" if present in input_moves
input_moves = [move.replace("focus punch", "dynamicpunch") for move in input_moves]

input_moves = [move.replace("psychic", "psychic_m") for move in input_moves]

input_moves = [move.replace("solar beam", "solarbeam") for move in input_moves]
input_moves = [move.replace("dragon breath", "dragonbreath") for move in input_moves]
input_moves = [move.replace("thunder punch", "thunderpunch") for move in input_moves]

# Read the always teachable moves from the "alwaysteachable.txt" file
with open("constants/alwaysteachable.txt", "r") as file:
    always_teachable_moves = [line.strip().lower() for line in file]

# Combine the input moves and always teachable moves
all_moves = input_moves + always_teachable_moves

# Use a set to remove duplicates and preserve order
unique_valid_moves = list(dict.fromkeys(all_moves))

# Filter the unique valid moves that are in the predefined list
valid_moves = [move for move in unique_valid_moves if move in predefined_moves]

# Sort the valid moves in the order of "gen2teachable.txt"
sorted_valid_moves = [move for move in predefined_moves if move in valid_moves]

# Replace spaces and hyphens with underscores in the sorted_valid_moves list
sorted_valid_moves = [move.replace(" ", "_").replace("-", "_") for move in sorted_valid_moves]

# Write the sorted valid moves to a file named "FilteredMoves.txt"
with open("Gen2-TMs-FilteredMoves.txt", "w") as output_file:
    output_file.write("TMs:\n")
    for move in sorted_valid_moves:
        output_file.write(move.upper() + "\n")
print("Filtered moves saved to FilteredMoves.txt")
