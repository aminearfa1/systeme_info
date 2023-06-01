----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2023 12:00:37
-- Design Name: 
-- Module Name: Processor_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Processor_tb is
--  Port ( );
end Processor_tb;

architecture Behavioral of Processor_tb is
component Processor
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC);
end component;

--- Proccessor
signal Processor_CLK_Test : STD_LOGIC := '1';
signal Processor_RST_Test : STD_LOGIC := '1';
constant Clock_period : time := 10 ns;

begin
processor_map: Processor PORT MAP (
    RST => Processor_RST_Test,
    CLK => Processor_CLK_Test
);

Clock_process : process
begin
    Processor_CLK_Test <= not(Processor_CLK_Test);
    wait for Clock_period/2;
end process;

end Behavioral;
