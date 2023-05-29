def translate_instruction(opcode, args):
    machine_code = ""

    if opcode == "ADD":
        machine_code += "0001"
    elif opcode == "MUL":
        machine_code += "0010"
    elif opcode == "SOU":
        machine_code += "0011"
    elif opcode == "DIV":
        machine_code += "0100"
    elif opcode == "COP":
        machine_code += "0101"
    elif opcode == "AFC":
        machine_code += "0110"
    elif opcode == "AFCA":
        machine_code += "0111"
    elif opcode == "JMP":
        machine_code += "1000"
    elif opcode == "JMF":
        machine_code += "1001"
    elif opcode == "INF":
        machine_code += "1010"
    elif opcode == "SUP":
        machine_code += "1011"
    elif opcode == "EQU":
        machine_code += "1100"
    elif opcode == "PRI":
        machine_code += "1101"

    for arg in args:
        machine_code += format(arg, "08b")

    return machine_code

def cross_assembler(input_file, output_file):
    with open(input_file, "r") as f_in, open(output_file, "w") as f_out:
        for line in f_in:
            line = line.strip()
            if line:
                parts = line.split()
                opcode = parts[0]
                args = [int(arg) for arg in parts[1:]]
                machine_code = translate_instruction(opcode, args)
                f_out.write(machine_code + "\n")

input_file = "/home/arfa/Bureau/systeme_info/Compilateur/Interpreteur/asm.txt"
output_file = "/home/arfa/Bureau/systeme_info/Compilateur/Interpreteur/machine_code.txt"
cross_assembler(input_file, output_file)

