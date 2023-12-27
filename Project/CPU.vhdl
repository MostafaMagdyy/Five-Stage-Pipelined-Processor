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
    SIGNAL OUT1_Sel : STD_LOGIC;
    SIGNAL OUT2_Sel : STD_LOGIC;
    SIGNAL OUT1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL OUT2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);

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
    SIGNAL JMP_inst : STD_LOGIC;
    SIGNAL OUT_D : STD_LOGIC;
    SIGNAL Protect : STD_LOGIC;
    SIGNAL FREE_inst : STD_LOGIC;
    SIGNAL SP : STD_LOGIC;
    SIGNAL PopPush : STD_LOGIC;
    SIGNAL IN_inst : STD_LOGIC;
    SIGNAL RetCall : STD_LOGIC;

    SIGNAL ControlReset : STD_LOGIC;

    --ID-EX Reg

    SIGNAL ALUsrc_E : STD_LOGIC;
    SIGNAL AluOP_E : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL MemRead_E : STD_LOGIC;
    SIGNAL MemWrite_E : STD_LOGIC;
    SIGNAL MemToReg_E : STD_LOGIC;
    SIGNAL RegWrite_E : STD_LOGIC;
    SIGNAL Branch_E : STD_LOGIC;
    SIGNAL OUT_E : STD_LOGIC;
    SIGNAL Protect_E : STD_LOGIC;
    SIGNAL Free_E : STD_LOGIC;
    SIGNAL SP_E : STD_LOGIC;
    SIGNAL PUSH_POP_E : STD_LOGIC;
    SIGNAL in_E : STD_LOGIC;
    SIGNAL RET_CALL_E : STD_LOGIC;
    SIGNAL JMP_E : STD_LOGIC;
    SIGNAL Rsrc1_num_E : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Rsrc2_num_E : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Rsrc1_E : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Rsrc2_E : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Reg_dst_E : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Rdst_E : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Shift_E : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Immediate_E : STD_LOGIC_VECTOR(19 DOWNTO 0);
    -- ALU

    SIGNAL Result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Zero_Alu, Carry_Alu, Neg_Alu : STD_LOGIC;
    SIGNAL Zero_Reg, Carry_Reg, Neg_Reg : STD_LOGIC;
    -- EX_MEM reg

    SIGNAL Rdst_M : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL AluOut_M : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL EA_M : STD_LOGIC_VECTOR(19 DOWNTO 0);

    SIGNAL MemRead_M : STD_LOGIC;
    SIGNAL MemWrite_M : STD_LOGIC;
    SIGNAL MemToReg_M : STD_LOGIC;
    SIGNAL RegWrite_M : STD_LOGIC;
    SIGNAL Branch_M : STD_LOGIC;
    SIGNAL Protect_M : STD_LOGIC;
    SIGNAL Free_M : STD_LOGIC;
    SIGNAL SP_M : STD_LOGIC;
    SIGNAL PUSH_POP_M : STD_LOGIC;
    SIGNAL in_M : STD_LOGIC;
    SIGNAL RET_CALL_M : STD_LOGIC;
    SIGNAL zero_flag_M : STD_LOGIC;
    SIGNAL Reg_dst_M : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --
    SIGNAL memory_address : STD_LOGIC_VECTOR (11 DOWNTO 0);

    --data memory
    SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL ALU_IN_M : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- MEM_WB
    SIGNAL Rdst_WB : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL AluOut_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL MemOut_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL MemToReg_WB : STD_LOGIC;
    SIGNAL RegWrite_WB : STD_LOGIC;
    SIGNAL in_WB : STD_LOGIC;

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
        , op_code => op_code, R_dest => R_dest, R_src1 => R_src1, R_src2 => R_src2);
    RegWriteData <= AluOut_WB WHEN MemToReg_WB = '0' ELSE
        MemOut_WB;
    --
    flag_register : ENTITY work.flag_register PORT MAP (en => '1', clk => clk, rst => rst,
        zero_in => Zero_Alu, carry_in => Carry_Alu, neg_in => Neg_Alu,
        zero_out => Zero_Reg, carry_out => Carry_Reg, neg_out => Neg_Reg
        );
    --
    reg_file : ENTITY work.register_file PORT MAP (Clk => clk, Rst => rst,
        RegWrite => RegWrite_WB, WriteRegister => Rdst_WB, WriteData => RegWriteData, ReadRegister1 => R_src1,
        ReadRegister2 => R_src2, ReadData1 => ReadData1_D, ReadData2 => ReadData2_D);
    --
    Control_unit : ENTITY work.control_unit PORT MAP (Rst => ControlReset, OpCode => op_code,
        AluSrc => AluSrc, AluOpCode => AluOpCode, MemRead => MemRead, MemWrite => MemWrite,
        MemtoReg => MemtoReg, RegWrite => RegWrite, Branch => Branch, JMP_inst => JMP_inst,
        OutPort => OUT_D, Protect => Protect, FREE_inst => FREE_inst, SP => SP, PopPush => PopPush,
        IN_inst => IN_inst, RetCall => RetCall
        );

    --
    ID_EX : ENTITY work.ID_EX_Reg PORT MAP(en => '1', clk => clk, rst => rst,
        ALUsrc_D => AluSrc, AluOP_D => AluOpCode, MemRead_D => MemRead, MemWrite_D => MemWrite, MemToReg_D => MemtoReg,
        RegWrite_D => RegWrite, Branch_D => Branch, OUT_D => OUT_D, Protect_D => Protect,
        Free_D => FREE_inst, SP_D => SP, PUSH_POP_D => PopPush, in_D => IN_inst, RET_CALL_D => RetCall,
        JMP_D => JMP_inst, Rsrc1_num_D => R_src1, Rsrc2_num_D => R_src2, Rsrc1_D => ReadData1_D, Rsrc2_D => ReadData2_D, Reg_dst_D => (OTHERS => '1'), Rdst_D => R_dest,
        instruction => instruction,
        --outputs
        ALUsrc_E => ALUsrc_E, AluOP_E => AluOP_E, MemRead_E => MemRead_E, MemWrite_E => MemWrite_E,
        MemToReg_E => MemToReg_E, RegWrite_E => RegWrite_E, Branch_E => Branch_E,
        OUT_E => OUT_E, Protect_E => Protect_E, Free_E => Free_E, SP_E => SP_E, PUSH_POP_E => PUSH_POP_E,
        in_E => in_E, RET_CALL_E => RET_CALL_E, JMP_E => JMP_E, Rsrc1_num_E => Rsrc1_num_E, Rsrc2_num_E => Rsrc2_num_E,
        Rsrc1_E => Rsrc1_E, Rsrc2_E => Rsrc2_E, Reg_dst_E => Reg_dst_E, Rdst_E => Rdst_E, Shift_E => Shift_E,
        Immediate_E => Immediate_E
        );
    A <= Rsrc1_E WHEN OUT1_Sel = '0' ELSE
        OUT1;
    B <= (x"0000" & Immediate_E(19 DOWNTO 4))WHEN ALUsrc_E = '1'ELSE
        Rsrc2_E WHEN OUT2_Sel = '0' ELSE
        OUT2;
    ALU : ENTITY work.alu_32bit PORT MAP(rst => rst, alu_en => '1',
        A => A, B => B,
        ALUOp => AluOP_E,
        Shift => Shift_E,
        zero_in => Zero_Reg, carry_in => Carry_Reg, neg_in => Neg_Reg,
        zero_out => Zero_Alu, carry_out => Carry_Alu, neg_out => Neg_Alu,
        Result => Result
        );
    --

    FORWARDING_UNIT : ENTITY work.Data_Forwarding PORT MAP(clk => clk,
        RSrc1 => Rsrc1_num_E, Rsrc2 => Rsrc2_num_E,
        ALU_WB => RegWrite_M, MeM_WB => RegWrite_WB,
        R_dstALU => Rdst_M, R_dstMemory => Rdst_WB,
        R_dstALUValue => ALU_IN_M, R_dstMemoryValue => RegWriteData,
        OUT1_Sel => OUT1_Sel, OUT2_Sel => OUT2_Sel, OUT1 => OUT1, OUT2 => OUT2
        );

    --
    EX_MEM : ENTITY work.EX_MEM_Reg PORT MAP(en => '1', clk => clk, rst => rst, Rdst_E => Rdst_E, AluOut_E => Result,
        EA_E =>Immediate_E , MemRead_E => MemRead_E, MemWrite_E => MemWrite_E,
        MemToReg_E => MemToReg_E, RegWrite_E => RegWrite_E, Branch_E => Branch_E,
        Protect_E => Protect_E, Free_E => Free_E, SP_E => SP_E, PUSH_POP_E => PUSH_POP_E, in_E => in_E,
        RET_CALL_E => RET_CALL_E, JMP_E => JMP_E, zero_flag_E => Zero_Reg, Reg_dst_E => Reg_dst_E,
        --
        Rdst_M => Rdst_M, AluOut_M => AluOut_M, EA_M => EA_M,
        MemRead_M => MemRead_M, MemWrite_M => MemWrite_M,
        MemToReg_M => MemToReg_M, RegWrite_M => RegWrite_M, Branch_M => Branch_M,
        Protect_M => Protect_M, Free_M => Free_M, SP_M => SP_M, PUSH_POP_M => PUSH_POP_M,
        in_M => in_M, RET_CALL_M => RET_CALL_M, zero_flag_M => zero_flag_M, Reg_dst_M => Reg_dst_M
        );

    ALU_IN_M <= AluOut_M WHEN in_M = '0' ELSE
        IN_PORT;

    memory_address <= AluOut_M(11 DOWNTO 0) WHEN Protect_M = '1' ELSE
        EA_M (11 DOWNTO 0);

    DataMemory : ENTITY work.DataMemory PORT MAP(rst => rst, clk => clk, address => memory_address, data_in => x"00000000",
        write_enable => MemWrite_M, read_enable => MemRead_M, data_out => data_out, protect_sig => Protect_M,
        SP_Write => SP_M, Push_Pop => PUSH_POP_M, free_sig => Free_M
        );

    MEM_WB : ENTITY work.MEM_WB_Reg PORT MAP(en => '1', clk => clk, rst => rst, Rdst_M => Rdst_M,
        AluOut_M => ALU_IN_M, MemOut_M => data_out, MemToReg_M => MemToReg_M, RegWrite_M => RegWrite_M,
        in_M => in_M,
        Rdst_WB => Rdst_WB, AluOut_WB => AluOut_WB, MemOut_WB => MemOut_WB, MemToReg_WB => MemToReg_WB,
        RegWrite_WB => RegWrite_WB, in_WB => in_WB);
END CPU_arc;