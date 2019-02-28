----------------------------------------------------------------------------------
-- Company: DIVIDER_TOP
-- Engineer: 
-- 
-- Create Date: 02/20/2019 02:53:41 AM
-- Design Name: 
-- Module Name: divider_top - Behavioral
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

entity divider_top is
    Port ( clk : in STD_LOGIC;
           led0 : out STD_LOGIC);
end divider_top;

architecture Behavioral of divider_top is

    --Clock Div
    component clock_div is
        Port ( clk : in STD_LOGIC;
               div : out STD_LOGIC);
    end component;
    
    --Signals
    signal CE : STD_LOGIC;
    signal D : STD_LOGIC;
    signal Q : STD_LOGIC := '0';
begin

    --tie things together
    led0 <= Q;
    
    --Instantiate clock div
    U1 : clock_div port map(clk, CE);
    
    --Inverter
    D <= (not Q);
    
    --register
    RTL_REG : process (clk)
    begin
        if(rising_edge(clk) and CE = '1') then
            Q <= D;
        end if;
    end process;

end Behavioral;
