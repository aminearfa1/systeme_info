----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 13:39:33
-- Design Name: 
-- Module Name: Banc_Registre - Behavioral
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

entity Banc_Registre is
    Port ( addA : in STD_LOGIC_VECTOR (3 downto 0);
           addB : in STD_LOGIC_VECTOR (3 downto 0);
           addW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_Registre;

architecture Behavioral of Banc_Registre is

    type registerArray is array (0 to 15) of std_logic_vector(7 downto 0);
    signal Banc_Registre : registerArray := (others => (others => '0'));
    signal bypass_value : std_logic_vector(7 downto 0);

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '0' then
                Banc_Registre <= (others => (others => '0'));
            elsif W = '1' then
                Banc_Registre(to_integer(unsigned(addW))) <= DATA;
                bypass_value <= DATA;  -- Sauvegarde de la valeur écrite dans le registre pour le bypass
            end if;
        end if;
    end process;
    
    

    QA <= Banc_Registre(to_integer(unsigned(addA)));
    QB <= Banc_Registre(to_integer(unsigned(addB)));

 
end Behavioral;