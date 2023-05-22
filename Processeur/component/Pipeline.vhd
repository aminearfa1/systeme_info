----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2023 15:33:21
-- Design Name: 
-- Module Name: Pipeline - Behavioral
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

entity Pipeline is
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
end Pipeline;

architecture Behavioral of Pipeline is

  signal Value_A: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Value_OP: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Value_B: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
  signal Value_C: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin

  process
  begin
    wait until CLK'Event and CLK = '1';
    Value_A <= A;
    Value_OP <= OP;
    Value_B <= B;
    Value_C <= C;
  end process;

  A_Out <= Value_A;
  OP_Out <= Value_OP;
  B_Out <= Value_B;
  C_Out <= Value_C;

end Behavioral;
