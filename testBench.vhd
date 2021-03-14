library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder6bit_TB is
end Adder6bit_TB;

architecture Behavioral of Adder6bit_TB is

component fourBitAU 
    Port ( Sel : IN STD_LOGIC_VECTOR (1 downto 0);
         Cin : IN STD_LOGIC;
         Num1, Num2 : IN STD_LOGIC_VECTOR (3 downto 0);
         Fout : OUT STD_LOGIC_VECTOR (3 downto 0);
         Cout : OUT STD_LOGIC );
    end component;

signal sel : STD_LOGIC_VECTOR (1 downto 0);
signal num1, num2, Fout : STD_LOGIC_VECTOR (3 downto 0);
signal Cout, Cin : STD_LOGIC;

signal clock : STD_LOGIC := '0';
signal clk_period : TIME := 20 ns;

begin

    uut: fourBitAU Port Map ( Sel  => sel,
                           Num1 => num1,
                           Num2 => num2,
                           Fout => Fout,
                           Cout => Cout,
                           Cin  => Cin );
                              
    clk_process: process
    begin
        clock <= '1';
        wait for clk_period / 2;
        clock <= '0';
        wait for clk_period / 2;
    end process clk_process;

                              
    test_bench : process
    begin
        -- A + B test
        num1 <= "0001";
        num2 <= "0010";
        sel  <= "00";
        Cin  <= '0';
        wait for clk_period;
        assert (Fout = "0011") AND (Cout = '0');
        
        -- A + B test
        num1 <= "1111";
        num2 <= "0001";
        sel  <= "00";
        Cin  <= '0';
        wait for clk_period;
        assert (Fout = "0000") AND (Cout = '1');
        
        -- NOT(A) + B test
        num1 <= "0001";
        num2 <= "0001";
        sel  <= "01";
        Cin  <= '0';
        wait for clk_period;
        assert (Fout = "1111") AND (Cout = '0');
        
        -- NOT(A) + B test
        num1 <= "0001";
        num2 <= "0010";
        sel  <= "01";
        Cin  <= '0';
        wait for clk_period;
        --assert (Fout = "0000") AND (Cout = '1');
        
        -- A - 1 test
        num1 <= "0001";
        num2 <= "0000";
        sel  <= "10";
        Cin  <= '0';
        wait for clk_period;
        --assert (Fout = "0000") AND (Cout = '0');
        
        -- A - 1 test
        num1 <= "0110";
        num2 <= "0000";
        sel  <= "10";
        Cin  <= '0';
        wait for clk_period;
        assert (Fout = "0101") AND (Cout = '1');
        
        -- NOT(A) test
        num1 <= "0001";
        num2 <= "0000";
        sel  <= "11";
        Cin  <= '0';
        wait for clk_period;
        assert (Fout = "1110");
        
        -- NOT(A) test
        num1 <= "1101";
        num2 <= "0000";
        sel  <= "11";
        Cin  <= '0';
        wait for clk_period;
        assert (Fout = "0010");
        
        -- A + NOT(B) + 1 (sub) test
        num1 <= "0011";
        num2 <= "0001";
        sel  <= "00";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "0010") AND (Cout = '1');
        
        -- A + NOT(B) + 1 (sub) test
        num1 <= "0110";
        num2 <= "0010";
        sel  <= "00";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "0100") AND (Cout = '1');
        
        -- NOT(A) + B + 1 (sub) test
        num1 <= "0010";
        num2 <= "0001";
        sel  <= "01";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "1111") AND (Cout = '0');
        
        -- NOT(A) + B + 1 (sub) test
        num1 <= "0010";
        num2 <= "0110";
        sel  <= "01";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "0100") AND (Cout = '1');
        
        -- A + 1 test
        num1 <= "0010";
        num2 <= "0000";
        sel  <= "10";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "0011") AND (Cout = '0');
        
        -- A + 1 test
        num1 <= "1111";
        num2 <= "0000";
        sel  <= "10";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "0000") AND (Cout = '1');
        
        -- NOT(A) + 1
        num1 <= "0010";
        num2 <= "0000";
        sel  <= "11";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "1110") AND (Cout = '0'); 
        
        -- NOT(A) + 1
        num1 <= "0000";
        num2 <= "0000";
        sel  <= "11";
        Cin  <= '1';
        wait for clk_period;
        assert (Fout = "0000") AND (Cout = '1'); 
          
        wait;
    end process;

end Behavioral;
