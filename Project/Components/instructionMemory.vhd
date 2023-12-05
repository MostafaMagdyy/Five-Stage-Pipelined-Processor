LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_textio.ALL;
USE std.textio.ALL;
ENTITY InstructionMemory IS
    PORT (
        clk : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END InstructionMemory;
ARCHITECTURE Behavioral OF InstructionMemory IS
    TYPE InstructionMemoryArray IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    -- SIGNAL memory : InstructionMemoryArray := (OTHERS => (OTHERS => '0'));
    SIGNAL memory : InstructionMemoryArray := (--// initialization for testing
    0 => "0101101001001100",--//or
    1 => "1010011100000110",--ldd
    2 => "0000000000000000",--EA
    3 => "0000000000000000",-- NOP
    4 => "0000000000000000",--dec reg 7
    5 => "0000000000000000",
    6 => "0000000000000000",
    7 => "0010011111101100",
    8 => "0000000000000000",
    9 => "0000000000000000",
    10 => "0000000000000000",
    11 => "0000000000000000",
    12 => "1011000000000000",
    13 => "0000000000000000",
    14 => "0000000000000000",
    15 => "0000000000000000"
    );
BEGIN
    -- PROCESS (clk)
    -- BEGIN
    --     IF rising_edge(clk) THEN
    --     END IF;
    --     END PROCESS;
    instruction <= memory(to_integer(unsigned((address))));

END Behavioral;