
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ID_EX_Reg IS
    PORT (
        en, clk, rst : IN STD_LOGIC;
        ALUsrc_D : IN STD_LOGIC;
        AluOP_D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        MemRead_D : IN STD_LOGIC;
        MemWrite_D : IN STD_LOGIC;
        Protect_D : IN STD_LOGIC;
        MemToReg_D : IN STD_LOGIC;
        RegWrite_D : IN STD_LOGIC;
        Branch_D : IN STD_LOGIC;
        Rsrc1_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rsrc2_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        extra_EA_D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Rdst_D : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

        -- definging output

        ALUsrc_E : OUT STD_LOGIC;
        AluOP_E : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        MemRead_E : OUT STD_LOGIC;
        MemWrite_E : OUT STD_LOGIC;
        Protect_E : OUT STD_LOGIC;
        MemToReg_E : OUT STD_LOGIC;
        RegWrite_E : OUT STD_LOGIC;
        Branch_E : OUT STD_LOGIC;
        Rsrc1_E : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rsrc2_E : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        extra_EA_E : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Rdst_E : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ID_EX_Reg;
ARCHITECTURE IdExReg OF ID_EX_Reg IS
BEGIN
    PROCESS (clk, rst) IS
    BEGIN
        IF (rst = '1') THEN
            ALUsrc_E <= '0';
            AluOP_E <= (OTHERS => '0');
            MemRead_E <= '0';
            MemWrite_E <= '0';
            Protect_E <= '0';
            MemToReg_E <= '0';
            RegWrite_E <= '0';
            Branch_E <= '0';
            Rsrc1_E <= (OTHERS => '0');
            Rsrc2_E <= (OTHERS => '0');
            extra_EA_E <= (OTHERS => '0');
            Rdst_E <= (OTHERS => '0');
        ELSIF (rising_edge(clk) AND en = '1') THEN
            ALUsrc_E <= ALUsrc_D;
            AluOP_E <= AluOP_D;
            MemRead_E <= MemRead_D;
            MemWrite_E <= MemWrite_D;
            Protect_E <= Protect_D;
            MemToReg_E <= MemToReg_D;
            RegWrite_E <= RegWrite_D;
            Branch_E <= Branch_D;
            Rsrc1_E <= Rsrc1_D;
            Rsrc2_E <= Rsrc2_D;
            extra_EA_E <= extra_EA_D;
            Rdst_E <= Rdst_D;
        END IF;

    END PROCESS;
END IdEXReg;