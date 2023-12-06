LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

USE work.my_pkg.ALL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
ENTITY InstructionMemory IS
    PORT (
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END InstructionMemory;
ARCHITECTURE Behavioral OF InstructionMemory IS
    SIGNAL memory : memory_array (0 to 4095)(15 DOWNTO 0);
BEGIN
    initmemory : ENTITY work.instruction_memory_initialization   PORT MAP (ram => memory);
    instruction <= memory(to_integer(unsigned((address))));

END Behavioral;