--- @meta cc.strings

--- Various utilities for working with strings and text.
--- 
--- @see textutils For additional string related utilities.
--- @class cc.strings
local strings = {}

--- Wraps a block of text, so that each line fits within the given width.
--- 
--- This may be useful if you want to wrap text before displaying it to a [`peripheral.monitor`](lua://peripheral.monitor) or [`peripheral.printer`](lua://peripheral.printer) without using [`print`](lua://print).
--- 
--- Wrap a string and write it to the terminal:
--- 
--- ```lua
--- term.clear()
--- local lines = require "cc.strings".wrap("This is a long piece of text", 10)
--- for i = 1, #lines do
---   term.setCursorPos(1, i)
---   term.write(lines[i])
--- end
--- ```
--- 
--- @nodiscard
--- @param text string The string to wrap.
--- @param width number? The width to constrain to, defaults to the width of the terminal.
--- @return string[] # The wrapped input string as a list of lines.
function strings.wrap(text, width) end

--- Makes the input string a fixed width. This either truncates it, or pads it with spaces.
--- 
--- ```lua
--- require "cc.strings".ensure_width("a short string", 20)
--- ```
--- 
--- ```lua
--- require "cc.strings".ensure_width("a rather long string which is truncated", 20)
--- ```
--- 
--- @nodiscard
--- @param line string The string to normalise.
--- @param width number? The width to constrain to, defaults to the width of the terminal.
--- @return string # The string with a specific width.
function strings.ensure_width(line, width) end

--- Split a string into parts, each separated by a deliminator.
--- 
--- For instance, splitting the string `"a b c"` with the deliminator `" "`, would return a table with three strings: `"a"`, `"b",` and `"c"`.
--- 
--- By default, the deliminator is given as a [Lua pattern](https://www.lua.org/manual/5.3/manual.html#6.4.1). Passing `true` to the `plain` argument will cause the deliminator to be treated as a litteral string.
--- 
--- Split a string into words:
--- 
--- ```lua
--- require "cc.strings".split("This is a sentence.", "%s+")
--- ```
--- 
--- Split a string by "-" into at most 3 elements:
--- 
--- ```lua
--- require "cc.strings".split("a-separated-string-of-sorts", "-", true, 3)
--- ```
--- 
--- @see table.concat To join strings together.
--- 
--- @nodiscard
--- @param str string The string to split.
--- @param delimiter string The pattern to split this string on.
--- @param plain boolean Treat the deliminator as a plain string, rather than a pattern. The default is `false`.
--- @param limit boolean The maximum number of elements in the returned list.
--- @return string[] # The list of split strings.
function strings.split(str, delimiter, plain, limit) end

return strings