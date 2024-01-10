--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:10:02 10/25/2023
-- Design Name:   
-- Module Name:   C:/Xilinx/user/temp/breat_led_tb.vhd
-- Project Name:  temp
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: breathing_LED
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY breat_led_tb IS
END breat_led_tb;
 
ARCHITECTURE behavior OF breat_led_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT breathing_LED
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         F : IN  std_logic_vector(3 downto 0);
         min : IN  std_logic_vector(7 downto 0);
         MAX : IN  std_logic_vector(7 downto 0);
         pwm : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal F : std_logic_vector(3 downto 0) := (others => '0');
   signal min : std_logic_vector(7 downto 0) := (others => '0');
   signal MAX : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pwm : std_logic;
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: breathing_LED PORT MAP (
          clk => clk,
          rst => rst,
          F => F,
          min => min,
          MAX => MAX,
          pwm => pwm
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '0';
      min <= "00000001";
      MAX <= "11111110";  
      F <= "0100";    
      wait for 100 ns;
      
      rst <= '1';	

      wait for clk_period*300;

      -- insert stimulus here 

      wait;
   end process;

END;
