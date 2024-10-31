import json

def format_pokemon_level_moves(input_file, output_file):
    try:
        # Read the input file with proper encoding
        with open(input_file, 'r', encoding='utf-8') as file:
            lines = file.readlines()

        if not lines:
            print(f"Error: The file {input_file} is empty or could not be read.")
            return

        pokemon_data_list = []  # To hold multiple Pokémon data entries
        pokemon_name = ""
        level_moves = []

        # Process the input
        for line in lines:
            line = line.strip()  # Remove leading/trailing whitespace
            print(f"Processing line: '{line}'")  # Debug: Show each line being processed

            if not line:  # Skip empty lines
                continue

            if line.startswith("Pokémon:"):
                # If we already have a Pokémon stored, append its data to the list
                if pokemon_name and level_moves:
                    pokemon_data_list.append({
                        'Pokemon': pokemon_name,
                        'LevelMoves': level_moves
                    })
                    print(f"Added Pokémon: {pokemon_name} with moves: {level_moves}")  # Debug: Output added data

                # Start a new Pokémon entry
                pokemon_name = line.split("Pokémon:")[1].strip()
                level_moves = []  # Reset the level moves list
                print(f"Started new Pokémon entry: {pokemon_name}")  # Debug: Indicate a new Pokémon entry

            elif ":" in line:  # Check if the line contains level and move data
                try:
                    level, move = line.split(":")
                    move = move.strip()

                    # Modify the move name if needed
                    if move.lower() == "psychic_m":
                        move = "Psychic"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "dynamicpunch":
                        move = "DynamicPunch"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "mudslap":
                        move = "Mud-Slap"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "ancientpower":
                        move = "AncientPower"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "bubblebeam":
                        move = "BubbleBeam"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "sandattack":
                        move = "Sand-Attack"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "doubleedge":
                        move = "Double-Edge"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "lockon":
                        move = "Lock-On"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "doubleslap":
                        move = "DoubleSlap"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "dragonbreath":
                        move = "DragonBreath"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "extremespeed":
                        move = "ExtremeSpeed"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "feintattack":
                        move = "Faint Attack"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "featherdance":
                        move = "FeatherDance"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "grasswhistle":
                        move = "GrassWhistle"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "hijumpkick" or move.lower().replace(" ","").replace("_","").replace("-","") == "highjumpkick":
                        move = "Hi Jump Kick"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "poisonpowder":
                        move = "PoisonPowder"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "selfdestruct":
                        move = "SelfDestruct"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "smellingsalt" or move.lower().replace(" ","").replace("_","").replace("-","") == "smellingsalts":
                        move = "SmellingSalt"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "smokescreen":
                        move = "SmokeScreen"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "softboiled":
                        move = "SoftBoiled"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "sonicboom":
                        move = "SonicBoom"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "thunderpunch":
                        move = "ThunderPunch"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "thundershock":
                        move = "ThunderShock"
                    elif move.lower().replace(" ","").replace("_","").replace("-","") == "vicegrip" or move.lower().replace(" ","").replace("_","").replace("-","") == "visegrip" :
                        move = "ViceGrip"
                    # Add the level and modified move to the list
                    level_moves.append({
                        'Level': level.strip(),
                        'Move': move
                    })
                    print(f"Added move: Level {level.strip()}, Move {move}")  # Debug: Show each move added
                except ValueError:
                    print(f"Error: Line '{line}' is not in the expected 'Level: Move' format")  # Debug: Format error

        # Append the last Pokémon's data after the loop
        if pokemon_name and level_moves:
            pokemon_data_list.append({
                'Pokemon': pokemon_name,
                'LevelMoves': level_moves
            })
            print(f"Added final Pokémon: {pokemon_name} with moves: {level_moves}")  # Debug: Output added data

        # Convert the list to a JSON string and format it
        json_data = json.dumps(pokemon_data_list, ensure_ascii=False)
        formatted_data = json_data[1:-1] + ','  # Remove brackets and add a comma

        # Write the formatted data to the output file
        with open(output_file, 'w', encoding='utf-8') as file:
            file.write(formatted_data)

        print(f"Data written to {output_file} successfully.")
    
    except FileNotFoundError:
        print(f"Error: The file {input_file} was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

# Example usage:
format_pokemon_level_moves('levelinput.txt', 'leveloutput.txt')
