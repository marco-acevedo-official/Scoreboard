library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Scoreboard_Tb is
end Scoreboard_Tb;

architecture Simulation of Scoreboard_Tb is
constant period : time := 10 ns;
constant Register_Size : integer := 4;
signal increase, decrease, clock, reset : std_logic := '0';
signal Debouncer_Filter_Register : std_logic_vector(Register_Size-1 downto 0) := (others => '0');
signal Display1, Display0: unsigned(6 downto 0) := (others => '0');
signal BCD1, BCD0 : std_logic_vector(3 downto 0) := (others => '0');

begin

	scoreboard_instance : entity work.Scoreboard
    generic map (
        clock_period => period,
        reg_width => Register_Size
    )
    port map (
        clk => clock,
        rst => reset,
        inc => increase,
        dec => decrease,
        seg7disp1 => Display1,
        seg7disp0 => Display0,
        bcd1_out => BCD1,
        bcd0_out => BCD0
    );
    
    clock_process : process
	begin
        while true loop
            clock <= '0';                            
            wait for period / 2;                
            clock <= '1';                            
            wait for period / 2;                
        end loop;
	end process;
	
	stimulus: process
	begin 
		increase <= '1';
		wait for period;
		
		increase <= '0';
		wait for period;
		
		increase <= '1';
		wait for period;
		
		increase <= '0';
		wait for period;
		
		increase <= '1';
		wait for period;
		
		increase <= '0';
		wait for period;
		
				increase <= '1';
		wait for period;
		
		increase <= '0';
		wait for period;
		
		decrease <= '1';
		wait for period;
		
		decrease <= '0';
		wait for period;
		
		wait;
	end process stimulus;

end Simulation;
