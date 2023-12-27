LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
USE work.my_pkg.ALL;

ENTITY DataMemory IS
    PORT (
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data input (32-bit)
        write_enable : IN STD_LOGIC; -- Write enable signal
        read_enable : IN STD_LOGIC; -- Read enable signal
        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Data output (32-bit)
        protect_sig,SP_Write,Push_Pop,free_sig : IN STD_LOGIC
    );
END DataMemory;

ARCHITECTURE Behavioral OF DataMemory IS
    TYPE MemoryProtectionArray IS ARRAY (0 TO 4095) OF STD_LOGIC; -- Renamed PROTECTEDMemory to MemoryProtectionArray
    -- SIGNAL memory : MemoryArray := (OTHERS => (OTHERS => '0'));
    SIGNAL memory : memory_array (0 TO 4095)(15 DOWNTO 0) ;
    SIGNAL MemoryProtection : MemoryProtectionArray := (
        OTHERS => '0'
    );
    SIGNAL Cur_StackPointer,Next_StackPointer: STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
    SP_Instance: ENTITY work.StackPointer PORT MAP(rst=>rst,clk=>clk,SP_Write=>SP_Write,Push_Pop=>Push_Pop,StackPointer_Cur=>Cur_StackPointer,StackPointer_Next=>Next_StackPointer);
    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
                memory <= (OTHERS => (OTHERS => '0'));
      -- Little endian: store memory in the highest bits
        ELSIF falling_edge(clk) THEN
            IF( SP_Write='1' AND Push_Pop='1') THEN  --PUSH
                memory(to_integer(unsigned(Cur_StackPointer - 1))) <= data_in(15 DOWNTO 0);
                memory(to_integer(unsigned(Cur_StackPointer))) <= data_in(31 DOWNTO 16);
            END IF;
            IF(SP_Write='1' AND Push_Pop='0')  THEN --POP
                data_out(15 DOWNTO 0) <= memory(to_integer(unsigned(Next_StackPointer - 1)));
                data_out(31 DOWNTO 16) <= memory(to_integer(unsigned(Next_StackPointer)));
            END IF;
            IF(write_enable = '1' AND MemoryProtection(to_integer(unsigned(address))) = '0') THEN  --STD RSrc
                memory(to_integer(unsigned(address - 1))) <= data_in(15 DOWNTO 0);
                memory(to_integer(unsigned(address))) <= data_in(31 DOWNTO 16);
            END IF;
            IF(read_enable = '1') THEN   -- LDD Rdst,EA
                data_out(15 DOWNTO 0) <= memory(to_integer(unsigned(address - 1)));
                data_out(31 DOWNTO 16) <= memory(to_integer(unsigned(address)));
            END IF;
            IF protect_sig = '1' THEN
                MemoryProtection(to_integer(unsigned(address))) <= '1';
            END IF;
            IF free_sig='1' THEN
                MemoryProtection(to_integer(unsigned(address))) <= '0';
            END IF;
        END IF;
    END PROCESS;
END Behavioral;