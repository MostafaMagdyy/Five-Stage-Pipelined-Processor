
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY flag_register IS
    PORT (
        en, clk, rst : IN STD_LOGIC;

        zero_in : IN STD_LOGIC;
        carry_in : IN STD_LOGIC;
        neg_in : IN STD_LOGIC;

        -- definging output

        zero_out : OUT STD_LOGIC;
        carry_out : OUT STD_LOGIC;
        neg_out : OUT STD_LOGIC

    );
END flag_register;
ARCHITECTURE arch_flag_register OF flag_register IS
BEGIN
    PROCESS (clk, rst) IS
    BEGIN
        IF (rst = '1') THEN
            zero_out <= '0';
            carry_out <= '0';
            neg_out <= '0';
        ELSIF (rising_edge(clk) AND en = '1') THEN
            zero_out <= zero_in;
            carry_out <= carry_in;
            neg_out <= neg_in;
        END IF;

    END PROCESS;
END arch_flag_register;