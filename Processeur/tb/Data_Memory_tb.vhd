----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2023 15:07:58
-- Design Name: 
-- Module Name: Data_Memory_tb - Behavioral
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
entity Data_Memory_tb is

end Data_Memory_tb;

architecture Behavioral of Data_Memory_tb is
COMPONENT Data_Memory
    Port(
        add : in STD_LOGIC_VECTOR (7 downto 0);
        INPUT : in STD_LOGIC_VECTOR (7 downto 0);
          RW : in STD_LOGIC;
          RST : in STD_LOGIC;
          CLK : in STD_LOGIC;
          OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;
 
 --inputs 
 signal Test_add : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
 signal Test_RW :  STD_LOGIC:='1';
 signal Test_INPUT :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
 signal Test_RST :  STD_LOGIC:='1';
 signal Test_CLK :  STD_LOGIC:='0';
 --output
 signal Test_OUTPUT : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
 --clk      
-- Si 100 MHz
 constant Clock_period : time := 10 ns;
   


begin
Label_uut: Data_Memory PORT MAP (
    add=>Test_add,
    RW => Test_RW ,
    INPUT => Test_INPUT,
    RST => Test_RST,
    CLK => Test_CLK,
    
    OUTPUT=>Test_OUTPUT
    );
--Clock process definitions
Clock_process : process
begin
    Test_CLK <= not(Test_CLK);
    wait for Clock_period/2;
end process;
    
--Stimulus process
Test_INPUT <= X"FF" after 0 ns, X"AA" after 100 ns, X"A0" after 300 ns, X"CA" after 450 ns, X"AB" after 800 ns;

Test_add <= X"01" after 0 ns, X"03" after 100 ns, X"AA" after 450 ns, X"FF" after 500 ns , X"01" after 550 ns, X"03" after 900 ns, X"AA" after 950 ns;

Test_RST <= '0' after 200 ns, '1' after 300 ns;
Test_RW <= '0' after 100 ns, '1' after 250 ns, '0' after 300 ns, '1' after 550 ns ;

end Behavioral;


