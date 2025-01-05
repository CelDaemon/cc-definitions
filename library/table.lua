--- @meta table

--- @class tablelib
table = {}

--- Given a list where all elements are strings or numbers, returns the string `list[i]..sep..list[i+1] ··· sep..list[j]`.
--- 
--- @nodiscard
--- @param list table<number, string | number> The values to concatenate.
--- @param sep string? The seperator to add in between values.
--- @param i number? The starting index for concatenation.
--- @param j number? The ending index for concatenation.
--- @return string # The concatenated string.
function table.concat(list, sep, i, j) end

--- Inserts element `value` at position `pos` in `list`.
--- 
--- @param list table<number, any> The table to insert into.
--- @param pos number The position to insert the value at.
--- @param value any The value to insert.
function table.insert(list, pos, value) end

--- Inserts element `value` in `list`.
--- 
--- @param list table<number, any> The table to insert into.
--- @param value any The value to insert.
function table.insert(list, value) end

--- Returns the largest positive numerical index of the given table, or zero if the table has no positive numerical indices.
--- 
--- @nodiscard
--- @param table table<number, any> The table to get the maximum numerical index of.
--- @return number # The maximum numerical index in the table.
function table.maxn(table) end

--- Moves elements from table `a1` to table `a2`.
--- 
--- ```lua
--- a2[t],··· =
--- a1[f],···,a1[e]
--- return a2
--- ```
--- @param a1 table The table to move elements from.
--- @param f number The starting index in the source table.
--- @param e number The ending index in the source table.
--- @param t number The index in the target table.
--- @param a2 table? The table to move elements to.
--- @return table # The output table.
function table.move(a1, f, e, t, a2) end

--- @class packtable: table A table containing packed values, along with `n` containing the total amount of values.
--- @field n number The amount of packed values.

--- Returns a new table with all arguments stored into keys `1`, `2`, etc. and with a field `"n"` with the total number of arguments.
--- 
--- @nodiscard
--- @param ... any The values to pack.
--- @return packtable # The packed values within a table.
function table.pack(...) end

--- Removes from `list` the element at position `pos`, returning the value of the removed element.
--- 
--- @param list any[] The table to remove an element from.
--- @param pos number? The position of the element to remove.
--- @return any # The removed element.
function table.remove(list, pos) end

--- Sorts list elements in a given order, *in-place*, from `list[1]` to `list[#list]`.
--- 
--- @generic T The type of the list.
--- 
--- @param list T[] The list to sort.
--- @param comp (fun(a: T, b: T): boolean)? The function to compare the items in the list.
function table.sort(list, comp) end

--- Returns the elements from the given `list`. This function is equivalent to
--- 
--- ```lua
--- return list[i], list[i+1], ···, list[j]
--- ```
--- By default, `i` is `1` and `j` is `#list`.
---
--- @nodiscard
--- @param list table The table to unpack arguments from.
--- @param i number? The starting index.
--- @param j number? The ending index.
--- @return any ... The unpacked arguments.
function table.unpack(list, i, j) end

--- Executes the given f over all elements of table. For each element, f is called with the index and respective value as arguments. 
--- If f returns a non-nil value, then the loop is broken, and this value is returned as the final value of foreach.
--- 
--- @deprecated Use pairs instead.
--- 
--- @generic T The type of the list.
--- @generic TT The type of the output.
--- 
--- @param list {[string | number]: T} The list to iterate over.
--- @param callback fun(key: string | number, value: T): TT? The callback to call on every iteration.
--- @return TT? # The output of the callback.
function table.foreach(list, callback) end

--- Executes the given f over the numerical indices of table. For each index, f is called with the index and respective value as arguments. 
--- Indices are visited in sequential order, from 1 to n, where n is the size of the table. 
--- If f returns a non-nil value, then the loop is broken and this value is returned as the result of foreachi.
--- 
--- @deprecated Use ipairs instead.
--- 
--- @generic T The type of the list.
--- @generic TT The type of the output.
--- 
--- @param list T[] The list to iterate over.
--- @param callback fun(key: number, value: T): TT? The callback to call on every iteration.
--- @return TT? # The output of the callback.
function table.foreachi(list, callback) end

--- Returns the number of elements in the table. This function is equivalent to `#list`.
--- 
--- @deprecated Use #list instead.
--- 
--- @nodiscard
--- @param list any[] The list to get the length of.
--- @return number # The length of the list.
function table.getn(list) end

return table