LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.vector_to_unsigned;
USE IEEE.numeric_std.ALL;
ENTITY FethcDecode IS
    PORT (
        clk : IN STD_LOGIC;
        instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        op_code : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        R_dest : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        R_src1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        R_src2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Extra_EFA : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END FethcDecode;
ARCHITECTURE Behavioral OF FethcDecode IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            op_code <= instruction(15 DOWNTO 11);
            R_dest <= instruction(10 DOWNTO 8);
            R_src1 <= instruction(7 DOWNTO 5);
            R_src2 <= instruction(4 DOWNTO 2);
            Extra_EFA <= instruction(7 DOWNTO 4);
        END IF;
    END PROCESS;

END Behavioral;