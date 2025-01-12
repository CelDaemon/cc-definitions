--- @meta _

--- Emulates Lua's standard [io library](https://www.lua.org/manual/5.1/manual.html#5.7).
--- @class io
--- @field stdin io.handle A file handle representing the "standard input".
--- @field stdout io.handle A file handle representing the "standard output".
--- @field stderr io.handle A file handle representing the "standard error" stream.
io = {}


--- Closes the provided file handle.
--- 
--- @see io.handle.close
--- @see io.output
--- 
--- @param file io.handle? The file handle to close, defaults to the current output file.
function io.close(file) end

--- Flushes the current output file.
--- 
--- @see io.handle.flush
--- @see io.output
function io.flush() end

--- Get or set the current input file.
--- 
--- Throws if the provided filename cannot be opened for reading.
--- 
--- @param file io.handle | string? The new input file, either as a file path or pre-existing handle.
--- @return io.handle # The current input file.
function io.input(file) end



--- A format for use in [`io.read_handle.read`](lua://io.read_handle.read), `l` is used by default.
--- @alias io.format
--- |>"l" # Returns the next line (without a newline on the end).
--- | "L" # Returns the next line (with a newline on the end).
--- | "a" # Returns the entire rest of the file.
--- | "*l" # Returns the next line (without a newline on the end). Compatible with `Lua 5.1`.
--- | "*L" # Returns the next line (with a newline on the end). Compatible with `Lua 5.1`.
--- | "*a" # Returns the entire rest of the file. Compatible with `Lua 5.1`.

--- Opens the given file name in read mode and returns an iterator that, each time it is called, returns a new line from the file.
--- 
--- This can be used in a for loop to iterate over all lines of a file
--- 
--- Once the end of the file has been reached, `nil` will be returned. The file is automatically closed.
--- 
--- If no file name is given, the [current input](lua://io.input) will be used instead. In this case, the handle is not used.
--- 
--- Throws if the file cannot be opened for reading.
--- 
--- Iterate over every line in a file and print it out:
--- 
--- ```lua
--- for line in io.lines("/rom/help/intro.txt") do
---   print(line)
--- end
--- ```
--- 
--- @see io.handle.lines
--- @see io.input
--- 
--- @nodiscard
--- @param filename string? The name of the file to extract lines from.
--- @param ... io.format The argument to pass to [`io.handle.read`](lua://io.handle.read) for each line.
--- @return fun(): string? # The line iterator.
function io.lines(filename, ...) end


--- Open a file with the given mode, either returning a new file handle or nil, plus an error message.
--- 
--- @nodiscard
--- @param filename string The name of the file to open.
--- @param mode "r" | "rb"? The mode to open the file with.
--- @return io.read_handle? # The opened file, or `nil` if opening the file failed.
--- @return string? # The reason the file could not be opened, when opening the file failed.
function io.open(filename, mode) end

--- Open a file with the given mode, either returning a new file handle or nil, plus an error message.
--- 
--- @nodiscard
--- @param filename string The name of the file to open.
--- @param mode "w" | "wb" | "a" | "ab" The mode to open the file with.
--- @return io.write_handle? # The opened file, or `nil` if opening the file failed.
--- @return string? # The reason the file could not be opened, when opening the file failed.
function io.open(filename, mode) end

--- Open a file with the given mode, either returning a new file handle or nil, plus an error message.
--- 
--- @nodiscard
--- @param filename string The name of the file to open.
--- @param mode "r+" | "r+b" | "w+" | "w+b" The mode to open the file with.
--- @return io.read_write_handle? # The opened file, or `nil` if opening the file failed.
--- @return string? # The reason the file could not be opened, when opening the file failed.
function io.open(filename, mode) end

--- Get or set the current output file.
--- 
--- Throws if the provided filename cannot be opened for writing.
--- 
--- @param file io.handle | string? The new output file, either as a file path or pre-existing handle.
--- @return io.handle # The current output file.
function io.output(file) end

--- Read from the currently opened input file.
--- 
--- This is equivalent to `io.input():read(...)`. See [the documentation](lua://io.read_handle.read) there for full details.
--- 
--- @nodiscard
--- @param ... io.format The formats to read, defaulting to a whole line.
--- @return string[]? # The data read, or `nil` if nothing can be read.
function io.read(...) end

--- Checks whether `handle` is a given file handle, and determine if it is open or not.
--- 
--- @nodiscard
--- @param obj any The value to check.
--- @return string? `"file"` if this is an open file, `"closed file"` if it is a closed file handle, or `nil` if not a file handle.
function io.type(obj) end

--- Write to the currently opened output file.
--- 
--- This is equivalent to `io.output():write(...)`. See [the documentation](lua://io.write_handle.write) there for full details.
--- 
--- @param ... string The strings to write.
function io.write(...) end

--- @class io.handle
local handle = {}

--- Close this file handle, freeing any resources it uses.
--- 
--- Throws if this handle was already closed.
--- 
--- @nodiscard
--- @return boolean # Whether this handle was successfully closed.
--- @return string? # The reason it could not be closed.
function handle:close() end

--- Flush any buffered output, forcing it to be written to the file
--- 
--- Throws if the handle has been closed
function handle:flush() end

--- @alias io.whence # The origin for [`seek`](lua://handle.seek).
--- | "set" # Base position is 0 (beginning of the file).
--- | "cur" # Base is current position.
--- | "end" # Base is end of file.

--- Seeks the file cursor to the specified position, and returns the new position.
--- 
--- The default value of `whence` is `cur`, and the default value of `offset` is 0.
--- This means that `file:seek()` without arguments returns the current position without moving.
--- 
--- @nodiscard
--- @param whence io.whence? The place to set the cursor from.
--- @param offset number? The offset from the start to move to.
--- @return number # The new location of the file cursor. 
function handle:seek(whence, offset) end

--- @class io.read_handle: io.handle
local read_handle = {}

--- Returns an iterator that, each time it is called, returns a new line from the file.
--- 
--- This can be used in a for loop to iterate over all lines of a file
--- 
--- Once the end of the file has been reached, nil will be returned. The file is not automatically closed.
--- 
--- Throws if the file cannot be opened for reading.
--- 
--- Iterate over every line in a file and print it out:
--- 
--- ```lua
--- local file = io.open("/rom/help/intro.txt")
--- for line in file:lines() do
---   print(line)
--- end
--- file:close()
--- ```
--- 
--- @see io.lines
--- 
--- @nodiscard
--- @param ... io.format The argument to pass to [`io.read_handle.read`](lua://io.read_handle.read) for each line.
--- @return fun(): string? # The line iterator.
function read_handle:lines(...) end

--- Reads data from the file, using the specified formats. 
--- For each format provided, the function returns either the data read, or `nil` if no data could be read.
--- 
--- @nodiscard
--- @param ... io.format The formats to use.
--- @return string[]? # The data read from the file. 
function read_handle:read(...) end

--- @class io.write_handle: io.handle
local write_handle = {}

--- Write one or more values to the file
--- 
--- @nodiscard
--- @param ... string | number The values to write.
--- @return io.write_handle? # The current file, allowing chained calls.
--- @return string? # The error message which occurred while writing.
function write_handle:write(...) end

--- @class io.read_write_handle: io.read_handle, io.write_handle