library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

entity read_file is
end entity;

architecture example of read_file is
  type memory_array is array (31 downto 0) of std_logic_vector (7 downto 0);
  signal ram : memory_array;
begin
  -- Define a function to read a file and return a memory array
  function read_hex_file (filename : string) return memory_array is
    variable temp : memory_array;
    file file_ptr : text;
    variable line_num : line;
    variable hex_num : std_logic_vector (7 downto 0);
    variable lines_read : integer := 0;
  begin
    file_open (file_ptr, filename, read_mode); -- Open the file in read mode
    while (not endfile (file_ptr)) loop -- Loop until the end of file
      readline (file_ptr, line_num); -- Read a line from the file
      read (line_num, hex_num); -- Read a hex number from the line
      if (lines_read < 32) then -- Check if the array index is valid
        temp (lines_read) := hex_num; -- Assign the hex number to the array element
        lines_read := lines_read + 1; -- Increment the lines read counter
      end if;
    end loop;
    file_close (file_ptr); -- Close the file
    return temp; -- Return the memory array
  end function;

  -- Initialize the ram signal with the function
  ram <= read_hex_file ("./RAM.HEX");
end architecture;