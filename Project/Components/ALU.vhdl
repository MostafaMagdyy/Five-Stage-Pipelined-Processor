LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
ENTITY alu_32bit IS
    PORT (
        rst, alu_en : IN STD_LOGIC;
        A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALUOp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        zero_in, carry_in, neg_in : IN STD_LOGIC;

        zero_out, carry_out, neg_out : OUT STD_LOGIC;
        Result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END alu_32bit;

ARCHITECTURE arch_alu_32bit OF alu_32bit IS
    SIGNAL temp : STD_LOGIC_VECTOR(32 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (alu_en, A, B, ALUOp, Shift, zero_in, carry_in, neg_in)
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
                    REPORT "bitset";
                    -- BITSET
                    temp <= '0' & A(31 DOWNTO (to_integer(unsigned(Shift)) + 1)) & '1' & A((to_integer(unsigned(Shift)) - 1) DOWNTO 0);
                WHEN "1011" =>
                    -- RCR
                    IF (to_integer(unsigned(Shift)) > 0) THEN
                        temp <= A((to_integer(unsigned(Shift)) - 1) DOWNTO 0) & carry_in & A(31 DOWNTO to_integer(unsigned(Shift)));
                    END IF;
                WHEN "1100" =>
                    -- RCL
                    IF (to_integer(unsigned(Shift)) > 1) THEN
                        temp <= A(32 - (to_integer(unsigned(Shift))) DOWNTO 0) & carry_in & A(31 DOWNTO (33 - to_integer(unsigned(Shift))));
                    ELSIF (to_integer(unsigned(Shift)) = 1) THEN
                        temp <= A & carry_in;
                    ELSE
                        temp <= carry_in & A;
                    END IF;
                WHEN "1101" =>
                    -- out A
                    temp <= ('0' & A);
                WHEN "1110" =>
                    -- out A
                    temp <= ('0' & B);

                WHEN OTHERS =>
                    temp <= (OTHERS => '0');
                    -- Other operations (you can add more as needed)
                    -- Result <= (OTHERS => '0');
            END CASE;

            -- Check if the result is zero
        END IF;
    END PROCESS;

    PROCESS (alu_en, temp, rst)
    BEGIN
        IF (rst = '1') THEN
            zero_out <= '0';
            carry_out <= '0';
            neg_out <= '0';
            result <= (OTHERS => '0');
        ELSIF (alu_en = '1') THEN

            IF temp(31 DOWNTO 0) = x"00000000" THEN
                zero_out <= '1';
            ELSE
                zero_out <= '0';
            END IF;
            -- Carry out 
            carry_out <= temp(32);

            -- Negative flag
            neg_out <= temp(31);

            result <= temp (31 DOWNTO 0);

        END IF;
    END PROCESS;
END arch_alu_32bit;