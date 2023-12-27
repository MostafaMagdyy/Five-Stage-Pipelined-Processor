
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ID_EX_Reg IS
    PORT (
        en, clk, rst : IN STD_LOGIC;
        ALUsrc_D : IN STD_LOGIC;
        AluOP_D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        MemRead_D : IN STD_LOGIC;
        MemWrite_D : IN STD_LOGIC;
        MemToReg_D : IN STD_LOGIC;
        RegWrite_D : IN STD_LOGIC;
        Branch_D : IN STD_LOGIC;
        OUT_D : IN STD_LOGIC;
        Protect_D : IN STD_LOGIC;
        Free_D : IN STD_LOGIC;
        SP_D : IN STD_LOGIC;
        PUSH_POP_D : IN STD_LOGIC;
        in_D : IN STD_LOGIC;
        RET_CALL_D : IN STD_LOGIC;
        JMP_D : IN STD_LOGIC;
        Rsrc1_num_D : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rsrc2_num_D : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rsrc1_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rsrc2_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Reg_dst_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rdst_D : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        -- definging output

        ALUsrc_Signal : OUT STD_LOGIC;
        ALUsrc_E : OUT STD_LOGIC;
        AluOP_E : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        MemRead_E : OUT STD_LOGIC;
        MemWrite_E : OUT STD_LOGIC;
        MemToReg_E : OUT STD_LOGIC;
        RegWrite_E : OUT STD_LOGIC;
        Branch_E : OUT STD_LOGIC;
        OUT_E : OUT STD_LOGIC;
        Protect_E : OUT STD_LOGIC;
        Free_E : OUT STD_LOGIC;
        SP_E : OUT STD_LOGIC;
        PUSH_POP_E : OUT STD_LOGIC;
        in_E : OUT STD_LOGIC;
        RET_CALL_E : OUT STD_LOGIC;
        JMP_E : OUT STD_LOGIC;
        Rsrc1_num_E : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rsrc2_num_E : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rsrc1_E : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rsrc2_E : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Reg_dst_E : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rdst_E : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Shift_E : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        Immediate_E : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
    );
END ID_EX_Reg;
ARCHITECTURE IdExReg OF ID_EX_Reg IS
    SIGNAL ALUsrc : STD_LOGIC;
BEGIN
    ALUsrc_Signal <= ALUsrc;
    PROCESS (clk, rst) IS
    BEGIN
        IF (rst = '1') THEN
            ALUsrc_E <= '0';
            AluOP_E <= (OTHERS => '0');
            MemRead_E <= '0';
            MemWrite_E <= '0';
            MemToReg_E <= '0';
            RegWrite_E <= '0';
            Branch_E <= '0';
            OUT_E <= '0';
            Protect_E <= '0';
            Free_E <= '0';
            SP_E <= '0';
            PUSH_POP_E <= '0';
            in_E <= '0';
            RET_CALL_E <= '0';
            JMP_E <= '0';
            Rsrc1_num_E <= (OTHERS => '0');
            Rsrc2_num_E <= (OTHERS => '0');
            Rsrc1_E <= (OTHERS => '0');
            Rsrc2_E <= (OTHERS => '0');
            Reg_dst_E <= (OTHERS => '0');
            Rdst_E <= (OTHERS => '0');
            Shift_E <= (OTHERS => '0');
            Immediate_E <= (OTHERS => '0');

        ELSIF (rising_edge(clk) AND en = '1') THEN
            IF (ALUsrc = '1') THEN
                Immediate_E(19 DOWNTO 4) <= instruction;
                ALUsrc <= '0';
            ELSE
                ALUsrc <= ALUsrc_D;
                ALUsrc_E <= ALUsrc_D;
                AluOP_E <= AluOP_D;
                MemRead_E <= MemRead_D;
                MemWrite_E <= MemWrite_D;
                MemToReg_E <= MemToReg_D;
                RegWrite_E <= RegWrite_D;
                Branch_E <= Branch_D;
                OUT_E <= OUT_D;
                Protect_E <= Protect_D;
                Free_E <= Free_D;
                SP_E <= SP_D;
                PUSH_POP_E <= PUSH_POP_D;
                in_E <= in_D;
                RET_CALL_E <= RET_CALL_D;
                JMP_E <= JMP_D;
                Rsrc1_num_E <= Rsrc1_num_D;
                Rsrc2_num_E <= Rsrc2_num_D;
                Rsrc1_E <= Rsrc1_D;
                Rsrc2_E <= Rsrc2_D;
                Reg_dst_E <= Reg_dst_D;
                Rdst_E <= Rdst_D;
                Shift_E <= instruction (4 DOWNTO 0);
                Immediate_E(3 DOWNTO 0) <= instruction(4 DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;
END IdEXReg;