LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY CPU IS
    PORT (
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        IN_PORT : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        OUT_PORT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0')
    );
END CPU;

ARCHITECTURE CPU_arc OF CPU IS

    SIGNAL PC : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL instruction : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL instruction_D : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL op_code : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL R_dest : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL R_src1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL R_src2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Extra_EFA : STD_LOGIC_VECTOR(3 DOWNTO 0);

    --RegFile
    SIGNAL ReadData1_D : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL ReadData2_D : STD_LOGIC_VECTOR (31 DOWNTO 0);

    --control unit
    SIGNAL AluSrc : STD_LOGIC;
    SIGNAL AluOpCode : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL MemRead : STD_LOGIC;
    SIGNAL MemWrite : STD_LOGIC;
    SIGNAL MemtoReg : STD_LOGIC;
    SIGNAL RegWrite : STD_LOGIC;
    SIGNAL Branch : STD_LOGIC;
    SIGNAL OUT_D : STD_LOGIC;
    SIGNAL Protect : STD_LOGIC;

    SIGNAL ControlReset : STD_LOGIC;

    --ID-EX Reg

    SIGNAL ALUsrc_E : STD_LOGIC;
    SIGNAL AluOP_E : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL MemRead_E : STD_LOGIC;
    SIGNAL MemWrite_E : STD_LOGIC;
    SIGNAL Protect_E : STD_LOGIC;
    SIGNAL MemToReg_E : STD_LOGIC;
    SIGNAL RegWrite_E : STD_LOGIC;
    SIGNAL Branch_E : STD_LOGIC;
    SIGNAL OUT_E : STD_LOGIC;
    SIGNAL Rsrc1_E : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Rsrc2_E : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL extra_EA_E : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Rdst_E : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- ALU

    SIGNAL Result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Zero, Carry, Neg : STD_LOGIC;
    -- EX_MEM reg

    SIGNAL Rdst_M : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL AluOut_M : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL EA_M : STD_LOGIC_VECTOR(19 DOWNTO 0);
    SIGNAL MemRead_M : STD_LOGIC;
    SIGNAL MemWrite_M : STD_LOGIC;
    SIGNAL Protect_M : STD_LOGIC;
    SIGNAL MemToReg_M : STD_LOGIC;
    SIGNAL RegWrite_M : STD_LOGIC;
    SIGNAL Branch_M : STD_LOGIC;

    --
    SIGNAL memory_address : STD_LOGIC_VECTOR (11 DOWNTO 0);

    SIGNAL EA_E_in : STD_LOGIC_VECTOR(19 DOWNTO 0);
    --data memory
    SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- MEM_WB
    SIGNAL Rdst_WB : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL AluOut_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL MemOut_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL MemToReg_WB : STD_LOGIC;
    SIGNAL RegWrite_WB : STD_LOGIC;

    SIGNAL RegWriteData : STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN

    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            PC <= (OTHERS => '0');
            OUT_PORT <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            PC <= STD_LOGIC_VECTOR(unsigned(PC) + 1);
            IF (out_E = '1') THEN
                OUT_PORT <= Rsrc1_E;
            END IF;
        END IF;

    END PROCESS;
    --

    ControlReset <= '1' WHEN ALUsrc_E = '1' OR rst = '1' ELSE
        '0';
    instruction_memory : ENTITY work.InstructionMemory PORT MAP (address => PC (11 DOWNTO 0), instruction => instruction);
    IF_ID : ENTITY work.FethcDecode PORT MAP(rst => rst, clk => clk, instruction => instruction, instruction_out => instruction_D
        , op_code => op_code, R_dest => R_dest, R_src1 => R_src1, R_src2 => R_src2, Extra_EFA => Extra_EFA);
    RegWriteData <= AluOut_WB WHEN MemToReg_WB = '0' ELSE
        MemOut_WB;

    reg_file : ENTITY work.register_file PORT MAP (Clk => clk, Rst => rst,
        RegWrite => RegWrite_WB, WriteRegister => Rdst_WB, WriteData => RegWriteData, ReadRegister1 => R_src1,
        ReadRegister2 => R_src2, ReadData1 => ReadData1_D, ReadData2 => ReadData2_D);
    Control_unit : ENTITY work.control_unit PORT MAP (Rst => ControlReset, OpCode => op_code,
        AluSrc => AluSrc, AluOpCode => AluOpCode, MemRead => MemRead, MemWrite => MemWrite,
        MemtoReg => MemtoReg, RegWrite => RegWrite, Branch => Branch, Protect => Protect,
        OutPort => OUT_D
        );
    ID_EX : ENTITY work.ID_EX_Reg PORT MAP(en => '1', clk => clk, rst => rst,
        ALUsrc_D => AluSrc, AluOP_D => AluOpCode, MemRead_D => MemRead, MemWrite_D => MemWrite,
        Protect_D => Protect, MemToReg_D => MemtoReg, RegWrite_D => RegWrite, Branch_D => Branch,
        OUT_D => OUT_D, Rsrc1_D => ReadData1_D, Rsrc2_D => ReadData2_D, extra_EA_D => Extra_EFA, Rdst_D => R_dest,
        ALUsrc_E => ALUsrc_E, AluOP_E => AluOP_E, MemRead_E => MemRead_E, MemWrite_E => MemWrite_E,
        Protect_E => Protect_E, MemToReg_E => MemToReg_E, RegWrite_E => RegWrite_E, Branch_E => Branch_E,
        OUT_E => OUT_E, Rsrc1_E => Rsrc1_E, Rsrc2_E => Rsrc2_E, extra_EA_E => extra_EA_E, Rdst_E => Rdst_E
        );

    ALU : ENTITY work.alu_32bit PORT MAP(reset => rst, alu_en => '1', A => Rsrc1_E, B => Rsrc2_E,
        ALUOp => AluOP_E, Result => Result, Zero => Zero, Carry => Carry, Neg => Neg
        );
    EA_E_in <= instruction_D & extra_EA_E;

    EX_MEM : ENTITY work.EX_MEM_Reg PORT MAP(en => '1', clk => clk, rst => rst, Rdst_E => Rdst_E, AluOut_E => Result,
        EA_E => EA_E_in, MemRead_E => MemRead_E, MemWrite_E => MemWrite_E, Protect_E => Protect_E,
        MemToReg_E => MemToReg_E, RegWrite_E => RegWrite_E, Branch_E => Branch_E,
        Rdst_M => Rdst_M, AluOut_M => AluOut_M, EA_M => EA_M,
        MemRead_M => MemRead_M, MemWrite_M => MemWrite_M, Protect_M => Protect_M,
        MemToReg_M => MemToReg_M, RegWrite_M => RegWrite_M, Branch_M => Branch_M
        );

    memory_address <= AluOut_M(11 DOWNTO 0) WHEN Protect_M = '1' ELSE
        EA_M (11 DOWNTO 0);

    DataMemory : ENTITY work.DataMemory PORT MAP(rst => rst, clk => clk, address => memory_address, data_in => x"00000000",
        write_enable => MemWrite_M, read_enable => MemRead_M, data_out => data_out, protect_sig => Protect_M
        );

    MEM_WB : ENTITY work.MEM_WB_Reg PORT MAP(en => '1', clk => clk, rst => rst, Rdst_M => Rdst_M,
        AluOut_M => AluOut_M, MemOut_M => data_out, MemToReg_M => MemToReg_M, RegWrite_M => RegWrite_M,
        Rdst_WB => Rdst_WB, AluOut_WB => AluOut_WB, MemOut_WB => MemOut_WB, MemToReg_WB => MemToReg_WB,
        RegWrite_WB => RegWrite_WB);
END CPU_arc;