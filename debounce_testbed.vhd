----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2019 08:24:18 AM
-- Design Name: 
-- Module Name: debounce_testbed - Behavioral
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

entity debounce_testbed is
end debounce_testbed;
architecture Behavioral of debounce_testbed is
    --Components
    component debounce is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           dbnce : out STD_LOGIC);
    end component;
    
    --signals
    signal button, clock, db_out : STD_LOGIC := '0';
    
begin
    debounced_button : debounce port map (button, clock, db_out);
    
    --clock process
    clock_proc : process
    begin
        wait for 4 ns;
        clock <= not clock;
    end process;
    
    --button process
    button_proc : process
    begin
        button <= '0';
        wait for 1000000 ns;
        
        button <= '1';
        wait for 50000000 ns;
        
        button <= '0';
        wait for 50000000 ns;
        
        button <= '1';
        wait for 50000000 ns;
    end process;

end Behavioral;
