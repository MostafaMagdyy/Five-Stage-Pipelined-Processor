no_op_instr = {
    "NOP":  0b00000,
    "RET":  0b11011,
    "RTI":  0b11100,
}

one_op_instr = {
    "NOT":      0b00001,
    "NEG":      0b00010,
    "INC":      0b00011,
    "DEC":      0b00100,
    "PUSH":     0b10001,
    "POP":      0b10010,
    "PROTECT":  0b10110,
    "FREE":     0b10111,
    "JZ":       0b11000,
    "JMP":      0b11001,
    "CALL":     0b11010,
    "IN":       0b00110,
    "OUT":      0b00101,
}

two_op_instr = {
    "ADD":      0b00111,
    "SUB":      0b01001,
    "SWAP":     0b10000,
    "CMP":      0b01101,
    "AND":      0b01010,
    "OR":       0b01011,
    "XOR":      0b01100,
}

bits_instr = {
    "BITSET":   0b01110,
    "RCL":      0b01111,
    "RCR":      0b10000,
}

eff_addr_instr = {
    "ADDI":     0b01000,
    "LDM":      0b10011,
    "LDD":      0b10100,
    "STD":      0b10101,
}

opcodes = {
    **no_op_instr,
    **one_op_instr,
    **two_op_instr,
    **eff_addr_instr,
    **bits_instr
}

gen_purpose_regs = {
    "R0": 0b000,
    "R1": 0b001,
    "R2": 0b010,
    "R3": 0b011,
    "R4": 0b100,
    "R5": 0b101,
    "R6": 0b110,
    "R7": 0b111,
}

regs = {
    **gen_purpose_regs,
}

OPCODE_SHIFT = 11
RD_SHIFT = 8
RS1_SHIFT = 5
RS2_SHIFT = 2

def convert_to_decimal(hex_val):
    return int(hex_val, 16)

def assemble_no_op_instr(opcode):
    opcode_val = no_op_instr[opcode]

    mach_code = (opcode_val << OPCODE_SHIFT)
    return [mach_code]


def assemble_one_op_instr(opcode, Rd):
    Rd_val = regs.get(Rd, None)

    if Rd_val is None:
        raise ValueError(f"Unknown register: {Rd} for opcode: {opcode}")

    opcode_val = one_op_instr[opcode]

    mach_code = (opcode_val << OPCODE_SHIFT) | (Rd_val << RD_SHIFT) | (Rd_val << RS1_SHIFT)
    return [mach_code]


def assemble_two_op_instr(opcode, Rd, Rs1, Rs2):
    Rd_val = regs.get(Rd, None)
    Rs1_val = regs.get(Rs1, None)
    Rs2_val = regs.get(Rs2, None)

    if Rd_val is None:
        raise ValueError(f"Unknown register: {Rd} for opcode: {opcode}")
    elif Rs1_val is None:
        raise ValueError(f"Unknown register: {Rs1} for opcode: {opcode}")
    elif Rs2_val is None:
        raise ValueError(f"Unknown register: {Rs2} for opcode: {opcode}")

    opcode_val = two_op_instr[opcode]

    mach_code = (opcode_val << OPCODE_SHIFT) | (Rd_val << RD_SHIFT) | (
        Rs1_val << RS1_SHIFT) | (Rs2_val << RS2_SHIFT)
    return [mach_code]


def assemble_bits_instr(opcode, Rd, immediate):
    Rd_val = regs.get(Rd, None)

    if Rd_val is None:
        raise ValueError(f"Unknown register: {Rd} for opcode: {opcode}")

    opcode_val = bits_instr[opcode]
    immediate=convert_to_decimal(immediate)
    mach_code1 = (opcode_val << OPCODE_SHIFT) | (Rd_val << RD_SHIFT) | (Rd_val << RS1_SHIFT) | (immediate % 32)
    return [mach_code1]



def assemble_eff_addr_instr(opcode, Rd, Rs, EA):
    Rd_val = regs.get(Rd, None)
    Rs_val = regs.get(Rs, None)

    if Rd_val is None:
        raise ValueError(f"Unknown register: {Rd} for opcode: {opcode}")

    opcode_val = eff_addr_instr[opcode]
    EA=convert_to_decimal(EA)
    mach_code1 = (opcode_val << OPCODE_SHIFT) | (
        Rd_val << RD_SHIFT) | (Rs_val << RS1_SHIFT) | (((EA&0xf0000)>> 16) << 1)
    mach_code2 = EA
    return [mach_code1, mach_code2]


def check_segments_size(len,correct):
    if(len!=correct):
        raise ValueError("this instruction has "+str(len-correct)+" more segments than required") 

input_file_path = input("please input instruction input file name: ") 
output_file_path = input("please input instruction output file name: ")

# input_file_path = "ISA.txt" 
# output_file_path = "Test.txt"

lineNum=0   
curInstrcution=""
try:
    if(input_file_path==output_file_path):
        raise ValueError("you can't have input and output file have the same name")
    with open(input_file_path, "r") as input_file, open(output_file_path, "w") as output_file:
        for line in input_file:
            lineNum+=1

            line =curInstrcution= line.strip().upper()

            if not line:
                continue

            segments = line.split()

            if not segments:
                continue

            opcode = segments[0]
            machine_codes = None
            if opcode in no_op_instr:
                check_segments_size(len(segments),1)
                machine_codes = assemble_no_op_instr(opcode)
            elif opcode in one_op_instr:
                check_segments_size(len(segments),2)
                machine_codes = assemble_one_op_instr(
                    opcode, segments[1])
            elif opcode in two_op_instr:
                check_segments_size(len(segments),4)
                machine_codes = assemble_two_op_instr(
                    opcode, segments[1], segments[2], segments[3])
            elif opcode in bits_instr:
                check_segments_size(len(segments),3)
                machine_codes = assemble_bits_instr(
                    opcode, segments[1], (segments[2]))
            elif opcode in eff_addr_instr:
                if opcode == "ADDI":
                    check_segments_size(len(segments),4)
                    machine_codes = assemble_eff_addr_instr(
                        opcode, segments[1], segments[2], (segments[3]))
                else:
                    check_segments_size(len(segments),3)
                    machine_codes = assemble_eff_addr_instr(
                        opcode, segments[1], segments[1], (segments[2]))
            else:
                raise ValueError(f"Unknown opcode: {opcode}")

            for machine_code in machine_codes:
                sixteen_bit_representation = machine_code & 0xFFFF 
                binary_sixteen_bits = bin(sixteen_bit_representation)[2:].zfill(16)  # Convert to binary and pad to 16 bits
                # print(f"{binary_sixteen_bits}")  # Print the 16-bit binary string
                output_file.write(f"{binary_sixteen_bits}\n")  # Write the 16-bit binary string to an output file
            
    print(f"\033[92m\nInstructions assembled successfully in\033[0m {output_file_path}")
except Exception as e:
    print(f"\nAn error occurred: {e}")
    if(lineNum):
        print(f"error in instrcution number {lineNum}\n\n\033[91m{curInstrcution}\033[0m")