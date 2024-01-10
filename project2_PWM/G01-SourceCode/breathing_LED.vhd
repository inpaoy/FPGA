----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/09/13 16:22:11
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity breathing_LED is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           F   : in STD_LOGIC_VECTOR(3 downto 0);
           min : in STD_LOGIC_VECTOR(7 downto 0);
           MAX : in STD_LOGIC_VECTOR(7 downto 0);
           pwm : out STD_LOGIC);
end breathing_LED;

architecture Behavioral of breathing_LED is
type STATE_TYPE1 is (S0, S1);
signal state1: STATE_TYPE1;
type STATE_TYPE2 is (getting_bright, getting_dark);
signal state2: STATE_TYPE2;
signal count1, count2: STD_LOGIC_VECTOR(7 downto 0);
signal up1, up2 :  STD_LOGIC_VECTOR(7 downto 0);
signal k :  STD_LOGIC_VECTOR(3 downto 0);
begin

 FSM2: process(clk, rst)
 begin
     if rst='0' then
          state2 <= getting_bright; --變亮中
     elsif clk'event and clk = '1' then
         case state2 is
         when getting_bright =>
             if( up1 >= MAX and up2 <= min ) then --已經最亮
                 state2 <= getting_dark;
             end if;
         when getting_dark =>
             if( up1 <= min and up2 >= max ) then --已經最暗
                 state2 <= getting_bright;
             end if;
         when others => 
             state2 <= getting_bright;
         end case;
     end if;
 end process;

 up1_p: process(clk, rst, state2, k)
 begin
     if rst='0' then
          up1 <= min;
     elsif clk'event and clk = '1' then
         case state2 is
         when getting_bright =>
             if k = F then
                 up1 <= up1 + '1';
             end if;
         when getting_dark =>
             if k = F then         
                 up1 <= up1 - '1';
             end if;
         when others => 
             up1 <= min;
         end case;
     end if;
 end process;

 up2_p: process(clk, rst, state2)
 begin
     if rst='0' then
          up2 <= MAX;
     elsif clk'event and clk = '1' then
         case state2 is
         when getting_bright =>
             if k = F then         
                 up2 <= up2 - '1';
             end if;
         when getting_dark =>
             if k = F then
                 up2 <= up2 + '1';
             end if;
         when others => 
             up2 <= MAX;
         end case;
     end if;
 end process;
 
 k_p:process(clk, rst, F)
 begin
     if rst='0' then
          k <= "0000";
     elsif clk'event and clk = '1' then
         if k < F then
             k <= k+'1';
         else
             k <= "0000";
         end if;
     end if;
 end process;

pwm_p: process(clk, rst)
 begin
     if rst='0' then
          pwm <= '0';
     elsif clk'event and clk = '1' then
         case state1 is
         when S0 =>
             pwm <= '1';
         when S1 =>
             pwm <= '0';
         when others => 
             pwm <= '0';
         end case;
     end if;
 end process; 

 FSM1: process(clk, rst)
 begin
     if rst='0' then
          state1 <= S0;
     elsif clk'event and clk = '1' then
         case state1 is
         when S0 =>
             if count1 >= up1 then --(counter1數完) then
                 state1 <= S1;
             end if;
         when S1 =>
             if count2 >=up2 then --(counter2數完) then
                 state1 <= S0;
             end if;
         when others => 
             state1 <= S0;
         end case;
     end if;
 end process;
 
 counter_1: process(clk, rst, state1)
 begin
     if rst='0' then
          count1 <= "00000000";
     elsif clk'event and clk = '1' then
         case state1 is
         when S0 =>
             count1 <= count1 + '1';
             --count2 <= "00000000";
         when S1 =>
             --count2 <= count2 + '1';
             count1 <= "00000000";
         when others => 
             count1 <= "00000000";
         end case;
     end if;
 end process;

 counter_2: process(clk, rst, state1)
 begin
     if rst='0' then
          count2 <= "00000000";
     elsif clk'event and clk = '1' then
         case state1 is
         when S0 =>
             --count1 <= count1 + '1';
             count2 <= "00000000";
         when S1 =>
             count2 <= count2 + '1';
             --count1 <= "00000000";
         when others => 
             count2 <= "00000000";
         end case;
     end if;
 end process;

end Behavioral;
