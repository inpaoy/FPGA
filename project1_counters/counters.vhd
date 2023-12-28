
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	Port ( clk : in std_logic;
		   rst : in std_logic;
		   count1 : out std_logic_vector(7 downto 0);
		   count2 : out std_logic_vector(7 downto 0)
		   );
end counter;

architecture Behavioral of counter is
signal cnt1 : std_logic_vector(7 downto 0);
signal cnt2 : std_logic_vector(7 downto 0);
type STATE_TYPE is (S1, S2, tmp1, tmp2);
signal state : STATE_TYPE;
begin
	
	count1 <= cnt1;
	count2 <= cnt2;
	
	FSM : process(clk, rst, cnt1, cnt2)
	begin
		if rst = '1' then
			state <= S1;
		elsif CLK'event and CLK = '1' then
			case state is 
				when S1 =>
					if cnt1 >= "1111"&"1100" then --counter1
						state <= tmp1;
					else
						state <= S1;
					end if;
				when tmp1 =>
					state <= S2;
				when S2 =>
					if cnt2 <= "0010"&"1011" then --counter2
						state <= tmp2;
					else
						state <= S2;
					end if;
				when tmp2 =>
					state <= S1;
				when others =>
					null;
			end case;
		end if;
	end process;
	
	counter1 : process(clk, rst, state)
	begin
		if rst = '1' then
			cnt1 <= "0000"&"1101"; --13
		elsif CLK'event and CLK = '1' then
			case state is 
				when S1 =>
					cnt1 <= cnt1 + '1'; --counter1
				when tmp1 =>
					cnt1 <= "0000"&"1101";
				when S2 =>
					cnt1 <= "0000"&"1101";
				when tmp2 =>
					null;
				when others =>
					null;
			end case;
		end if;
	end process;
	
	counter2 : process(clk, rst, state)
	begin
		if rst = '1' then
			cnt2 <= "1010"&"0001"; --
		elsif CLK'event and CLK = '1' then
			case state is 
				when S1 =>
					cnt2 <= "1010"&"0001" ; --counter1
				when tmp1 =>
					null;
				when S2 =>
					cnt2 <= cnt2 - '1';
				when tmp2 =>
					cnt2 <= "1010"&"0001";
				when others =>
					null;
			end case;
		end if;
	end process;
	
end Behavioral;
