def format_name_for_assembly(input_file, output_file):
    try:
        with open(input_file, 'r') as file:
            names = [line.strip() for line in file.readlines()]

        with open(output_file, 'w') as out_file:
            for index, name in enumerate(names):
                # Add '@' padding up to 8 characters
                formatted_name = name.ljust(8, '@')

                # Create the formatted string with "db" and each character separated by commas
                formatted_output = f'db ' + ', '.join(f'"{char}"' for char in formatted_name)

                # Append the comment with index
                formatted_output += f' ; ${index:02X}\n'

                # Write the formatted output to the output file
                out_file.write(formatted_output)

        print(f"Formatted output has been saved to {output_file}.")

    except FileNotFoundError:
        print(f"File '{input_file}' not found.")


# Paths to the input and output files
input_file = 'wondertradenames.txt'
output_file = 'formattedwondertradeots.txt'

# Format and save the assembly code to the output file
format_name_for_assembly(input_file, output_file)
