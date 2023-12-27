LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY register_file IS
    PORT (
        Clk : IN STD_LOGIC;
        Rst : IN STD_LOGIC;
        RegWrite : IN STD_LOGIC;
        WriteRegister : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ReadRegister1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ReadRegister2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ReadData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        ReadData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        DstData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END register_file;

ARCHITECTURE Behavioral OF register_file IS
    TYPE Register_Array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Registers : Register_Array;
BEGIN
    PROCESS (Clk, Rst)
    BEGIN
        IF Rst = '1' THEN
            Registers(0) <= x"00000001";
            Registers(1) <= x"00000002";
            Registers(2) <= x"00000003";
            Registers(3) <= x"00000004";
            Registers(4) <= x"00000005";
            Registers(5) <= x"00000006";
            Registers(6) <= x"00000007";
            Registers(7) <= x"00000008";
        ELSIF falling_edge(Clk) THEN
            -- Write operation
            IF RegWrite = '1' THEN
                Registers(to_integer(unsigned(WriteRegister))) <= WriteData;
            END IF;
        END IF;
    END PROCESS;

    -- Read operations
    ReadData1 <= Registers(to_integer(unsigned(ReadRegister1)));
    ReadData2 <= Registers(to_integer(unsigned(ReadRegister2)));
    DstData <= Registers(to_integer(unsigned(WriteRegister)));
END Behavioral;