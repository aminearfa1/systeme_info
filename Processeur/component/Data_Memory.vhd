----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2023 15:06:41
-- Design Name: 
-- Module Name: Data_Memory - Behavioral
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

entity Data_Memory is
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is
type dataMemoryArray is array (0 to 255) of std_logic_vector(7 downto 0);
signal DataM : dataMemoryArray := (others => x"00");
signal Value: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

begin 
process
begin
    wait until CLK'Event and CLK='1';
    
    if(RST/='0') then
        if(RW='0') then -- écriture
            DataM(to_integer(unsigned(add)))<= INPUT;
           -- Value <= INPUT;
        else -- (RW='1')  lecture 
            Value <= add;
        end if;
    else
        for i in 0 to 255 loop
            DataM(i) <= ( others => '0');   
        end loop;
    end if;
end process;
OUTPUT<=DataM(to_integer(unsigned(Value)));
end Behavioral;
