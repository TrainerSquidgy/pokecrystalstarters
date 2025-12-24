def get_pokemon_name():
    with open("mon251.txt", "r") as file:
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


def delete_line(file_path, target_line):
    with open(file_path, 'r') as file:
        lines = file.readlines()  # Read all lines from the file

    with open(file_path, 'w') as file:
        for line in lines:
            if target_line not in line:  # Write back only lines that don't match the target line
                file.write(line)

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
            append_line_above(file_path, 'const CELEBI     ; fb', f'	const {pokemon_name.upper()}\n')
            delete_line(file_path, 'const CELEBI     ; fb')
    

        
        elif file_path == "data/pokemon/names.asm":
            append_line_above(file_path, 'db "CELEBI@@@@"', f'	db "{padded_name.upper()}"\n')
            delete_line(file_path, 'db "CELEBI@@@@"')

        elif file_path == "data/pokemon/base_stats.asm":
            append_line_above(file_path, 'INCLUDE "data/pokemon/base_stats/celebi.asm"', f'INCLUDE "data/pokemon/base_stats/{pokemon_name.lower()}.asm"\n')
            delete_line(file_path, 'INCLUDE "data/pokemon/base_stats/celebi.asm"')

        elif file_path == "data/pokemon/evos_attacks_pointers.asm":
            append_line_above(file_path, '	dw CelebiEvosAttacks', f'	dw {pokemon_name}EvosAttacks\n')
            delete_line(file_path, '	dw CelebiEvosAttacks')

        elif file_path == "data/pokemon/cries.asm":
            append_line_above(file_path, '	mon_cry CRY_ENTEI,       330,  273 ; CELEBI', f'	mon_cry CRY_NIDORAN_M,     0,    0\n')
            delete_line(file_path, '	mon_cry CRY_ENTEI,       330,  273 ; CELEBI')

        elif file_path == "data/pokemon/menu_icons.asm":
            append_line_above(file_path, '	db ICON_HUMANSHAPE  ; CELEBI', f'	db ICON_MONSTER\n')
            delete_line(file_path, '	db ICON_HUMANSHAPE  ; CELEBI')

        elif file_path == "data/pokemon/dex_entry_pointers.asm":
            append_line_above(file_path, '	dw CelebiPokedexEntry', f'	dw {pokemon_name}PokedexEntry\n')
            delete_line(file_path, '	dw CelebiPokedexEntry')
        
        elif file_path == "data/pokemon/dex_entries.asm":
            append_line_below(file_path, 'CelebiPokedexEntry::     INCLUDE "data/pokemon/dex_entries/celebi.asm"', f'{pokemon_name}PokedexEntry::     INCLUDE "data/pokemon/dex_entries/{pokemon_name.lower()}.asm"\n')
            delete_line(file_path, 'CelebiPokedexEntry::     INCLUDE "data/pokemon/dex_entries/celebi.asm"')
        
        elif file_path == "data/pokemon/dex_order_new.asm":
            append_line_above(file_path, '	db CELEBI', f'	db {pokemon_name.upper()}\n')
            delete_line(file_path, '	db CELEBI')
        
        elif file_path == "data/pokemon/dex_order_alpha.asm":
            append_line_below(file_path, '	db ZUBAT', f'	db {pokemon_name.upper()}\n')
            delete_line(file_path, '	db CELEBI')
            
        elif file_path == "data/pokemon/pic_pointers.asm":
            append_line_above(file_path, '	dba_pic CelebiFrontpic', f'	dba_pic {pokemon_name}Frontpic\n')
            append_line_above(file_path, '	dba_pic CelebiFrontpic', f'	dba_pic {pokemon_name}Backpic\n')
            delete_line(file_path, '	dba_pic CelebiFrontpic')
            delete_line(file_path, '	dba_pic CelebiBackpic')

        elif file_path == "gfx/pics.asm":
            append_line_below(file_path, 'SECTION "Pics 19", ROMX', f'{pokemon_name}Backpic: INCBIN "gfx/pokemon/{pokemon_name.lower()}/back.2bpp.lz"\n')
            append_line_below(file_path, 'SECTION "Pics 19", ROMX', f'{pokemon_name}Frontpic: INCBIN "gfx/pokemon/{pokemon_name.lower()}/front.animated.2bpp.lz"\n')

        elif file_path == "data/pokemon/palettes.asm":
            append_line_above(file_path, 'INCBIN "gfx/pokemon/celebi/front.gbcpal", middle_colors', f'INCBIN "gfx/pokemon/{pokemon_name.lower()}/front.gbcpal", middle_colors\nINCLUDE "gfx/pokemon/{pokemon_name.lower()}/shiny.pal"\n')
            delete_line(file_path, 'INCBIN "gfx/pokemon/celebi/front.gbcpal", middle_colors')
            delete_line(file_path, 'INCLUDE "gfx/pokemon/celebi/shiny.pal"')
            
        elif file_path == "gfx/pokemon/anim_pointers.asm":
            append_line_above(file_path, '	dw CelebiAnimation', f'	dw {pokemon_name}Animation\n')
            delete_line(file_path, '	dw CelebiAnimation')
            
        elif file_path == "gfx/pokemon/anims.asm":
            append_line_above(file_path, 'CelebiAnimation:     INCLUDE "gfx/pokemon/celebi/anim.asm"', f'{pokemon_name}Animation:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/anim.asm"\n')
            delete_line(file_path, 'CelebiAnimation:     INCLUDE "gfx/pokemon/celebi/anim.asm"')
            
        elif file_path == "gfx/pokemon/idle_pointers.asm":
            append_line_above(file_path, '	dw CelebiAnimationIdle', f'	dw {pokemon_name}AnimationIdle\n')
            delete_line(file_path, '	dw CelebiAnimationIdle')

        elif file_path == "gfx/pokemon/idles.asm":
            append_line_above(file_path, 'CelebiAnimationIdle:     INCLUDE "gfx/pokemon/celebi/anim_idle.asm"', f'{pokemon_name}AnimationIdle:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/anim_idle.asm"\n')
            delete_line(file_path, 'CelebiAnimationIdle:     INCLUDE "gfx/pokemon/celebi/anim_idle.asm"')

        elif file_path == "gfx/pokemon/bitmask_pointers.asm":
            append_line_above(file_path, '	dw CelebiBitmasks', f'	dw {pokemon_name}Bitmasks\n')
            delete_line(file_path, '	dw CelebiBitmasks')

        elif file_path == "gfx/pokemon/bitmasks.asm":
            append_line_above(file_path, 'CelebiBitmasks:     INCLUDE "gfx/pokemon/celebi/bitmask.asm"', f'{pokemon_name}Bitmasks:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/bitmask.asm"\n')
            delete_line(file_path, 'CelebiBitmasks:     INCLUDE "gfx/pokemon/celebi/bitmask.asm"')
           
        elif file_path == "gfx/pokemon/frame_pointers.asm":
            append_line_above(file_path, '	dw CelebiFrames', f'	dw {pokemon_name}Frames\n')
            delete_line(file_path, '	dw CelebiFrames')

        elif file_path == "gfx/pokemon/johto_frames.asm":
            append_line_above(file_path, 'CelebiFrames:     INCLUDE "gfx/pokemon/celebi/frames.asm"', f'{pokemon_name}Frames:     INCLUDE "gfx/pokemon/{pokemon_name.lower()}/frames.asm"\n')
            delete_line(file_path, 'CelebiFrames:     INCLUDE "gfx/pokemon/celebi/frames.asm"')
            
        elif file_path == "data/pokemon/gen1_order.asm":
            append_line_above(file_path, 'db QWILFISH', f'	db {pokemon_name.upper()}\n')
            delete_line(file_path, 'db QWILFISH')

        elif file_path == "data/pokemon/gen1_tmattacks_pointers.asm":
            append_line_above(file_path, '	dw NoGen1TMAttacks ; Celebi', f'	dw {pokemon_name}Gen1TMAttacks\n')
            delete_line(file_path, '	dw NoGen1TMAttacks ; Celebi')

        elif file_path == "data/pokemon/relearned_egg_move_pointers.asm":
            append_line_above(file_path, 'dw NoRelearnedEggMoves ; Celebi', f'	dw {pokemon_name}RelearnedEggMoves\n')
            delete_line(file_path, 'dw NoRelearnedEggMoves ; Celebi')
            
        elif file_path == "data/pokemon/egg_move_pointers.asm":
            append_line_above(file_path, 'dw NoEggMoves ; Celebi', f'	dw {pokemon_name}EggMoves\n')
            delete_line(file_path, 'dw NoEggMoves ; Celebi')

        elif file_path == "maps/IlexForest.asm":
            append_line_above(file_path, '	loadwildmon CELEBI, 30', f'	loadwildmon MEW, 30\n')
            delete_line(file_path, '	loadwildmon CELEBI, 30')

        elif file_path == "engine/link/link.asm":
            append_line_above(file_path, '	cp CELEBI', f'	cp MEW\n')
            delete_line(file_path, '	cp CELEBI')

        elif file_path == "data/pokemon/ezchat_order.asm":
            append_line_above(file_path, '.se_ze:    db SQUIRTLE, CELEBI, -1', f'.se_ze:    db SQUIRTLE, {pokemon_name.upper()}, -1\n')
            delete_line(file_path, '.se_ze:    db SQUIRTLE, CELEBI, -1')
            
        elif file_path == "data/pokemon/egg_moves.asm":
            append_line_above(file_path, 'NoEggMoves:', f'{pokemon_name}EggMoves:\n')

        elif file_path == "data/pokemon/relearned_egg_moves.asm":
            append_line_above(file_path, 'NoRelearnedEggMoves:', f'{pokemon_name}RelearnedEggMoves:\n')

        elif file_path == "data/pokemon/gen1_tmattacks.asm":
            append_line_above(file_path, 'NoGen1TMAttacks:', f'{pokemon_name}Gen1TMAttacks:\n')

            
        
# Get the Pokémon name from the input file
pokemon_name = get_pokemon_name()

# List of files to modify
file_paths = [
    "engine/link/link.asm",
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
    "data/pokemon/ezchat_order.asm",
    "gfx/pokemon/anim_pointers.asm",
    "gfx/pokemon/anims.asm",
    "gfx/pokemon/idle_pointers.asm",
    "gfx/pokemon/idles.asm",
    "gfx/pokemon/bitmask_pointers.asm",
    "gfx/pokemon/bitmasks.asm",
    "gfx/pokemon/frame_pointers.asm",
    "gfx/pokemon/johto_frames.asm",
    "gfx/pics.asm",
    "maps/IlexForest.asm",
    ]

# Call the function to modify files with the Pokémon name
modify_files(file_paths, pokemon_name)
