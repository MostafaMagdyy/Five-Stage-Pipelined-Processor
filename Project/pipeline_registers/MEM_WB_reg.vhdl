
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MEM_WB_Reg IS
    PORT (
        en, clk, rst : IN STD_LOGIC;
        Rdst_M : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        AluOut_M : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemOut_M : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        MemToReg_M : IN STD_LOGIC;
        RegWrite_M : IN STD_LOGIC;
        in_M : IN STD_LOGIC;

        -- defining output

        Rdst_WB : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        AluOut_WB : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemOut_WB : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

        MemToReg_WB : OUT STD_LOGIC;
        RegWrite_WB : OUT STD_LOGIC;
        in_WB : OUT STD_LOGIC

    );
END MEM_WB_Reg;
ARCHITECTURE MemWbReg OF MEM_WB_Reg IS
BEGIN
    PROCESS (clk, rst) IS
    BEGIN
        IF (rst = '1') THEN

            Rdst_WB <= (OTHERS => '0');
            AluOut_WB <= (OTHERS => '0');
            MemOut_WB <= (OTHERS => '0');

            MemToReg_WB <= '0';
            RegWrite_WB <= '0';
            in_WB <= '0';

        ELSIF (rising_edge(clk) AND en = '1') THEN
            Rdst_WB <= Rdst_M;
            AluOut_WB <= AluOut_M;
            MemOut_WB <= MemOut_M;

            MemToReg_WB <= MemToReg_M;
            RegWrite_WB <= RegWrite_M;
            in_WB <= in_M;

        END IF;

    END PROCESS;
END MemWbReg;