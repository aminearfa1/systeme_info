----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2023 09:43:20
-- Design Name: 
-- Module Name: Processor - Behavioral
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

-- A : 31 -- Op : 23 --   B : 15  --   C : 7 


entity processor is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC);
end processor;

architecture Behavioral of processor is

component Counter 
    Port ( NUM : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           A_F : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Instruction_Memory 
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Banc_Registre
    Port ( addA : in STD_LOGIC_VECTOR (3 downto 0); 
           addB : in STD_LOGIC_VECTOR (3 downto 0);
           addW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC; --Vecteur 0/1 1 bit
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC; --Vecteur 0/1 1bit
           CLK : in STD_LOGIC; --same
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component ALU 
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0); 
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end component;

component Data_Memory
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Pipeline is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
         OP : in STD_LOGIC_VECTOR (7 downto 0);
         B : in STD_LOGIC_VECTOR (7 downto 0);
         C : in STD_LOGIC_VECTOR (7 downto 0);
         CLK : in STD_LOGIC;
         A_Out : out STD_LOGIC_VECTOR (7 downto 0);
         OP_Out : out STD_LOGIC_VECTOR (7 downto 0);
         B_Out : out STD_LOGIC_VECTOR (7 downto 0);
         C_Out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--- Memory instructions
--inputs
signal Instructions_Memory_add : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal Instructions_Counter : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
--Alea signal to increment the counter or not when and alea is found
signal Instructions_Memory_Cntrl : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
--output
signal Instructions_Memory_Output :  STD_LOGIC_VECTOR (31 downto 0):= ( others => '0');

--- Bank of registers
--inputs
signal Registers_addA : STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');-- instancier à 0
signal Registers_addB :  STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');
signal Registers_addW : STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');
signal Registers_W :  STD_LOGIC:='0';
signal Registers_DATA :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');

--output
signal Registers_QA :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal Registers_QB :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');

--- UAL
-- inputs
signal ALU_A : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal ALU_B : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
-- out puts
signal ALU_S : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal ALU_N : STD_LOGIC :='0';
signal ALU_O : STD_LOGIC :='0';
signal ALU_Z : STD_LOGIC :='0';
signal ALU_C : STD_LOGIC :='0';

--- Data memory
 --inputs 
signal RISC_SI_add : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal RISC_SI_RW :  STD_LOGIC:='1';
signal RISC_SI_INPUT :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal RISC_SI_RST :  STD_LOGIC:='0';

--output
signal RISC_SI_OUTPUT : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
--clk      
-- Si 100 MHz
constant Clock_period : time := 10 ns;
--Buffer Pipelines
signal A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); 
signal OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); 
signal B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); 
signal C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); 

signal ROM_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal ROM_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal ROM_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal ROM_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');


signal LI_DI_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal LI_DI_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal LI_DI_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal LI_DI_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal LI_DI_MUX_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal DI_EX_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal DI_EX_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal DI_EX_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal DI_EX_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal EX_MEM_MUX_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal EX_MEM_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal EX_MEM_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal EX_MEM_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal EX_MEM_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal MEM_MUX_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal MEM_MUX_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal MEM_RE_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal MEM_RE_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal MEM_RE_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal MEM_RE_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

-- alea gestion
signal Alea_Found: STD_LOGIC :='0';

begin

A  <= Instructions_Memory_Output(31 downto 24); -- A : 31 downto 24
OP  <= Instructions_Memory_Output(23 downto 16); -- Op : 23 down to 16
B  <= Instructions_Memory_Output(15 downto 8); -- B : 15 down to 8 addA
C  <= Instructions_Memory_Output(7 downto 0); -- C : 7 down to 0 addB

CNT_PORT_MAP : Counter PORT MAP (
    NUM => Instructions_Memory_Cntrl,
    CLK => CLK,
    A_F => Alea_Found,
    OUTPUT => Instructions_Counter
);

Instructions_Memory_Port_Map:Instruction_Memory  PORT MAP (
    add => Instructions_Counter,
    CLK => CLK, 
    OUTPUT => Instructions_Memory_Output
);

--MUX ZERO Between ROM and LI/DI for alea gestion
ROM_A <=A;
    
ROM_OP <= 
    x"00" when Alea_Found='1' else --COP before an AFC
    OP;
        
ROM_B <=B;
            
ROM_C <=C;
    
Alea_Found <=
    '1' when (OP=x"05" and LI_DI_OP=x"06") else --AFC then COP 
    '1' when (OP=x"05" and DI_EX_OP=x"06") else --AFC then COP 
    '1' when (OP=x"05" and EX_MEM_OP=x"06") else --AFC then COP 
    '1' when (OP=x"07" and LI_DI_OP=x"08") else --STORE then LOAD 
    '1' when (OP=x"07" and DI_EX_OP=x"08") else --STORE then LOAD 
    '1' when (OP=x"05" and LI_DI_OP=x"07") else --LOAD then COP 
    '1' when (OP=x"05" and DI_EX_OP=x"07") else --LOAD then COP 
    '1' when((OP=x"01" 
           or OP=x"02"
           or OP=x"03"
           or OP=x"04") and LI_DI_OP=x"06") else --(AFC then ALU OP)
    '1' when((OP=x"01" 
           or OP=x"02"
           or OP=x"03"
           or OP=x"04") and DI_EX_OP=x"06") else --(AFC then ALU OP)
    '1' when((OP=x"05" or OP=x"08") and (LI_DI_OP=x"01" 
                      or   LI_DI_OP=x"02"
                      or   LI_DI_OP=x"03"
                      or   LI_DI_OP=x"04")) else --(ALU then COP/STORE)
    '1' when((OP=x"05" or OP=x"08") and (DI_EX_OP=x"01" 
                      or   DI_EX_OP=x"02"
                      or   DI_EX_OP=x"03"
                      or   DI_EX_OP=x"04")) else --(ALU then COP/STORE)           
    '1' when (OP=x"08" and LI_DI_OP=x"06") else --AFC then STORE 
    '1' when (OP=x"08" and DI_EX_OP=x"06") else --AFC then STORE 
    '0';
    
 

LI_DI : Pipeline PORT MAP (
    A => ROM_A,
    OP => ROM_OP,
    B => ROM_B,
    C => ROM_C,
    CLK => CLK,
    A_Out => LI_DI_A,
    OP_Out => LI_DI_OP,
    B_Out => LI_DI_B,
    C_Out => LI_DI_C
);

Registers_W <= 
    '1' when MEM_RE_OP=x"01" else --ADD
    '1' when MEM_RE_OP=x"02" else --MUL
    '1' when MEM_RE_OP=x"03" else --SOU
    '1' when MEM_RE_OP=x"04" else --DIV
    '1' when MEM_RE_OP=x"05" else --COP
    '1' when MEM_RE_OP=x"06" else --AFC
    '1' when MEM_RE_OP=x"07" else --LOAD
    '0' when MEM_RE_OP=x"08" else --STORE
    '0';

Registers_Port_Map: Banc_Registre  PORT MAP (
    addA => LI_DI_B(3 downto 0),
    addB => LI_DI_C(3 downto 0), 
    addW => MEM_RE_A(3 downto 0),
    W => Registers_W,
    DATA => MEM_RE_B,
    RST => RST,
    CLK => CLK,
    QA => Registers_QA,
    QB => Registers_QB
);

--FIRST MUX Between LI/DI and DI/EX to select the QA
with LI_DI_OP select
     LI_DI_MUX_B <= Registers_QA when x"01", --ADD
                    Registers_QA when x"02", --MUL
                    Registers_QA when x"03", --SOU
                    Registers_QA when x"04", --DIV
                    Registers_QA when x"05", --COP
                    Registers_QA when x"08", --STORE
                    LI_DI_B when others;
                    
DI_EX : Pipeline PORT MAP (
    A => LI_DI_A,
    OP => LI_DI_OP,
    B => LI_DI_MUX_B,
    C => Registers_QB,
    CLK => CLK,
    A_Out => DI_EX_A,
    OP_Out => DI_EX_OP,
    B_Out => DI_EX_B,
    C_Out => DI_EX_C
);

--SECOND MUX Between DI/EX and EX/MEM to select the ALU_S or DI_EX_B
with DI_EX_OP select
     EX_MEM_MUX_B<= ALU_S when x"01", --ADD
                    ALU_S when x"02", --MUL
                    ALU_S when x"03", --SOU
                    ALU_S when x"04", --DIV
                    DI_EX_B when others;
                    
ALU_Port_Map: ALU  PORT MAP (
    A => DI_EX_B,
    B => DI_EX_C,
    Ctrl_Alu => DI_EX_OP(2 downto 0),
    S => ALU_S,
    N => ALU_N,
    O => ALU_O,
    Z => ALU_Z,
    C => ALU_C
);
                    
EX_MEM : Pipeline PORT MAP (
    A => DI_EX_A,
    OP => DI_EX_OP,
    B => EX_MEM_MUX_B,
    C => DI_EX_C,
    CLK => CLK,
    A_Out => EX_MEM_A,
    OP_Out => EX_MEM_OP,
    B_Out => EX_MEM_B,
    C_Out => EX_MEM_C
);

with EX_MEM_OP select
     MEM_MUX_A <= EX_MEM_B when x"07", --LOAD
                  EX_MEM_A when x"08", --STORE
                  X"00" when others;

Data_Memory_Port_Map: Data_Memory  PORT MAP (
    add => MEM_MUX_A,
    INPUT => EX_MEM_B, --(7 downto 0);
    RW => RISC_SI_RW,-- 0/1
    RST => RST, --0/1
    CLK => CLK, --0/1
    OUTPUT => RISC_SI_OUTPUT -- (7 downto 0));
);

--FOURTH MUX Between RISC_SI and MEM_RE to select the EX_MEM_B or EX_MEM_A
with EX_MEM_OP select
     MEM_MUX_B <= RISC_SI_OUTPUT when x"07", --LOAD
                  EX_MEM_B when others;
                  
RISC_SI_RW <= 
    '1' when EX_MEM_OP=x"07" else --LOAD Read
    '0' when EX_MEM_OP=x"08" else --STORE Write
    '1';

MEM_RE : Pipeline PORT MAP (
    A => EX_MEM_A,
    OP => EX_MEM_OP,
    B => MEM_MUX_B,
    C => EX_MEM_C,
    CLK => CLK,
    A_Out => MEM_RE_A,
    OP_Out => MEM_RE_OP,
    B_Out => MEM_RE_B
);


process(RST,CLK)
begin
    if(RST='0') then
        Instructions_Memory_add <= X"00";
    elsif(CLK'event and CLK='1') then  
        
        if(Alea_Found='0') then
        Instructions_Memory_add<=Instructions_Memory_Cntrl;
        end if;
       
        Instructions_Memory_Cntrl<=Instructions_Counter; 
    end if; 
end process;

end Behavioral;