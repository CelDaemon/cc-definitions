--- @meta utf8

--- @class utf8lib
--- The pattern which matches exactly one UTF-8 byte sequence, assuming that the subject is a valid UTF-8 string.
--- @field charpattern string
utf8 = {}

--- Receives zero or more integers, converts each one to its corresponding UTF-8 byte sequence and returns a string with the concatenation of all these sequences.
--- 
--- @nodiscard
--- @param ... number The codes to convert.
--- @return string # The converted string.
function utf8.char(...) end

--- Returns values so that the construction
--- ```lua
--- for p, c in utf8.codes(s) do
---     body
--- end
--- ```
--- will iterate over all UTF-8 characters in string s, with p being the position (in bytes) and c the code point of each character. 
--- It raises an error if it meets any invalid byte sequence.
--- 
--- @nodiscard
--- @param s string The string to iterate over.
--- @return fun(s: string, p: number): number, number # The code iterator function.
function utf8.codes(s) end

--- Returns the codepoints (as integers) from all characters in `s` that start between byte position `i` and `j` (both included).
--- 
--- @nodiscard
--- @param s string The string to get the codepoints of.
--- @param i number? The starting byte position.
--- @param j number? The ending byte position.
--- @return number ... The output codepoints.
function utf8.codepoint(s, i, j) end

--- Returns the number of UTF-8 characters in string `s` that start between positions `i` and `j` (both inclusive).
--- 
--- @nodiscard
--- @param s string The string to get the length of.
--- @param i number The starting index.
--- @param j number The ending index.
--- @return number? # The number of UTF-8 characters in the string, or `nil` when an error occurred.
--- @return number? # The index of the failed character when an error occurred.
function utf8.len(s, i, j) end

--- Returns the position (in bytes) where the encoding of the `n`-th character of `s` (counting from position `i`) starts.
--- 
--- @nodiscard
--- @param s string The string to select the position from.
--- @param n number The position of the character to select.
--- @param i number? The starting position to use as an origin for `n`.
--- @return number # The byte position of the selected character.
function utf8.offset(s, n, i) end

return utf8