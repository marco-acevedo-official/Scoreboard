library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity synchronizer is
  generic (
    clock_period : time := 10 ns
  );
  port(
    rst      : in std_logic;
    clk      : in std_logic;
    data_in  : in std_logic;
    data_out : out std_logic
  );
end synchronizer;

architecture Behavior of synchronizer is
signal flag : std_logic := '0';
begin

process(clk,data_in,rst)
begin

    if flag = '0' then
        data_out <= '0';
    end if;

    if rising_edge(data_in) and flag = '0' then
        flag <= '1';
        report "Synchronizer Flag Set 1";
    end if;
    
    if rising_edge(clk) and flag = '1' then
        report "Synchronizer data_out Set 1";
        data_out <= '1';
--        data_out <= '0' after clock_period / 2;
--        report "Synchronizer data_out Set 0";
--        flag <= '0';
--        report "Synchronizer FLAG Set 0";
    end if;
    if falling_edge(clk) and flag = '1' then
        data_out <= '0';
        report "Synchronizer data_out Set 0";
        flag <= '0';
    end if;
    
    if rst = '1' then
        flag <= '0';
        report "Synchronizer RST Set 1";
    end if;
    
end process;

end architecture;