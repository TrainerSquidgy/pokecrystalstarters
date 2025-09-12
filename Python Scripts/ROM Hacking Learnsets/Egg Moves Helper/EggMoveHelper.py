def convert_egg_moves(input_filename="EggMovesInput.txt", output_filename="EggMovesOutput.txt", relearned_filename="RelearnedEggMovesOutput.txt"):
    # Read the input file
    with open(input_filename, 'r') as file:
        lines = file.readlines()
    
    # Extract Pokémon name from the input
    pokemon_name = lines[0].split(": ")[1].strip() if ':' in lines[0] else lines[0].strip()
    
    # Start assembling the output for Egg Moves
    egg_moves_output = [f"{pokemon_name}EggMoves:"]
    for line in lines[1:]:
        move = line.strip().upper().replace(" ", "_")
        egg_moves_output.append(f"\tdb {move}")
    egg_moves_output.append("\tdb -1")  # Ending with db -1 for Egg Moves
    
    # Write the Egg Moves output to the EggMovesOutput.txt file
    with open(output_filename, 'w') as file:
        file.write("\n".join(egg_moves_output))
    
    # Start assembling the output for Relearned Egg Moves
    relearned_output = [f"{pokemon_name}RelearnedEggMoves:"]
    relearned_output.append("\tdb 0")  # Start with db 0 for Relearned moves
    for line in lines[1:]:
        move = line.strip().upper().replace(" ", "_")
        relearned_output.append(f"\tdb 1, {move}")  # Each move is relearned at level 1
    relearned_output.append("\tdb 0")  # Ending with db 0 for Relearned moves
    
    # Write the Relearned Egg Moves output to the RelearnedEggMovesOutput.txt file
    with open(relearned_filename, 'w') as file:
        file.write("\n".join(relearned_output))

# Run the function to convert and save the egg moves
convert_egg_moves()
