library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Debouncer_Tb is
--  Port ( );
end Debouncer_Tb;

architecture Simulation of Debouncer_Tb is
constant period : time := 10 ns;
constant number : integer := 8;
signal debouncer_register : STD_LOGIC_VECTOR(number-1 downto 0) := (others =>'0');
signal steady, jittery, clock : std_logic := '0';
begin

Debouncer_Instance : entity work.Debouncer
generic map(clock_period => period, reg_width=> number )
port map(
    clk => clock,
    input_signal => jittery,
    debounced_signal => steady,
    reg_out => debouncer_register
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
    for i in 1 to 101 loop
    jittery <= not jittery;
    wait for period / 100;
    end loop;
    jittery <= '1';
    wait for period*50;
    jittery <= '0';
    wait for period;
    wait;
end process stimulus;

end Simulation;
