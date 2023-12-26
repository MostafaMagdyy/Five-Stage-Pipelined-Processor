LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;

Entity Data_Forwarding IS
PORT (
    clk: iN STD_LOGIC;
    RSrc1,Rsrc2: IN STD_LOGIC_VECTOR( 2 DOWNTO 0);
    ALU_DST,MeM_WB: IN STD_LOGIC;
    R_dstALU,R_dstMemory: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    R_dstALUValue,R_dstMemoryValue: IN STD_LOGIC_VECTOR( 31 DOWNTO 0);
    OUT1_Sel, OUT2_Sel: OUT STD_LOGIC;
    OUT1,OUT2:OUT STD_LOGIC_VECTOR ( 31 DOWNTO 0)
);
END Data_Forwarding;

ARCHITECTURE Behavioral OF Data_Forwarding IS
BEGIN
 PROCESS (clk)
 BEGIN
-- Alu should be first
 IF rising_edge(clk) THEN
     iF (R_dstALU = RSrc1 or R_dstALU = Rsrc2) and (ALU_DST = '1') AND (R_dstMemory = RSrc1 or R_dstMemory = Rsrc2) and (MeM_WB = '1') THEN
            IF (R_dstMemory=RSrc1) THEN
            OUT1<=R_dstMemoryValue;
            OUT1_Sel<='1';
            END IF;
            IF (R_dstMemory=RSrc2) THEN
            OUT2<=R_dstMemoryValue;
            OUT2_Sel<='1';
            END IF;
            IF (R_dstALU=RSrc1) THEN
            OUT1<=R_dstALUValue;
            OUT1_Sel<='1';
            END IF;
            IF (R_dstALU=RSrc2) THEN
            OUT2<=R_dstALUValue;
            OUT2_Sel<='1';
            END IF;
            iF(RSrc1/=R_dstMemory and RSrc1/= R_dstALU) THEN
            OUT1_Sel<='0';
            END IF;
            iF(RSrc2/=R_dstMemory and RSrc2/= R_dstALU) THEN
            OUT2_Sel<='0';
            END IF;
            
     ELSiF (R_dstALU = RSrc1 or R_dstALU = Rsrc2) and (ALU_DST = '1') then
                IF R_dstALU = RSrc1 then
                    OUT1 <= R_dstALUValue;
                    OUT1_Sel<='1';
                ELSE OUT1_Sel<='0';
                END IF;      
                IF R_dstALU = Rsrc2 then
                    OUT2 <= R_dstALUValue;
                    OUT2_Sel<='1';
                ELSE OUT2_Sel<='0';
                END IF;        
     ELSIF(R_dstMemory = RSrc1 or R_dstMemory = Rsrc2) and (MeM_WB = '1') then
                if R_dstMemory = RSrc1 then
                    OUT1 <= R_dstMemoryValue;
                    OUT1_Sel<='1';
                ELSE OUT1_Sel<='0';
                END IF;
                IF R_dstMemory = Rsrc2 then
                    OUT2 <= R_dstMemoryValue;
                    OUT2_Sel<='1';
                ELSE OUT2_Sel<='0';
                END IF;
     ELSE
   OUT1_Sel<='0';
   OUT2_Sel<='0';
END IF;
END IF;
END PROCESS;
END Behavioral;