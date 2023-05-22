----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 12:44:39
-- Design Name: 
-- Module Name: ALU - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

    entity ALU is
    Port (
        A : in STD_LOGIC_VECTOR (7 downto 0);
        B : in STD_LOGIC_VECTOR (7 downto 0);
        Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
        S : out STD_LOGIC_VECTOR (7 downto 0);
        N : out STD_LOGIC;
        O : out STD_LOGIC;
        Z : out STD_LOGIC;
        C : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is

    -- Signaux internes pour les valeurs intermédiaires
    signal res: STD_LOGIC_VECTOR (7 downto 0);
    signal res1: STD_LOGIC_VECTOR (15 downto 0);
    signal flag_O: STD_LOGIC := '0';
    signal flag_C: STD_LOGIC := '0';
    signal flag_Z: STD_LOGIC := '0';
    signal flag_N: STD_LOGIC := '0';

begin


    process(Ctrl_Alu, A, B)
    begin

        if (Ctrl_Alu = "001") then
            -- Addition
            res1 <= (x"00" & A) + (x"00" & B);

        elsif (Ctrl_Alu = "010") then
            -- Soustraction
            res1 <= (x"00" & A) - (x"00" & B);

       elsif (Ctrl_Alu = "011") then
    -- Multiplication
          res1 <= A * B;
    --res <= res1(15 downto 8); -- Réduction de la taille du résultat à 8 bits

        else
            -- Réinitialisation des résultats
            res1 <= (others => '0');
        end if;

    end process;
    res <= res1(7 downto 0);

    -- Détermination des drapeaux
    flag_C <= '1' when ((res) > 255) else '0';
    flag_O <= res(7);
    flag_Z <= '1' when (res = 0) else '0';
    flag_N <= res(7); --set the N flag to the MSB of the result

    -- Assign flags and result to outputs
    N <= flag_N;
    O <= flag_O;
    Z <= flag_Z;
    C <= flag_C;
    S <= std_logic_vector(res);

end Behavioral;