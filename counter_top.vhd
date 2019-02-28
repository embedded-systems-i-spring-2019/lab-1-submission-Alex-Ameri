----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 02:22:00 AM
-- Design Name: 
-- Module Name: counter_top - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_top is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (3 downto 0);
           sw : in STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0));
end counter_top;

architecture Behavioral of counter_top is
    --Components
    --Counter
    component fancy_counter is
    Generic (width : integer := 4);
    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           dir : in STD_LOGIC;
           en : in STD_LOGIC;
           ld : in STD_LOGIC;
           rst : in STD_LOGIC;
           updn : in STD_LOGIC;
           val : in STD_LOGIC_VECTOR (width - 1 downto 0);
           cnt : out STD_LOGIC_VECTOR (width - 1 downto 0));
    end component;
    
    --Debouncer
    component debounce is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           dbnce : out STD_LOGIC);
    end component;
    
    --Clock Divider
    component clock_div is
    Port ( clk : in STD_LOGIC;
           div : out STD_LOGIC);
    end component;
    
    --Signals
    signal debounce0, debounce1, debounce2, debounce3, slowed_clock : STD_LOGIC;
    
begin
    --Instantiate Components
    --Debouncers
    u1 : debounce port map(btn(0), clk, debounce0);
    u2 : debounce port map(btn(1), clk, debounce1);
    u3 : debounce port map(btn(2), clk, debounce2);
    u4 : debounce port map(btn(3), clk, debounce3);
    
    --Clock Divider
    u5 : clock_div port map(clk, slowed_clock);
    
    --Main Counter
   u6 : fancy_counter       
                             port map(clk => clk, 
                               clk_en => slowed_clock, 
                               dir => sw(0), --debounce1, 
                               en => debounce1, 
                               ld => debounce3, 
                               rst => debounce0, 
                               updn => debounce2, 
                               val => sw, 
                               cnt => led);                   

end Behavioral;
