----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 01:13:23 AM
-- Design Name: 
-- Module Name: fancy_counter_tb - Behavioral
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

entity fancy_counter_tb is
    Port ( i : in STD_LOGIC);
end fancy_counter_tb;

architecture Behavioral of fancy_counter_tb is
    --Components
    component fancy_counter is
    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           dir : in STD_LOGIC;
           en : in STD_LOGIC;
           ld : in STD_LOGIC;
           rst : in STD_LOGIC;
           updn : in STD_LOGIC;
           val : in STD_LOGIC_VECTOR (3 downto 0);
           cnt : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    --Signals
    signal clock : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '1';
    signal direction : STD_LOGIC := '1';
    signal clock_enable : STD_LOGIC := '1';
    signal load : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal updown : STD_LOGIC := '0';
    signal loop_continue : STD_LOGIC := '1';
    signal value : STD_LOGIC_VECTOR (3 downto 0) := "1110";
    signal output: STD_LOGIC_VECTOR (3 downto 0);
begin
    topcounter : fancy_counter port map(clock, clock_enable, direction, enable, load, reset, updown, value, output);
    
    clck : process
    begin
        clock <= not clock;
        wait for 4 ns;
    end process;
    
    main : process
    begin
        wait for 16 ns;
        load <= '1';
        updown <= '1';
        wait for 16 ns;
        updown <= '0';
        wait for 8 ns;
        while (loop_continue = '1') loop
            wait for 4 ns;
        end loop;
    end process;

end Behavioral;
