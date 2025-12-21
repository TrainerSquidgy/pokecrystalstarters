def convert_learnset(input_filename="LevelMovesInput.txt", output_filename="LevelMovesOutput.txt"):
    # Read the input file
    with open(input_filename, 'r') as file:
        lines = file.readlines()
    
    # Extract Pokémon name and moves from the input
    pokemon_name = lines[0].split(": ")[1].strip()
    
    # Start assembling the output
    output = [f"{pokemon_name}EvosAttacks:", "\tdb 0 ; No More Evolutions"]
    
    # Process each move line
    for line in lines[1:]:
        level, move = line.split(": ")
        level = level.strip()
        move = move.strip().upper().replace(" ", "_")
        output.append(f"\tdb {level}, {move}")
    
    # End with db 0
    output.append("\tdb 0")
    
    # Write the output to the output file
    with open(output_filename, 'w') as file:
        file.write("\n".join(output))

# Run the function to convert and save the learnset
convert_learnset()
