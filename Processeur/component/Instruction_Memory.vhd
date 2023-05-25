----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 13:13:58
-- Design Name: 
-- Module Name: Instruction_Memory - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory is
    Port (
        add : in STD_LOGIC_VECTOR (7 downto 0);
        CLK : in STD_LOGIC;
        OUTPUT : out STD_LOGIC_VECTOR (31 downto 0)
    );
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
    signal addI : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    type dataInstructArray is array (0 to 255) of std_logic_vector(31 downto 0);
    signal DataI : dataInstructArray :=
        (
            0=> x"01061400", 
            1=> x"02060800", 
            2=> x"01061200",
            3=> x"02050100", 
            others => x"00000000"
        );
begin
    process
    begin
        wait until CLK'Event and CLK = '1';
        addI <= add;
    end process;

    OUTPUT <= DataI(to_integer(unsigned(addI)));
end Behavioral;