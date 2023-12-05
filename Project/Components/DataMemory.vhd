LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.vector_to_unsigned;
USE IEEE.numeric_std.ALL;

ENTITY DataMemory IS
    PORT (
        clk : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data input (32-bit)
        write_enable : IN STD_LOGIC; -- Write enable signal
        read_enable : IN STD_LOGIC; -- Read enable signal
        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- Data output (32-bit)
    );
END DataMemory;

ARCHITECTURE Behavioral OF DataMemory IS
    TYPE MemoryArray IS ARRAY (0 TO 4095) OF STD_LOGIC_VECTOR(15 DOWNTO 0); -- 4 KB memory with 16-bit words
    TYPE MemoryProtectionArray IS ARRAY (0 TO 4095) OF STD_LOGIC; -- Renamed PROTECTEDMemory to MemoryProtectionArray
    SIGNAL memory : MemoryArray := (OTHERS => (OTHERS => '0'));
    -- SIGNAL memory : MemoryArray := (
    --     0 => "0000000000000000",
    --     1 => "0000000000111111",
    --     2 => "0000000000011111",
    --     3 => "0000000000111111"
    -- );

    SIGNAL MemoryProtection : MemoryProtectionArray := (
        OTHERS => '0'
    );

BEGIN
    PROCESS (clk)
    BEGIN
        IF falling_edge(clk) THEN
            IF (write_enable = '1' AND MemoryProtection(to_integer(unsigned(address))) = '1') THEN
                -- Big endian: store memory in the highest bits
                memory(to_integer(unsigned(address - 1))) <= data_in(15 DOWNTO 0);
                memory(to_integer(unsigned(address))) <= data_in(31 DOWNTO 16);
            ELSIF read_enable = '1' THEN
                -- for stack pointer
                data_out(15 DOWNTO 0) <= memory(to_integer(unsigned(address - 1)));
                data_out(31 DOWNTO 16) <= memory(to_integer(unsigned(address)));
                -- To continue reading
            END IF;
        END IF;
    END PROCESS;
END Behavioral;