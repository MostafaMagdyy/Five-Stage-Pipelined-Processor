
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
        Protect_E : IN STD_LOGIC;
        MemToReg_E : IN STD_LOGIC;
        RegWrite_E : IN STD_LOGIC;
        Branch_E : IN STD_LOGIC;

        -- defining output

        Rdst_M : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        AluOut_M : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        EA_M : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);

        MemRead_M : OUT STD_LOGIC;
        MemWrite_M : OUT STD_LOGIC;
        Protect_M : OUT STD_LOGIC;
        MemToReg_M : OUT STD_LOGIC;
        RegWrite_M : OUT STD_LOGIC;
        Branch_M : OUT STD_LOGIC

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
            Protect_M <= '0';
            MemToReg_M <= '0';
            RegWrite_M <= '0';
            Branch_M <= '0';

        ELSIF (rising_edge(clk) AND en = '1') THEN
            Rdst_M <= Rdst_E;
            AluOut_M <= AluOut_E;
            EA_M <= EA_E;

            MemRead_M <= MemRead_E;
            MemWrite_M <= MemWrite_E;
            Protect_M <= Protect_E;
            MemToReg_M <= MemToReg_E;
            RegWrite_M <= RegWrite_E;
            Branch_M <= Branch_E;
        END IF;

    END PROCESS;
END ExMemReg;