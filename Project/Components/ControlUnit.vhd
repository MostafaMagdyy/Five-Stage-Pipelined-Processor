LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY control_unit IS
    PORT (
        Rst : IN STD_LOGIC;
        OpCode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        AluSrc : OUT STD_LOGIC;
        AluOpCode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        MemRead : OUT STD_LOGIC;
        MemWrite : OUT STD_LOGIC;
        MemtoReg : OUT STD_LOGIC;
        RegWrite : OUT STD_LOGIC;
        Branch : OUT STD_LOGIC;
        JMP_inst : OUT STD_LOGIC;
        OutPort : OUT STD_LOGIC;
        Protect : OUT STD_LOGIC;
        FREE_inst : OUT STD_LOGIC;
        SP : OUT STD_LOGIC;
        PopPush : OUT STD_LOGIC;
        IN_inst : OUT STD_LOGIC;
        RetCall : OUT STD_LOGIC
    );
END control_unit;

ARCHITECTURE control_unit_arc OF control_unit IS
    SIGNAL LDM : STD_LOGIC;--phase 2 
    SIGNAL ADDI : STD_LOGIC;--phase 2 
    SIGNAL LDD : STD_LOGIC;--phase 2 
    SIGNAL CMP : STD_LOGIC;
    SIGNAL NOT_op : STD_LOGIC;
    SIGNAL DEC : STD_LOGIC;
    SIGNAL OR_op : STD_LOGIC;
    SIGNAL STD : STD_LOGIC;
    SIGNAL PROTECT_op : STD_LOGIC;
    SIGNAL OUT_op : STD_LOGIC;

    -- this is phase 3 instructions 
    SIGNAL INC : STD_LOGIC;
    SIGNAL ADD : STD_LOGIC;
    SIGNAL SUB : STD_LOGIC;
    SIGNAL AND_op : STD_LOGIC;
    SIGNAL XOR_op : STD_LOGIC;
    SIGNAL BITSET : STD_LOGIC;
    SIGNAL RCL : STD_LOGIC;
    SIGNAL RCR : STD_LOGIC;
    SIGNAL PUSH : STD_LOGIC;
    SIGNAL POP : STD_LOGIC;
    SIGNAL FREE : STD_LOGIC;
    SIGNAL JZ : STD_LOGIC;
    SIGNAL JMP : STD_LOGIC;
    SIGNAL CALL : STD_LOGIC;
    SIGNAL RET : STD_LOGIC;
    SIGNAL RTI : STD_LOGIC;
    SIGNAL IN_op : STD_LOGIC;
    SIGNAL NEG : STD_LOGIC;
    --signals of the output, only assigned to output if rst not 1

    SIGNAL AluSrc_Signal : STD_LOGIC;
    SIGNAL AluOpCode_Signal : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL MemRead_Signal : STD_LOGIC;
    SIGNAL MemWrite_Signal : STD_LOGIC;
    SIGNAL MemtoReg_Signal : STD_LOGIC;
    SIGNAL RegWrite_Signal : STD_LOGIC;
    SIGNAL Branch_Signal : STD_LOGIC;
    SIGNAL JMP_Signal : STD_LOGIC;
    SIGNAL OutPort_signal : STD_LOGIC;
    SIGNAL Protect_signal : STD_LOGIC;
    SIGNAL FREE_signal : STD_LOGIC;
    SIGNAL SP_signal : STD_LOGIC;
    SIGNAL PopPush_signal : STD_LOGIC;
    SIGNAL IN_signal : STD_LOGIC;
    SIGNAL RetCall_signal : STD_LOGIC;
BEGIN
    LDM <= OpCode(4) AND NOT OpCode(3) AND
        NOT OpCode(2) AND OpCode(1) AND OpCode(0);--10011 
    ADDI <= NOT OpCode(4) AND OpCode(3) AND
        NOT OpCode(2) AND NOT OpCode(1) AND NOT OpCode(0); --01000 
    LDD <= OpCode(4) AND NOT OpCode(3) AND
        OpCode(2) AND NOT OpCode(1) AND NOT OpCode(0);--10100
    CMP <= NOT OpCode(4) AND OpCode(3) AND
        OpCode(2) AND NOT OpCode(1) AND OpCode(0);--01101

    NOT_op <= NOT OpCode(4) AND NOT OpCode(3) AND
        NOT OpCode(2) AND NOT OpCode(1) AND OpCode(0); --00001

    DEC <= NOT OpCode(4) AND NOT OpCode(3) AND
        OpCode(2) AND NOT OpCode(1) AND NOT OpCode(0);--00100

    INC <= '1' WHEN OpCode = "00011" ELSE
        '0';

    OR_op <= NOT OpCode(4) AND OpCode(3) AND
        NOT OpCode(2) AND OpCode(1) AND OpCode(0);--01011

    STD <= OpCode(4) AND NOT OpCode(3) AND
        OpCode(2) AND NOT OpCode(1) AND OpCode(0);--10101

    PROTECT_op <= '1' WHEN OpCode = "10110" ELSE
        '0';
    OUT_op <= '1' WHEN OpCode = "00101" ELSE
        '0';
    ADD <= '1' WHEN OpCode = "00111" ELSE
        '0';
    NEG <= '1' WHEN OpCode = "00010" ELSE
        '0';
    IN_op <= '1' WHEN OpCode = "00110" ELSE
        '0';
    SUB <= '1' WHEN OpCode = "01001" ELSE
        '0';
    AND_op <= '1' WHEN OpCode = "01010" ELSE
        '0';
    XOR_op <= '1' WHEN OpCode = "01100" ELSE
        '0';
    CMP <= '1' WHEN OpCode = "01101" ELSE
        '0';
    BITSET <= '1' WHEN OpCode = "01110" ELSE
        '0';
    RCL <= '1' WHEN OpCode = "01111" ELSE
        '0';
    RCR <= '1' WHEN OpCode = "10000" ELSE
        '0';
    PUSH <= '1' WHEN OpCode = "10001" ELSE
        '0';
    POP <= '1' WHEN OpCode = "10010" ELSE
        '0';
    FREE <= '1' WHEN OpCode = "10111" ELSE
        '0';
    JZ <= '1' WHEN OpCode = "11000" ELSE
        '0';
    JMP <= '1' WHEN OpCode = "11001" ELSE
        '0';
    CALL <= '1' WHEN OpCode = "11010" ELSE
        '0';
    RET <= '1' WHEN OpCode = "11011" ELSE
        '0';
    RTI <= '1' WHEN OpCode = "11100" ELSE
        '0';
    --assign of control signals 
    AluSrc_Signal <= '1' WHEN (ADDI = '1' OR LDM = '1' OR LDD = '1' OR STD = '1') ELSE
        '0';
    AluOpCode_Signal <= x"1" WHEN NOT_op = '1'
        ELSE
        x"2" WHEN NEG = '1'
        ELSE
        x"3" WHEN INC = '1'
        ELSE
        x"4" WHEN DEC = '1'
        ELSE
        x"0" WHEN OUT_op = '1'
        ELSE
        x"0" WHEN IN_op = '1'
        ELSE
        x"5" WHEN ADD = '1'
        ELSE
        x"5" WHEN ADDI = '1'
        ELSE
        x"6" WHEN SUB = '1'
        ELSE
        x"7" WHEN AND_op = '1'
        ELSE
        x"8" WHEN OR_op = '1'
        ELSE
        x"9" WHEN XOR_op = '1'
        ELSE
        x"6" WHEN CMP = '1'
        ELSE
        x"A" WHEN BITSET = '1'
        ELSE
        x"B" WHEN RCL = '1'
        ELSE
        x"C" WHEN RCR = '1'
        ELSE
        x"0" WHEN PUSH = '1'
        ELSE
        x"0" WHEN POP = '1'
        ELSE
        x"0" WHEN LDM = '1'
        ELSE
        x"0" WHEN LDD = '1'
        ELSE
        x"0" WHEN STD = '1'
        ELSE
        x"0" WHEN PROTECT_op = '1'
        ELSE
        x"0" WHEN FREE = '1'
        ELSE
        x"0" WHEN JZ = '1'
        ELSE
        x"0" WHEN JMP = '1'
        ELSE
        x"0" WHEN CALL = '1'
        ELSE
        x"0" WHEN RET = '1'
        ELSE
        x"0" WHEN RTI = '1'
        ELSE
        x"0";--this is for NO OP operation
    MemRead_Signal <= '1' WHEN (POP = '1' OR LDD = '1' OR RET = '1' OR RTI = '1')
        ELSE
        '0';
    MemWrite_Signal <= '1' WHEN (PUSH = '1' OR STD = '1' OR CALL = '1')
        ELSE
        '0';
    MemtoReg_Signal <= '1' WHEN LDD = '1'
        ELSE
        '0';
    RegWrite_Signal <= '1' WHEN (NOT_op = '1' OR NEG = '1' OR INC = '1' OR DEC = '1' OR ADD = '1' OR
        ADDI = '1' OR SUB = '1' OR AND_op = '1' OR
        OR_op = '1' OR XOR_op = '1' OR
        BITSET = '1' OR RCL = '1' OR RCR = '1' OR
        POP = '1' OR LDD = '1' OR RET = '1' OR
        IN_op='1' OR
        RET = '1' OR RTI = '1') ELSE
        '0';
    Branch_Signal <= '1' WHEN JZ = '1' ELSE
        '0';
    JMP_SIGNAL <= '1' WHEN JMP = '1' ELSE
        '0';
    OutPort_signal <= '1' WHEN OUT_op = '1' ELSE
        '0';
    Protect_signal <= '1' WHEN PROTECT_op = '1' ELSE
        '0';
    FREE_signal <= '1' WHEN FREE = '1' ELSE
        '0';
    SP_signal <= '1' WHEN (PUSH = '1' OR POP = '1' OR CALL = '1' OR RET = '1' OR RTI = '1') ELSE
        '0';
    PopPush_signal <= '1' WHEN (PUSH = '1' OR CALL = '1') ELSE
        '0';
    IN_signal <= '1' WHEN (IN_op = '1') ELSE
        '0';
    RetCall_signal <= '1' WHEN (CALL = '1' OR RET = '1' OR RTI = '1') ELSE
        '0';
    -- assigning the out signals

    AluSrc <= AluSrc_Signal WHEN Rst = '0' ELSE
        '0';
    AluOpCode <= AluOpCode_Signal WHEN Rst = '0' ELSE
        x"0";
    MemRead <= MemRead_Signal WHEN Rst = '0' ELSE
        '0';
    MemWrite <= MemWrite_Signal WHEN Rst = '0' ELSE
        '0';
    MemtoReg <= MemtoReg_Signal WHEN Rst = '0' ELSE
        '0';
    RegWrite <= RegWrite_Signal WHEN Rst = '0' ELSE
        '0';
    Branch <= Branch_Signal WHEN Rst = '0' ELSE
        '0';
    JMP_inst <= JMP_SIGNAL WHEN Rst = '0' ELSE
        '0';
    OutPort <= OutPort_signal WHEN RST = '0' ELSE
        '0';
    Protect <= Protect_signal WHEN Rst = '0' ELSE
        '0';
    FREE_inst <= FREE_signal WHEN RST = '0' ELSE
        '0';
    SP <= SP_signal WHEN RST = '0' ELSE
        '0';
    PopPush <= PopPush_signal WHEN RST = '0' ELSE
        '0';
    IN_inst <= IN_signal WHEN RST = '0' ELSE
        '0';
    RetCall <= RetCall_signal WHEN RST = '0' ELSE
        '0';
END control_unit_arc;