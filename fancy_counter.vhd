----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 12:12:15 AM
-- Design Name: 
-- Module Name: fancy_counter - Behavioral
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

entity fancy_counter is
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
end fancy_counter;

architecture Behavioral of fancy_counter is
    -- Bit 4 is used to detect underflow, bit 5 is used to detect overflow
    signal counter : STD_LOGIC_VECTOR (width - 1 downto 0) := (others => '0');
    signal direction : STD_LOGIC := '1'; --Register. When it is 1 we count up, else count down
    signal value : STD_LOGIC_VECTOR (width - 1 downto 0) := (others => '0');
    signal device_enabled : STD_LOGIC;
begin
    --Tie things together
    cnt <= counter;
    device_enabled <= en and clk_en;
    
    --Determine direction
    count_direction : process(clk, dir)
    begin
        if(device_enabled = '1') then
            if(rising_edge(clk) and updn = '1') then
                direction <= dir;
            end if;
        end if;
    end process;
    
    --Load new value
    load_new : process(clk, ld)
    begin
        if(device_enabled = '1') then
            if(rising_edge(clk) and ld = '1') then
                value <= val;
            end if;
        end if;
    end process;
    
    --count on the rising clock edge
    count_process : process(clk)
    begin
        --COUNT LOGIC
            if(rising_edge(clk)) then
                --RESET LOGIC
                if(en = '1' and rst = '1') then
                    counter <= (others => '0');
                elsif(device_enabled = '1') then  
                   -- COUNTING
 		           if(direction = '1') then
                        --Make sure not to count if we've hit the target threshold!
                        if(unsigned(counter) < unsigned(value)) then
                            counter <= std_logic_vector(unsigned(counter) + 1);
                        else
                            --OVERFLOW HAPPENED
                            counter <= (others => '0');
                        end if;
                    elsif(direction = '0') then
                        --CHECK FOR UNDERFLOW
                        if(To_integer(unsigned(counter)) /= 0) then
                            counter <= std_logic_vector(unsigned(counter) - 1);
                        else
                            -- underflow happened
                            counter <= value;
                        end if;
                    end if;
                end if;  
            end if;
    end process;

end Behavioral;
