----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 14:41:19
-- Design Name: 
-- Module Name: Banc_Registre_tb - Behavioral
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

entity Banc_Registre_tb is
end Banc_Registre_tb;

architecture Behavioral of Banc_Registre_tb is
  component Banc_Registre
    Port (
      addA : in STD_LOGIC_VECTOR (3 downto 0);
      addB : in STD_LOGIC_VECTOR (3 downto 0);
      addW : in STD_LOGIC_VECTOR (3 downto 0);
      W : in STD_LOGIC;
      DATA : in STD_LOGIC_VECTOR (7 downto 0);
      RST : in STD_LOGIC;
      CLK : in STD_LOGIC;
      QA : out STD_LOGIC_VECTOR (7 downto 0);
      QB : out STD_LOGIC_VECTOR (7 downto 0)
    );
  end component;

  -- Inputs
  signal Test_addA : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
  signal Test_addB : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
  signal Test_addW : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
  signal Test_W : STD_LOGIC := '1';
  signal Test_DATA : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_RST : STD_LOGIC := '1';
  signal Test_CLK : STD_LOGIC := '1';

  -- Outputs
  signal Test_QA : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Test_QB : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

  -- Clock period definitions
  constant Clock_period : time := 10 ns;

begin
  -- Instantiate the DUT (Registers entity)
  Label_uut: Banc_Registre
    PORT MAP (
      addA => Test_addA,
      addB => Test_addB,
      addW => Test_addW,
      W => Test_W,
      DATA => Test_DATA,
      RST => Test_RST,
      CLK => Test_CLK,
      QA => Test_QA,
      QB => Test_QB
    );

  -- Clock process definitions
  Clock_process : process
  begin
    Test_CLK <= not Test_CLK;
    wait for Clock_period/2;
  end process;

  Stimulus_process : process
  begin
    Test_RST <= '0' after 0 ns, '1' after 10 ns;

    -- Test Case 1
    Test_DATA <= X"FF";
    Test_addW <= X"2";
    Test_addA <= X"1";
    wait for 100 ns;

    -- Test Case 2
    Test_DATA <= X"AA";
    Test_addW <= X"3";
    Test_addB <= X"2";
    wait for 200 ns;

    -- Test Case 3
    Test_DATA <= X"12";
    Test_addW <= X"0";
    Test_W <= '1';
    wait for 150 ns;

    -- Test Case 4
    Test_DATA <= X"34";
    Test_addW <= X"1";
    wait for 100 ns;

    -- Test Case 5
    Test_DATA <= X"78";
    Test_addA <= X"7";
    wait for 300 ns;

    -- Add more test cases as needed

    wait; -- Wait indefinitely
  end process;
end Behavioral;

