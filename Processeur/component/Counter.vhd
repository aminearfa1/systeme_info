----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2023 16:13:18
-- Design Name: 
-- Module Name: Counter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    Port ( NUM : in STD_LOGIC_VECTOR (7 downto 0);
           A_F : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end Counter;

architecture Behavioral of Counter is

signal Value: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

begin

process
begin
    wait until CLK'Event and CLK='1';
        if(A_F='1') then
        Value <= NUM;
        else 
        Value <= NUM+1;
        end if;
end process;

OUTPUT<=Value;

end Behavioral;