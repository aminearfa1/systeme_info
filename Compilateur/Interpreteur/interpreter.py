def interpreter(machine_code_file):
    memory = [0] * 256  # Initialisation de la mémoire avec 256 emplacements
    pc = 0  # Compteur de programme

    with open(machine_code_file, "r") as f:
        instructions = f.readlines()
        while pc < len(instructions):
            machine_code = instructions[pc].strip()
            opcode = machine_code[:4]

            if opcode == "0001":  # ADD
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

            elif opcode == "0110":  # AFC
                address = int(machine_code[4:12], 2)
                immediate_value = int(machine_code[12:], 2)
                memory[address] = immediate_value

            elif opcode == "0101":  # COP
                result_address = int(machine_code[4:12], 2)
                operand_address = int(machine_code[12:20], 2)
                memory[result_address] = memory[operand_address]

            elif opcode == "1100":  # EQU
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                if memory[operand1_address] == memory[operand2_address]:
                    memory[result_address] = 1
                else:
                    memory[result_address] = 0

            elif opcode == "1001":  # JMF
                condition_address = int(machine_code[4:12], 2)
                jump_address = int(machine_code[12:], 2)
                if memory[condition_address] == 0:  # Vérification de la condition
                    pc = jump_address
                    continue

            elif opcode == "0100":  # DIV
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                memory[result_address] = memory[operand1_address] // memory[operand2_address]

            elif opcode == "1101":  # PRI
                address = int(machine_code[4:], 2)
                value = memory[address]
                print(value)

            elif opcode == "1000":  # JMP
                jump_address = int(machine_code[4:], 2)
                pc = jump_address
                continue

            elif opcode == "1010":  # INF
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                if memory[operand1_address] < memory[operand2_address]:
                    pc += 1
                    continue

            elif opcode == "1011":  # SUP
                result_address = int(machine_code[4:12], 2)
                operand1_address = int(machine_code[12:20], 2)
                operand2_address = int(machine_code[20:], 2)
                if memory[operand1_address] > memory[operand2_address]:
                    pc += 1
                    continue

            pc += 1  # Passe à l'instruction suivante

machine_code_file = "machine_code.txt"
interpreter(machine_code_file)


