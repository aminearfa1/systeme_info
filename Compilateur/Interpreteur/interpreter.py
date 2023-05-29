def interpreter(machine_code_file):
    memory = [0] * 256  # Initialisation de la mémoire avec 256 emplacements

    with open(machine_code_file, "r") as f:
        for line in f:
            machine_code = line.strip()
            opcode = machine_code[:4]

            if opcode == "1101":  # PRI
                address = int(machine_code[4:], 2)
                value = memory[address]
                print(value)

            elif opcode == "0110":  # AFC
                address = int(machine_code[4:12], 2)
                immediate_value = int(machine_code[12:], 2)
                memory[address] = immediate_value

            elif opcode == "0001":  # ADD
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                memory[result_address] = memory[operand1_address] + memory[operand2_address]

            elif opcode == "0010":  # MUL
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                memory[result_address] = memory[operand1_address] * memory[operand2_address]

            elif opcode == "0011":  # SOU
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                memory[result_address] = memory[operand1_address] - memory[operand2_address]

            elif opcode == "0100":  # DIV
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                memory[result_address] = memory[operand1_address] // memory[operand2_address]

            elif opcode == "0101":  # COP
                result_address = int(machine_code[4:12], 2)
                operand_address = int(machine_code[12:20], 2)
                memory[result_address] = memory[operand_address]

            # Ajoutez d'autres opérations si nécessaire

            # Reste du code pour d'autres opcodes...


machine_code_file = "machine_code.txt"
interpreter(machine_code_file)

