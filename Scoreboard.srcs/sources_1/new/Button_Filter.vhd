library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Button_Filter is
    Generic (
        clock_period : time := 10 ns;
        reg_width : integer := 16
    );
    Port(
        clockin : in STD_LOGIC;
        resetin : in STD_LOGIC;
        raw_input : in STD_LOGIC;
        clean_output : out STD_LOGIC;
        deb_reg_out : out STD_LOGIC_VECTOR(reg_width-1 downto 0)
    );
end Button_Filter;

architecture wiring of Button_Filter is
signal intermediary : std_logic := '0';

begin

    deb : entity work.Debouncer
    generic map(
        clock_period => clock_period,
        reg_width => reg_width
    )
    port map(
        clk => clockin,
        input_signal => raw_input,
        debounced_signal => intermediary,
        reg_out => deb_reg_out
    );

    syn : entity work.Synchronizer
    generic map(clock_period => clock_period)
    port map(
        rst => resetin,
        clk => clockin,
        data_in => intermediary,
        data_out => clean_output
    );

end wiring;