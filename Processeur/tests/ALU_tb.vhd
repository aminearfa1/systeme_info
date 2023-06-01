----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 14:11:51
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is

    -- Constants
    constant CLK_PERIOD : time := 10 ns;

    -- Signals
    signal A : std_logic_vector(7 downto 0) := (others => '0');
    signal B : std_logic_vector(7 downto 0) := (others => '0');
    signal Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');
    signal S : std_logic_vector(7 downto 0);
    signal N, O, Z, C : std_logic;

begin

    -- Instantiate the ALU
    uut: entity work.ALU
        port map (
            A => A,
            B => B,
            Ctrl_Alu => Ctrl_Alu,
            S => S,
            N => N,
            O => O,
            Z => Z,
            C => C
        );

    -- Clock process
    process
    begin
        while now < 100 ns loop
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    process
    begin
        -- Test case 1: Addition
        A <= "00000101";
        B <= "00000011";
        Ctrl_Alu <= "001";
        wait for CLK_PERIOD;
     

        -- Test case 2: Subtraction
        A <= "00000101";
        B <= "00000011";
        Ctrl_Alu <= "010";
        wait for CLK_PERIOD;
      

        -- Test case 3: Multiplication
        A <= "00000101";
        B <= "00000011";
        Ctrl_Alu <= "011";
 wait for CLK_PERIOD;
    
-- Test case 1: Addition débordement
         A <= X"FF";
         B <= X"FF";
         Ctrl_Alu <= "001";
 wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;