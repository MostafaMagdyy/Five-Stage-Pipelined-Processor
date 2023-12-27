LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
ENTITY FethcDecode IS
    PORT (
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        instruction_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        op_code : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        R_dest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        R_src1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        R_src2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Extra_EFA : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END FethcDecode;
ARCHITECTURE Behavioral OF FethcDecode IS
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            instruction_out <= (OTHERS => '0');
            op_code <= (OTHERS => '0');
            R_dest <= (OTHERS => '0');
            R_src1 <= (OTHERS => '0');
            R_src2 <= (OTHERS => '0');
            Extra_EFA <= (OTHERS => '0');
        ELSIF rising_edge(clk) AND enable = '1' THEN
            instruction_out <= instruction;
            op_code <= instruction(15 DOWNTO 11);
            R_dest <= instruction(10 DOWNTO 8);
            R_src1 <= instruction(7 DOWNTO 5);
            R_src2 <= instruction(4 DOWNTO 2);
            Extra_EFA <= instruction(4 DOWNTO 1);
        END IF;
    END PROCESS;

END Behavioral;