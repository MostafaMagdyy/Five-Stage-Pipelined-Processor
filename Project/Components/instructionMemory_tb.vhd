LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE std.textio.ALL;

ENTITY InstructionMemory_TB IS
END InstructionMemory_TB;

ARCHITECTURE Behavioral OF InstructionMemory_TB IS
    CONSTANT MEMORY_DEPTH : INTEGER := 4095; -- Define memory depth
    SIGNAL clk : STD_LOGIC := '0'; -- Clock signal
    SIGNAL address : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0'); -- Address signal
    SIGNAL instruction : STD_LOGIC_VECTOR(15 DOWNTO 0); -- Output instruction signal

    FILE input_file : TEXT;
    VARIABLE file_line : LINE;
    VARIABLE data_value : STD_LOGIC_VECTOR(15 DOWNTO 0);
    VARIABLE file_opened : BOOLEAN := FALSE;
BEGIN
    PROCESS
    BEGIN
        -- Open the file for reading
        IF NOT file_opened THEN
            file_open(input_file, "./file.txt", READ_MODE);
            file_opened := TRUE;
        END IF;

        -- Read data from the file line by line and initialize memory
        FOR i IN 0 TO MEMORY_DEPTH - 1 LOOP
            readline(input_file, file_line);
            read(file_line, data_value); -- Read 16-bit value from the file

            -- Initialize memory
            memory(i) <= data_value; -- Assign the read value to memory

            -- Uncomment below to see the values read from the file
            -- report "Read value: " & to_string(data_value);
        END LOOP;

        -- Close the file after reading
        IF file_opened THEN
            file_close(input_file);
        END IF;

        WAIT;
    END PROCESS;

    -- Clock generation process (example)
    PROCESS
    BEGIN
        WHILE true LOOP
            clk <= '0';
            WAIT FOR 5 ns;
            clk <= '1';
            WAIT FOR 5 ns;
        END LOOP;
    END PROCESS;

    -- Connect the memory entity with the clock and address signals
    Memory_Instance : ENTITY work.InstructionMemory
        PORT MAP(
            clk => clk,
            address => address,
            instruction => instruction
        );

END Behavioral;