----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2023 14:52:36
-- Design Name: 
-- Module Name: Instructions_Memory_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instructions_Memory_tb is
end Instructions_Memory_tb;

architecture Behavioral of Instructions_Memory_tb is
    COMPONENT Instruction_Memory
        Port (
            add : in STD_LOGIC_VECTOR (7 downto 0);
            CLK : in STD_LOGIC;
            OUTPUT : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end COMPONENT;

    -- Inputs
    signal Test_addA : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal Test_CLK : STD_LOGIC := '0';
    
    -- Output
    signal Test_Output : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    constant Clock_period : time := 10 ns;

begin
    Label_uut: Instruction_Memory PORT MAP (
        add => Test_addA,
        CLK => Test_CLK,
        OUTPUT => Test_Output
    );

    -- Clock process definitions
    Clock_process : process
    begin
        Test_CLK <= not Test_CLK;
        wait for Clock_period/2;
    end process;

    -- Stimulus process
    Stimulus_process : process
    begin
        Test_addA <= X"00";
        wait for 100 ns;
        Test_addA <= X"01";
        wait for 100 ns;
        Test_addA <= X"02";
        wait for 100 ns;
        Test_addA <= X"03";
        wait for 100 ns;
        wait;
    end process;

end Behavioral;
