LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;

ENTITY StackPointer IS
    PORT (
        rst, clk : IN STD_LOGIC;
        SP_Write, Push_Pop : IN STD_LOGIC;
        StackPointer_Cur : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
        StackPointer_Next : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)

    );
END StackPointer;

ARCHITECTURE Behavioral OF StackPointer IS
    SIGNAL StackPointer_Cur_Sig : STD_LOGIC_VECTOR (11 DOWNTO 0) := (OTHERS => '1');
    SIGNAL StackPointer_Next_Sig : STD_LOGIC_VECTOR (11 DOWNTO 0) := (OTHERS => '1');
BEGIN

    StackPointer_Next_Sig <= STD_LOGIC_VECTOR(unsigned(StackPointer_Cur_Sig) - 2) WHEN Push_Pop = '1' ELSE
        STD_LOGIC_VECTOR(unsigned(StackPointer_Cur_Sig) + 2);
    StackPointer_Next <= StackPointer_Next_Sig;

    PROCESS (SP_Write, Push_Pop, rst, clk)
    BEGIN
        IF rst = '1' THEN
            StackPointer_Cur_Sig <= (OTHERS => '1');
            StackPointer_Cur <= (OTHERS => '1');
        ELSE
            IF (rising_Edge(clk)) THEN
                IF SP_Write = '1' THEN
                    StackPointer_Cur_Sig <= StackPointer_Next_Sig;
                    StackPointer_Cur <= StackPointer_Next_Sig;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;