def convert_mon_data(input_filename="MonDataInput.txt", output_filename="MonDataOutput.txt"):
    # Define mappings for hardcoded names
    egg_group_map = {
        "Monster": "EGG_MONSTER",
        "Water 1": "EGG_WATER_1",
        "Bug": "EGG_BUG",
        "Flying": "EGG_FLYING",
        "Ground": "EGG_GROUND",
        "Grass": "EGG_PLANT",
        "Human-Like": "EGG_HUMANSHAPE",
        "Humanlike": "EGG_HUMANSHAPE",
        "Human like": "EGG_HUMANSHAPE",
        "Human Shape": "EGG_HUMANSHAPE",
        "HumanShape": "EGG_HUMANSHAPE",
        "Water 3": "EGG_WATER_3",
        "Mineral": "EGG_MINERAL",
        "Amorphous": "EGG_INDETERMINATE",
        "Water 2": "EGG_WATER_2",
        "Ditto": "EGG_DITTO",
        "Dragon": "EGG_DRAGON",
        "None": "EGG_NONE"
    }
    
    growth_rate_map = {
        "Slow": "GROWTH_SLOW",
        "Medium Slow": "GROWTH_MEDIUM_SLOW",
        "Medium Fast": "GROWTH_MEDIUM_FAST",
        "Fast": "GROWTH_FAST",
        "Erratic": "GROWTH_ERRATIC",
        "Fluctuating": "GROWTH_FLUCTUATING"
    }
    
    with open(input_filename, 'r') as file:
        lines = file.readlines()
    
    # Initialize dictionary to hold data categories
    data = {
        "name": "", "stats": {"HP": None, "Attack": None, "Defense": None, "Speed": None, "Special Attack": None, "Special Defense": None},
        "types": [], "catch_rate": 0, "base_exp": 0,
        "held_items": ["NO_ITEM", "NO_ITEM"], "egg_cycles": 0, "growth_rate": "",
        "egg_groups": [], "tm_moves": []
    }
    
    # Parse the input file
    tm_section = False  # Flag to detect TMs section
    for line in lines:
        line = line.strip()
        
        if line.startswith("Mon Name:"):
            data["name"] = line.split(": ")[1].upper()
        elif line.startswith("HP:"):
            data["stats"]["HP"] = line.split(": ")[1]
        elif line.startswith("Attack:"):
            data["stats"]["Attack"] = line.split(": ")[1]
        elif line.startswith("Defense:"):
            data["stats"]["Defense"] = line.split(": ")[1]
        elif line.startswith("Speed:"):
            data["stats"]["Speed"] = line.split(": ")[1]
        elif line.startswith("Special Attack:"):
            data["stats"]["Special Attack"] = line.split(": ")[1]
        elif line.startswith("Special Defense:"):
            data["stats"]["Special Defense"] = line.split(": ")[1]
        elif line.startswith("Type 1:"):
            data["types"].append(line.split(": ")[1].upper())
        elif line.startswith("Type 2:"):
            data["types"].append(line.split(": ")[1].upper())
        elif line.startswith("Catch Rate:"):
            data["catch_rate"] = line.split(": ")[1]
        elif line.startswith("Base Experience:"):
            data["base_exp"] = line.split(": ")[1]
        elif line.startswith("Held Item 1:"):
            held_item = line.split(": ")[1].replace("None", "NO_ITEM").upper()
            data["held_items"][0] = held_item
        elif line.startswith("Held Item 2:"):
            held_item = line.split(": ")[1].replace("None", "NO_ITEM").upper()
            data["held_items"][1] = held_item
        elif line.startswith("Egg Cycles:"):
            data["egg_cycles"] = line.split(": ")[1]
        elif line.startswith("Growth Rate:"):
            growth_rate_key = line.split(": ")[1]
            data["growth_rate"] = growth_rate_map.get(growth_rate_key, "GROWTH_UNKNOWN")
        elif line.startswith("Egg Group 1:"):
            egg_group_key = line.split(": ")[1]
            data["egg_groups"].append(egg_group_map.get(egg_group_key, "EGG_UNKNOWN"))
        elif line.startswith("Egg Group 2:"):
            egg_group_key = line.split(": ")[1]
            data["egg_groups"].append(egg_group_map.get(egg_group_key, "EGG_UNKNOWN"))
        elif line.startswith("TMs:"):
            tm_section = True  # Start reading TMs from the next lines
        elif tm_section:
            if line:  # Continue reading moves until an empty line is encountered
                data["tm_moves"].append(line.strip().upper())
            else:
                tm_section = False  # End of TMs section
    
    # Fill missing egg groups with "EGG_NONE" if less than two are provided
    while len(data["egg_groups"]) < 2:
        data["egg_groups"].append("EGG_NONE")
    
    # Begin assembling the output
    stat_order = ["HP", "Attack", "Defense", "Speed", "Special Attack", "Special Defense"]
    stats_values = [data["stats"][stat] for stat in stat_order]
    
    output = [
        f"\tdb {data['name']} ; 252",
        f"\tdb {', '.join(stats_values)}",
        "\t;   hp  atk  def  spd  sat  sdf",
        f"\tdb {data['types'][0]}, {data['types'][1]}; type",
        f"\tdb {data['catch_rate']} ; catch rate",
        f"\tdb {data['base_exp']} ; base exp",
        f"\tdb {data['held_items'][0]}, {data['held_items'][1]} ; items",
        "\tdb GENDER_F50 ; gender ratio",
        "\tdb 100 ; unknown 1",
        f"\tdb {data['egg_cycles']} ; step cycles to hatch",
        "\tdb 5 ; unknown 2",
        f"\tINCBIN \"gfx/pokemon/{data['name'].lower()}/front.dimensions\"",
        "\tdw NULL, NULL ; unused (beta front/back pics)",
        f"\tdb {data['growth_rate']} ; growth rate",
        f"\tdn {data['egg_groups'][0]}, {data['egg_groups'][1]} ; egg groups",
        ""
    ]
    
    # Add TM/HM learnset if any moves are present
    if data["tm_moves"]:
        output.append("\t; tm/hm learnset")
        output.append(f"\ttmhm {', '.join(data['tm_moves'])}")
    
    output.append("\t; end")
    
    # Write the output to the output file
    with open(output_filename, 'w') as file:
        file.write("\n".join(output))

# Run the function to convert and save the mon data
convert_mon_data()
