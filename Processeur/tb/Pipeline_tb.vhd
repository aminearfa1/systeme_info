----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2023 15:34:38
-- Design Name: 
-- Module Name: Pipeline_tb - Behavioral
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

entity Pipeline_tb is
--  Port ( );
end Pipeline_tb;

architecture Behavioral of Pipeline_tb is

  component Pipeline is
    Port (
      A : in STD_LOGIC_VECTOR (7 downto 0);
      OP : in STD_LOGIC_VECTOR (7 downto 0);
      B : in STD_LOGIC_VECTOR (7 downto 0);
      C : in STD_LOGIC_VECTOR (7 downto 0);
      CLK : in STD_LOGIC;
      A_Out : out STD_LOGIC_VECTOR (7 downto 0);
      OP_Out : out STD_LOGIC_VECTOR (7 downto 0);
      B_Out : out STD_LOGIC_VECTOR (7 downto 0);
      C_Out : out STD_LOGIC_VECTOR (7 downto 0)
    );
  end component;

  -- Inputs
  signal Test_A: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_OP: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_B: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_C: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_CLK: STD_LOGIC := '1';

  -- Outputs
  signal Test_A_Out: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_OP_Out: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_B_Out: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_C_Out: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

  -- Clock period definitions
  -- Assuming 100 MHz
  constant Clock_period : time := 10 ns;

begin

  Clock_process : process
  begin
    Test_CLK <= not Test_CLK;
    wait for Clock_period/2;
  end process;

  Label_uut : Pipeline PORT MAP (
    A => Test_A,
    OP => Test_OP,
    B => Test_B,
    C => Test_C,
    CLK => Test_CLK,
    A_Out => Test_A_Out,
    OP_Out => Test_OP_Out,
    B_Out => Test_B_Out,
    C_Out => Test_C_Out
  );

  -- Stimulus process
  Test_A <= X"FF" after 0 ns, X"AA" after 100 ns, X"A0" after 200 ns, X"CA" after 300 ns, X"AB" after 400 ns;
  Test_OP <= X"05" after 0 ns, X"03" after 100 ns, X"02" after 200 ns, X"01" after 300 ns, X"00" after 400 ns;
  Test_B <= X"FF" after 0 ns, X"AA" after 100 ns, X"A0" after 200 ns, X"CA" after 300 ns, X"AB" after 400 ns;
Test_C <= X"FF" after 0 ns, X"AA" after 100 ns, X"A0" after 200 ns, X"CA" after 300 ns, X"AB" after 400 ns;
  
  end Behavioral;
