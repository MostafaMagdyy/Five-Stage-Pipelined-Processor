LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.vector_to_unsigned;
USE IEEE.numeric_std.ALL;
ENTITY InstructionMemory IS
    PORT (
        clk : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END InstructionMemory;

ARCHITECTURE Behavioral OF InstructionMemory IS
    TYPE InstructionMemoryArray IS ARRAY (0 TO 4095) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL memory : InstructionMemoryArray := (OTHERS => (OTHERS => '0'));
    -- --    SIGNAL memory : InstructionMemoryArray := ( // initialization for testing
    --     0 => "0000000000000000",
    --     1 => "1101111110111111",
    --     2 => "1001101111011111",
    --     3 => "1110001111111111"
    -- );
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            instruction <= memory(to_integer(unsigned((address))));
        END IF;
    END PROCESS;

END Behavioral;