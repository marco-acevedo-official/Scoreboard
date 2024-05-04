library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Synchronizer_Tb is
end Synchronizer_Tb;

architecture Simulation of Synchronizer_Tb is
constant period : time := 10 ns;
constant number : integer := 8;
signal reset, steady, jittery, clock : std_logic := '0';
begin
sync_instance : entity work.Synchronizer
  generic map (
    clock_period => period
  )
  port map (
    rst      => reset,
    clk      => clock,
    data_in  => jittery,
    data_out =>steady
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
    jittery <= '1';
    wait for period*50;
    jittery <= '0';
    wait for period;
    jittery <= '1';
    wait for period*50;
    jittery <= '0';
    wait for period;
    wait;
end process stimulus;
end Simulation;
