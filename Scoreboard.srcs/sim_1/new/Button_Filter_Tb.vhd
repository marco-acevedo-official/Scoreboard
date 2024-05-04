library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Button_Filter_Tb is
--  Port ( );
end Button_Filter_Tb;

architecture Simulationo of Button_Filter_Tb is
constant period : time := 10 ns;
constant Register_Size : integer := 4;
signal dirty_in, clean_out, clock, reset : std_logic := '0';
signal Debouncer_Filter_Register : std_logic_vector(Register_Size-1 downto 0) := (others => '0');
begin

Filter_Instance : entity work.Button_Filter
    Generic map (
        clock_period => period,
        reg_width => Register_Size
    )
    Port map (
        clockin => clock,
        resetin => reset,
        raw_input => dirty_in,
        clean_output => clean_out,
        deb_reg_out => Debouncer_Filter_Register
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
    dirty_in <= '1';
    wait for period*50;
    dirty_in <= '0';
    wait for period;
        dirty_in <= '1';
    wait for period*50;
    dirty_in <= '0';
    wait for period;
        dirty_in <= '1';
    wait for period*50;
    dirty_in <= '0';
    wait for period;
    wait;
end process stimulus;

end Simulationo;
