import json

def format_pokemon_tm_moves(input_file, output_file):
    try:
        with open(input_file, 'r', encoding='utf-8') as file:
            lines = file.readlines()

        if not lines:
            print(f"Error: The file {input_file} is empty or could not be read.")
            return

        pokemon_data_list = []
        pokemon_name = ""
        tm_moves = []

        for line in lines:
            line = line.strip()
            print(f"Processing line: '{line}'")

            if not line:
                continue

            if line.startswith("Pokémon:"):
                if pokemon_name and tm_moves:
                    pokemon_data_list.append({
                        'Pokemon': pokemon_name,
                        'TMmoves': tm_moves
                    })
                    print(f"Added Pokémon: {pokemon_name} with moves: {tm_moves}")

                pokemon_name = line.split("Pokémon:")[1].strip()
                tm_moves = []
                print(f"Started new Pokémon entry: {pokemon_name}")

            elif "," in line:
                moves = [move.strip() for move in line.split(",")]
                updated_moves = []
                for move in moves:
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
                    updated_moves.append(move)
                updated_moves = [move.replace("_", " ") for move in updated_moves]
                    
                tm_moves.extend(updated_moves)
                print(f"Added TM moves: {moves}")

        if pokemon_name and tm_moves:
            pokemon_data_list.append({
                'Pokemon': pokemon_name,
                'TMmoves': tm_moves
            })
            print(f"Added final Pokémon: {pokemon_name} with moves: {tm_moves}")
        json_data = json.dumps(pokemon_data_list, ensure_ascii=False)
        formatted_data = json_data[1:-1] + ','  
        with open(output_file, 'w', encoding='utf-8') as file:
            file.write(formatted_data)

        print(f"Data written to {output_file} successfully.")
    
    except FileNotFoundError:
        print(f"Error: The file {input_file} was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

format_pokemon_tm_moves('tminput.txt', 'tmoutput.txt')
