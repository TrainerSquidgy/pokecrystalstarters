def get_pokemon_name():
    with open("mon253.txt", "r") as file:
        name = file.readline().strip()  # Read the first line and remove any surrounding whitespace
    return name

def pad_name(name):
    # Convert the name to uppercase
    name = name.upper()
    
    # Pad the name with '@' to make it 10 characters long
    padded_name = name.ljust(10, '@')
    
    return padded_name

def append_line_above(file_path, target_line, new_line):
    with open(file_path, "r") as file:
        lines = file.readlines()

    with open(file_path, "w") as file:
        for line in lines:
            if target_line in line:
                file.write(new_line)  # Write the new line before the target line
            file.write(line)  # Then write the target line

def append_line_below(file_path, target_line, new_line):
    with open(file_path, 'r') as file:
        lines = file.readlines()  # Read all lines from the file

    with open(file_path, 'w') as file:
        for line in lines:
            file.write(line)  # Write the original line back to the file
            if target_line in line:  # Check if the current line is the target line
                file.write(new_line)  # Append the new line below the target line

def append_line_to_bottom(file_path, new_line):
    with open(file_path, 'a') as file:  # Open the file in append mode
        file.write(new_line)  # Write the new line at the bottom of the file

def delete_line_above(file_path, target_line):
    with open(file_path, "r") as file:
        lines = file.readlines()

    with open(file_path, "w") as file:
        previous_line = ""  # Store the previous line
        for line in lines:
            if target_line in line:
                # Skip writing the previous line if the current line contains the target
                previous_line = ""  # Reset previous_line to skip it
            else:
                # Write the previous line if it's not to be skipped
                if previous_line:
                    file.write(previous_line)
            # Update previous_line to the current line
            previous_line = line

        # Write the last line if it wasn't flagged for skipping
        if previous_line and target_line not in previous_line:
            file.write(previous_line)



def delete_line_below(file_path, target_line):
    with open(file_path, "r") as file:
        lines = file.readlines()

    with open(file_path, "w") as file:
        skip_next = False  # Flag to indicate if we should skip writing the next line
        for line in lines:
            if skip_next:
                skip_next = False  # Skip the next line
                continue
            file.write(line)  # Write the current line
            if target_line in line:
                skip_next = True  # Set the flag to skip the next line



def delete_lines_between(file_path, start_line, end_line):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    new_lines = []
    delete_mode = False
    
    for line in lines:
        if start_line in line:
            delete_mode = True  # Start deleting from the next line
            new_lines.append(line)  # Keep the start line
            continue
        if end_line in line:
            delete_mode = False  # Stop deleting when we reach the end line
            new_lines.append(line)  # Keep the end line
            continue
        if not delete_mode:
            new_lines.append(line)  # Keep lines that are not deleted

    with open(file_path, 'w') as file:
        file.writelines(new_lines)


def modify_files(file_paths, pokemon_name):  # Renamed 'name' to 'pokemon_name' for clarity
    
    padded_name = pad_name(pokemon_name)    

    for file_path in file_paths:
        if file_path == "constants/pokemon_constants.asm":
            append_line_above(file_path, 'DEF NUM_POKEMON EQU const_value - 1', f'	const {pokemon_name.upper()}\n')
            

        
        elif file_path == "data/pokemon/names.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	db "{padded_name.upper()}"\n')
            delete_line_below(file_path, 'assert_table_length EGG')

        elif file_path == "data/pokemon/base_stats.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'INCLUDE "data/pokemon/base_stats/{pokemon_name.lower()}.asm"\n')

        elif file_path == "data/pokemon/evos_attacks_pointers.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	dw {pokemon_name}EvosAttacks\n')

        elif file_path == "data/pokemon/cries.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	mon_cry CRY_NIDORAN_M,     0,    0\n')
            delete_line_below(file_path, 'assert_table_length NUM_POKEMON')

        elif file_path == "data/pokemon/menu_icons.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	db ICON_MONSTER\n')

        elif file_path == "data/pokemon/dex_entry_pointers.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	dw {pokemon_name}PokedexEntry\n')
        
        elif file_path == "data/pokemon/dex_entries.asm":
            append_line_to_bottom(file_path, f'{pokemon_name}PokedexEntry::     INCLUDE "data/pokemon/dex_entries/{pokemon_name.lower()}.asm"')
        
        elif file_path == "data/pokemon/dex_order_new.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	db {pokemon_name.upper()}\n')
        
        elif file_path == "data/pokemon/dex_order_alpha.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	db {pokemon_name.upper()}\n')

        elif file_path == "data/pokemon/pic_pointers.asm":
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	dba_pic {pokemon_name}Frontpic\n')
            append_line_above(file_path, 'assert_table_length NUM_POKEMON', f'	dba_pic {pokemon_name}Backpic\n')

        elif file_path == "gfx/pics.asm":
            append_line_above(file_path, 'SECTION "Pics 20", ROMX', f'{pokemon_name}Backpic: INCBIN "gfx/pokemon/{pokemon_name.lower()}/back.2bpp.lz"\n')
            append_line_above(file_path, 'SECTION "Pics 20", ROMX', f'{pokemon_name}Frontpic: INCBIN "gfx/pokemon/{pokemon_name.lower()}/front.animated.2bpp.lz"\n\n')

        elif file_path == "data/pokemon/palettes.asm":
            delete_lines_between(file_path, '	assert_table_length EGG + 1', '; 255')
            append_line_above(file_path, '	assert_table_length NUM_POKEMON + 1', f'INCBIN "gfx/pokemon/{pokemon_name.lower()}/front.gbcpal", middle_colors\nINCLUDE "gfx/pokemon/{pokemon_name.lower()}/shiny.pal"\n')
        
        elif file_path == "gfx/pokemon/anim_pointers.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	dw {pokemon_name}Animation\n')

        elif file_path == "gfx/pokemon/anims.asm":
            append_line_above(file_path, 'EggAnimation:        INCLUDE "gfx/pokemon/egg/anim.asm"', f'{pokemon_name}Animation:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/anim.asm"\n')

        elif file_path == "gfx/pokemon/idle_pointers.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	dw {pokemon_name}AnimationIdle\n')

        elif file_path == "gfx/pokemon/idles.asm":
            append_line_above(file_path, 'EggAnimationIdle:        INCLUDE "gfx/pokemon/egg/anim_idle.asm"', f'{pokemon_name}AnimationIdle:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/anim_idle.asm"\n')

        elif file_path == "gfx/pokemon/bitmask_pointers.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	dw {pokemon_name}Bitmasks\n')

        elif file_path == "gfx/pokemon/bitmasks.asm":
            append_line_above(file_path, 'EggBitmasks:        INCLUDE "gfx/pokemon/egg/bitmask.asm"', f'{pokemon_name}Bitmasks:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/bitmask.asm"\n')
           
        elif file_path == "gfx/pokemon/frame_pointers.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	dw {pokemon_name}Frames\n')

        elif file_path == "gfx/pokemon/johto_frames.asm":
            append_line_above(file_path, 'EggFrames:        INCLUDE "gfx/pokemon/egg/frames.asm"', f'{pokemon_name}Frames:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/frames.asm"\n')

        elif file_path == "data/pokemon/gen1_order.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON + 1', f'	db {pokemon_name.upper()}\n')

        elif file_path == "data/pokemon/gen1_tmattacks_pointers.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	dw {pokemon_name}Gen1TMAttacks\n')

        elif file_path == "data/pokemon/relearned_egg_move_pointers.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	dw {pokemon_name}RelearnedEggMoves\n')

        elif file_path == "data/pokemon/egg_move_pointers.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	dw {pokemon_name}EggMoves\n')

        elif file_path == "data/pokemon/egg_moves.asm":
            append_line_above(file_path, 'NoEggMoves:', f'{pokemon_name}EggMoves:\n')

        elif file_path == "data/pokemon/relearned_egg_moves.asm":
            append_line_above(file_path, 'NoRelearnedEggMoves:', f'{pokemon_name}RelearnedEggMoves:\n')

        elif file_path == "data/pokemon/gen1_tmattacks.asm":
            append_line_above(file_path, 'NoGen1TMAttacks:', f'{pokemon_name}Gen1TMAttacks:\n')

        elif file_path == "data/pokemon/evolution_moves.asm":
            append_line_above(file_path, '	assert_table_length NUM_POKEMON', f'	db NO_MOVE      ')

        
        elif file_path == "engine/events/starterselection.asm":
            delete_line_above(file_path, ';PYTHONBUFFER1')
            append_line_above(file_path, ';PYTHONBUFFER1', f'	ld a, {pokemon_name.upper()}\n')
            delete_line_above(file_path, ';PYTHONBUFFER2')
            append_line_above(file_path, ';PYTHONBUFFER2', f'	cp 252\n')
            append_line_above(file_path, ';PYTHONBUFFER3', f'	dw .{pokemon_name}\n')
            append_line_above(file_path, ';PYTHONBUFFER4', f'.{pokemon_name}	db "{padded_name.upper()}@"\n')

        
# Get the Pokémon name from the input file
pokemon_name = get_pokemon_name()

# List of files to modify
file_paths = [
    "engine/events/starterselection.asm",
    "constants/pokemon_constants.asm",
    "data/pokemon/names.asm",
    "data/pokemon/base_stats.asm",
    "data/pokemon/evos_attacks_pointers.asm",
    "data/pokemon/cries.asm",
    "data/pokemon/menu_icons.asm",
    "data/pokemon/dex_entry_pointers.asm",
    "data/pokemon/dex_entries.asm",
    "data/pokemon/dex_order_new.asm",
    "data/pokemon/dex_order_alpha.asm",
    "data/pokemon/pic_pointers.asm",
    "data/pokemon/palettes.asm",
    "data/pokemon/egg_moves.asm",
    "data/pokemon/gen1_order.asm",
    "data/pokemon/gen1_tmattacks_pointers.asm",
    "data/pokemon/gen1_tmattacks.asm",
    "data/pokemon/relearned_egg_move_pointers.asm",
    "data/pokemon/relearned_egg_moves.asm",
    "data/pokemon/egg_move_pointers.asm",
    "gfx/pokemon/anim_pointers.asm",
    "gfx/pokemon/anims.asm",
    "gfx/pokemon/idle_pointers.asm",
    "gfx/pokemon/idles.asm",
    "gfx/pokemon/bitmask_pointers.asm",
    "gfx/pokemon/bitmasks.asm",
    "gfx/pokemon/frame_pointers.asm",
    "gfx/pokemon/johto_frames.asm",
    "gfx/pics.asm",
    "data/pokemon/evolution_moves.asm",
    ]

# Call the function to modify files with the Pokémon name
modify_files(file_paths, pokemon_name)
