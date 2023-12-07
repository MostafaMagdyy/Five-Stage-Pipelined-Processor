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
        Protect : OUT STD_LOGIC;
        OutPort : OUT STD_LOGIC
    );
END control_unit;

ARCHITECTURE control_unit_arc OF control_unit IS
    -- signals for DEClartion of the operation
    -- signal R_TYPE		: STD_LOGIC;
    -- signal LD		: STD_LOGIC;
    -- signal SW		: STD_LOGIC;--phase 2 
    -- signal BEQ		: STD_LOGIC;--phase 2 
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
    --signals of the output, only assigned to output if rst not 1

    SIGNAL AluSrc_Signal : STD_LOGIC;
    SIGNAL AluOpCode_Signal : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL MemRead_Signal : STD_LOGIC;
    SIGNAL MemWrite_Signal : STD_LOGIC;
    SIGNAL MemtoReg_Signal : STD_LOGIC;
    SIGNAL RegWrite_Signal : STD_LOGIC;
    SIGNAL Branch_Signal : STD_LOGIC;
    SIGNAL Protect_signal : STD_LOGIC;
    SIGNAL OutPort_signal : STD_LOGIC;
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

    OR_op <= NOT OpCode(4) AND OpCode(3) AND
        NOT OpCode(2) AND OpCode(1) AND OpCode(0);--01011

    STD <= OpCode(4) AND NOT OpCode(3) AND
        OpCode(2) AND NOT OpCode(1) AND OpCode(0);--10101

    PROTECT_op <= '1' WHEN OpCode = "10110" ELSE
        '0';
    OUT_op <= '1' WHEN OpCode = "00101" ELSE
        '0';
    --assign of control signals 
    AluSrc_Signal <= LDM OR ADDI OR LDD;
    AluOpCode_Signal <= x"1" WHEN NOT_op = '1'
        ELSE
        x"4" WHEN DEC = '1'
        ELSE
        x"8" WHEN OR_op = '1'
        ELSE
        x"D" WHEN PROTECT_op = '1'
        ELSE
        x"0";
    MemRead_Signal <= '1' WHEN LDD = '1'
        ELSE
        '0';
    MemWrite_Signal <= '1' WHEN STD = '1'
        ELSE
        '0';
    MemtoReg_Signal <= '1' WHEN LDD = '1'
        ELSE
        '0';
    RegWrite_Signal <= '1' WHEN (NOT_op = '1' OR DEC = '1' OR OR_op = '1' OR STD = '1' OR LDD = '1') ELSE
        '0';
    Branch_Signal <= '0';

    Protect_signal <= '1' WHEN PROTECT_op = '1' ELSE
        '0';
    OutPort_signal <= '1' WHEN OUT_op = '1' ELSE
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
    Protect <= Protect_signal WHEN Rst = '0' ELSE
        '0';
    OutPort <= OutPort_signal WHEN RST = '0' ELSE
        '0';
END control_unit_arc;