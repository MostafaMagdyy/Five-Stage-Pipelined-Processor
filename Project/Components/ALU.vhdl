LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alu_32bit IS
    PORT (
        reset, alu_en : IN STD_LOGIC;
        A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALUOp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Zero, Carry, Neg : OUT STD_LOGIC);
END alu_32bit;

ARCHITECTURE arch_alu_32bit OF alu_32bit IS
    SIGNAL temp : STD_LOGIC_VECTOR(32 DOWNTO 0);
    SIGNAL carry_out : STD_LOGIC;
BEGIN
    PROCESS (alu_en, A, B, ALUOp)
    BEGIN
        IF (ALUOp /= "0000" AND alu_en = '1') THEN
            CASE ALUOp IS
                WHEN "0001" =>
                    -- NOT
                    temp <= ('0' & (NOT A));

                WHEN "0010" =>
                    -- NEG
                    temp <= '0' & NOT (A + 1);

                WHEN "0011" =>
                    -- INC 
                    temp <= ('0' & A) + 1;

                WHEN "0100" =>
                    -- DEC 
                    temp <= ('0' & A) - 1;
                WHEN "0101" =>
                    -- ADD
                    temp <= ('0' & A) + ('0' & B);
                WHEN "0110" =>
                    -- SUB
                    temp <= ('0' & A) - ('0' & B);
                WHEN "0111" =>
                    -- AND
                    temp <= ('0' & A) AND ('0' & B);
                WHEN "1000" =>
                    -- OR
                    temp <= ('0' & A) OR ('0' & B);
                WHEN "1001" =>
                    -- XOR
                    temp <= ('0' & A) XOR ('0' & B);
                WHEN "1010" =>
                    -- RCL
                    -- temp <= ('0' & A) + ('0' & B);
                WHEN "1011" =>
                    -- RCR
                    -- temp <= ('0' & A) + ('0' & B);

                WHEN OTHERS =>
                    -- Other operations (you can add more as needed)
                    -- Result <= (OTHERS => '0');
            END CASE;

            -- Check if the result is zero
        END IF;
    END PROCESS;

    PROCESS (alu_en, temp)
    BEGIN
        IF (alu_en = '1') THEN

            IF temp(31 DOWNTO 0) = x"00000000" THEN
                Zero <= '1';
            ELSE
                Zero <= '0';
            END IF;
            -- Carry out 
            carry_out <= temp(32);

            -- Negative flag
            Neg <= temp(31);

            result <= temp (31 DOWNTO 0);

        END IF;
    END PROCESS;

    Carry <= carry_out;

END arch_alu_32bit;