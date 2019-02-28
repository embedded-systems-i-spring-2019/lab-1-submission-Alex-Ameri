--
-- filename:    blinker_tb.vhd
-- written by:  steve dinicolantonio
-- description: testbench for blinker.vhd
-- notes:       
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div_testbench is
end clock_div_testbench;

architecture testbench of clock_div_testbench is

    signal tb_clk : std_logic := '0';
    signal tb_led0 : std_logic;
    
    component clock_div is
        port(      
            clk  : in std_logic;        -- 125 Mhz clock           
            div : out std_logic        -- led, '1' = on 
        );
    end component;

begin

--------------------------------------------------------------------------------
-- procs
--------------------------------------------------------------------------------

    -- simulate a 125 Mhz clock
    clk_gen_proc: process
    begin
    
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';
    
    end process clk_gen_proc;
    
--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------

    dut : clock_div port map (tb_clk, tb_led0);

    
end testbench; 
