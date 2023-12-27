
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EX_MEM_Reg IS
    PORT (
        en, clk, rst : IN STD_LOGIC;
        Rdst_E : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        AluOut_E : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        EA_E : IN STD_LOGIC_VECTOR(19 DOWNTO 0);

        MemRead_E : IN STD_LOGIC;
        MemWrite_E : IN STD_LOGIC;
        MemToReg_E : IN STD_LOGIC;
        RegWrite_E : IN STD_LOGIC;
        Branch_E : IN STD_LOGIC;
        Protect_E : IN STD_LOGIC;
        Free_E : IN STD_LOGIC;
        SP_E : IN STD_LOGIC;
        PUSH_POP_E : IN STD_LOGIC;
        in_E : IN STD_LOGIC;
        RET_CALL_E : IN STD_LOGIC;
        JMP_E : IN STD_LOGIC;
        zero_flag_E : IN STD_LOGIC;
        Reg_dst_E : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- defining output

        Rdst_M : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        AluOut_M : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        EA_M : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);

        MemRead_M : OUT STD_LOGIC;
        MemWrite_M : OUT STD_LOGIC;
        MemToReg_M : OUT STD_LOGIC;
        RegWrite_M : OUT STD_LOGIC;
        Branch_M : OUT STD_LOGIC;
        Protect_M : OUT STD_LOGIC;
        Free_M : OUT STD_LOGIC;
        SP_M : OUT STD_LOGIC;
        PUSH_POP_M : OUT STD_LOGIC;
        in_M : OUT STD_LOGIC;
        RET_CALL_M : OUT STD_LOGIC;
        zero_flag_M : OUT STD_LOGIC;
        Reg_dst_M : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END EX_MEM_Reg;
ARCHITECTURE ExMemReg OF EX_MEM_Reg IS
BEGIN
    PROCESS (clk, rst) IS
    BEGIN
        IF (rst = '1') THEN

            Rdst_M <= (OTHERS => '0');
            AluOut_M <= (OTHERS => '0');
            EA_M <= (OTHERS => '0');

            MemRead_M <= '0';
            MemWrite_M <= '0';
            MemToReg_M <= '0';
            RegWrite_M <= '0';
            Branch_M <= '0';
            Protect_M <= '0';
            Free_M <= '0';
            SP_M <= '0';
            PUSH_POP_M <= '0';
            in_M <= '0';
            RET_CALL_M <= '0';
            zero_flag_M <= '0';
            Reg_dst_M <= (OTHERS => '0');

        ELSIF (rising_edge(clk) AND en = '1') THEN
            Rdst_M <= Rdst_E;
            AluOut_M <= AluOut_E;
            EA_M <= EA_E;

            MemRead_M <= MemRead_E;
            MemWrite_M <= MemWrite_E;
            MemToReg_M <= MemToReg_E;
            RegWrite_M <= RegWrite_E;
            Branch_M <= Branch_E;
            Protect_M <= Protect_E;
            Free_M <= Free_E;
            SP_M <= SP_E;
            PUSH_POP_M <= PUSH_POP_E;
            in_M <= in_E;
            RET_CALL_M <= RET_CALL_E;
            zero_flag_M <= zero_flag_E;
            Reg_dst_M <= Reg_dst_E;

        END IF;

    END PROCESS;
END ExMemReg;