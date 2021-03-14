library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity topLevel is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (15 downto 0);     
           sel : out STD_LOGIC_VECTOR (7 downto 0); --sel controls which one is on used to be called an
           seg : out STD_LOGIC_VECTOR (6 downto 0); -- seg controls which seg is active, used to be called cn
           DP : out STD_LOGIC);
end topLevel;

architecture Behavioral of topLevel is
    signal N0,N1,N2,N3,N4,N5,N6,N7,Z : STD_LOGIC_VECTOR (3 downto 0); -- storage vectors to package data and send to 7 seg
    signal SUM : std_logic_vector (5 downto 0);
    signal carry : std_logic; 
     
    component sevenSeg
    port ( clock : in std_logic ;
           d0,d1,d2,d3,d4,d5,d6,d7 : in std_logic_vector (3 downto 0);
           segs : out std_logic_vector (6 downto 0);
           sl : out std_logic_vector (7 downto 0));
    end component;
    
    component fourBitAU 
    Port ( Sel : IN STD_LOGIC_VECTOR (1 downto 0);
         Cin : IN STD_LOGIC;
         Num1, Num2 : IN STD_LOGIC_VECTOR (3 downto 0);
         Fout : OUT STD_LOGIC_VECTOR (3 downto 0);
         Cout : OUT STD_LOGIC );
    end component;
    
    --au port map once its made
--    component fourBitAU
--    port();
--    end component;
    -- signal made to hold one when iterating
    signal b0 : std_logic_vector (3 downto 0);
    signal s0 : std_logic_vector (1 downto 0);
    signal c0 : std_logic ;
    signal cTest : std_logic;
    signal cond : std_logic;
    
begin 
--when displaying on the au stuff the format is A B S ie. 2+2 = 4
    Z <= "0000"; -- simple 0 vector for printing 0
    
    --using far right switches as select lines
    N0 <= "000"&SW(0);
    N1 <= "000"&SW(1);
    N2 <= "000"&SW(2);
    
    s0 <= sw(2 downto 1);
    
    N6 <= SW(11 downto 8);
    N7 <= SW(15 downto 12);
    b0 <= N6;
    ALU : fourBitAU port map(Cin => SW(0) , num1 => N7, num2 => b0, sel=> s0, fout=> N4, cout=>LED(0));
    --cond <= (not(sw(2)) and not(sw(1)) and SW(0)) or (sw(2)and not(sw(0))) or (sw(2) and sw(1));
    --cTest <= c0 AND not((cond));
    --N5 <= "000"&cTest;
    seg7 : sevenSeg port map(clock => CLK, d0=>N0, d1=>N1, d2=>N2, d3=>Z, d4=>N4, d5=>Z, d6=>N6, d7=>N7, segs => seg, sl=>sel);

end Behavioral;

