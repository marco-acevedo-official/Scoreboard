library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Scoreboard_Final_Tb is
--  Port ( );
end Scoreboard_Final_Tb;

architecture Simulation of Scoreboard_Final_Tb is
constant period : time := 10 ns;
constant Register_Size : integer := 1;
signal increase, decrease, clock, reset : std_logic := '0';
signal Display1, Display0: unsigned(6 downto 0) := (others => '0');
signal BCD1, BCD0 : std_logic_vector(3 downto 0) := (others => '0');
signal DisplayOut : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin

	Scoreboard_F_Instance : entity work.Scoreboard_Final
    Generic map (
        clock_period_F => period,
        reg_width_F => Register_Size
    )
    Port map (
        clk_F => clock,
        rst_F => reset,
        inc_FR => increase,
        dec_FR => decrease,
        pmod => DisplayOut
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
		
		increase <= '1';
		wait for period;
		
		increase <= '0';
		wait for period;
		
		increase <= '1';
		wait for period;
		
		increase <= '0';
		wait for period;
		
		wait;
	end process stimulus;

end Simulation;
