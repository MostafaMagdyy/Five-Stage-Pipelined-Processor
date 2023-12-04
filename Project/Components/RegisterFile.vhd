library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 
entity register_file is
    Port ( 
        Clk : in STD_LOGIC; 
        Rst : in STD_LOGIC;
        RegWrite : in STD_LOGIC;  
        WriteRegister : in STD_LOGIC_VECTOR(2 downto 0);  
        WriteData : in STD_LOGIC_VECTOR(31 downto 0);  
        ReadRegister1 : in STD_LOGIC_VECTOR(2 downto 0);  
        ReadRegister2 : in STD_LOGIC_VECTOR(2 downto 0); 
        ReadData1 : out STD_LOGIC_VECTOR(31 downto 0); 
        ReadData2 : out STD_LOGIC_VECTOR(31 downto 0) 
    );
end register_file;

architecture Behavioral of register_file is
    type Register_Array is array (0 to 7) of STD_LOGIC_VECTOR(31 downto 0);
    signal Registers : Register_Array;
begin
    process (Clk, Rst)
    begin
        if Rst = '1' then
            Registers(0) <= x"00000001";
            Registers(1) <= x"00000002";
            Registers(2) <= x"00000003";
            Registers(3) <= x"00000004";
            Registers(4) <= x"00000005";
            Registers(5) <= x"00000006";
            Registers(6) <= x"00000007";
            Registers(7) <= x"00000008";
        elsif rising_edge(Clk) then
            -- Write operation
            if RegWrite = '1' then
                Registers(to_integer(unsigned(WriteRegister))) <= WriteData;
            end if;
        end if; 
    end process;

    -- Read operations
    ReadData1 <= Registers(to_integer(unsigned(ReadRegister1)));
    ReadData2 <=  Registers(to_integer(unsigned(ReadRegister2)));
end Behavioral;
