LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY LoadUseDetectionUnit IS
    PORT (
        RST : IN STD_LOGIC;
        IdEx_memRead : IN STD_LOGIC;
        IdEx_Rdst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        IfId_Rsrc1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        IfId_Rsrc2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ControlReset : OUT STD_LOGIC;
        IfId_disable : OUT STD_LOGIC;
        PC_writeDisable : OUT STD_LOGIC
    );
END LoadUseDetectionUnit;
ARCHITECTURE Behavioral OF LoadUseDetectionUnit IS
    SIGNAL ControlReset_signal :  STD_LOGIC;
    SIGNAL IfId_disable_signal :  STD_LOGIC;
    SIGNAL PC_writeDisable_signal :  STD_LOGIC;
BEGIN
    --handling the logic
    ControlReset_signal <= '1' WHEN (IdEx_memRead = '1' AND ((IdEx_Rdst = IfId_Rsrc1) OR (IdEx_Rdst = IfId_Rsrc2))) ELSE
        '0';
    IfId_disable_signal <= '1' WHEN (IdEx_memRead = '1' AND ((IdEx_Rdst = IfId_Rsrc1) OR (IdEx_Rdst = IfId_Rsrc2))) ELSE
        '0';

    PC_writeDisable_signal <= '1' WHEN (IdEx_memRead = '1' AND ((IdEx_Rdst = IfId_Rsrc1) OR (IdEx_Rdst = IfId_Rsrc2))) ELSE
        '0';

-- assigning the output to te signals 
 ControlReset <= ControlReset_signal WHEN Rst = '0' ELSE
        '0';
 IfId_disable <= IfId_disable_signal WHEN Rst = '0' ELSE
        '0';
 PC_writeDisable <= PC_writeDisable_signal WHEN Rst = '0' ELSE
        '0';
END Behavioral;