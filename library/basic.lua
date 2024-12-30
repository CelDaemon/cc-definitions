--- @meta _


--- Command-line arguments of the Lua program.
--- 
--- @type string[]
arg = {}

--- A global variable (not a function) that holds the global environment (see §2.2). Lua itself does not use this variable; changing its value does not affect any environment, nor vice versa.
--- @class _G
_G = {}

--- Raises an error if the value of its argument v is false (i.e., `nil` or `false`); otherwise, returns all its arguments. 
--- In case of error, `message` is the error object; when absent, it defaults to `"assertion failed!"`
--- 
--- @generic T The type of the asserted value.
--- @param v T? The value to assert.
--- @param message any? The message to print on assertion failure.
--- @param ... any Extra proxied arguments.
--- @return T # The asserted value.
--- @return any ... The extra proxied arguments.
function assert(v, message, ...) end

--- Opens the named file and executes its content as a Lua chunk. 
--- When called without arguments, `dofile` executes the content of the standard input (`stdin`). 
--- Returns all values returned by the chunk. 
--- In case of errors, `dofile` propagates the error to its caller. (That is, `dofile` does not run in protected mode.)
--- 
--- @param filename string? The file to run.
--- @return any ... The returned data from the file.
function dofile(filename) end


--- Terminates the last protected function called and returns message as the error object.
---
--- Usually, `error` adds some information about the error position at the beginning of the message, if the message is a string.
--- 
--- @param message any The error message.
--- @param level number? The stack level to error from.
function error(message, level) end


--- Returns the current environment in use by the function. `f` can be a Lua function or a number that specifies the function at that stack level.
--- 
--- @deprecated Use debug.getfenv instead.
--- @nodiscard
--- @param f number | async fun(...): ...
--- @return table
function getfenv(f) end

--- If object does not have a metatable, returns nil. 
--- Otherwise, if the object's metatable has a __metatable field, returns the associated value. Otherwise, returns the metatable of the given object.
--- 
--- @deprecated Use debug.getmetatable instead.
--- @nodiscard
--- @param object any The object to get the metatable from.
--- @return table metatable The metatable attached to the object.
function getmetatable(object) end

--- Returns three values (an iterator function, the table `t`, and `0`) so that the construction
--- 
---     for i,v in ipairs(t) do body end
--- 
--- will iterate over the key–value pairs `(1,t[1]), (2,t[2]), ...`, up to the first absent index.
--- 
--- @generic T: table The type of table to iterate over.
--- @generic V The type of value to return.
--- @param t T The table to iterate over.
--- @return fun(table: V[], i: number?): number, V iterator The iterator function.
--- @return T table The table being iterated.
--- @return number index The current index.
function ipairs(t) end


--- Loads a chunk.
---
--- If `chunk` is a string, the chunk is this string. 
--- If `chunk` is a function, `load` calls it repeatedly to get the chunk pieces. 
--- Each call to `chunk` must return a string that concatenates with previous results. 
--- A return of an empty string, `nil`, or no value signals the end of the chunk.
--- 
--- @nodiscard
--- @param chunk string | function The chunk to be loaded.
--- @param chunkname string? The name of the chunk.
--- @param mode "t"? The mode used to load the function.
--- @param env table? The environment for the function.
--- @return function? # The loaded function.
--- @return string? error_message The load error message.
function load(chunk, chunkname, mode, env) end


--- Loads a chunk from file `filename`.
--- 
--- @nodiscard
--- @param filename string The name of the chunk.
--- @param mode "t"? The mode used to load the function.
--- @param env table? The environment for the function.
--- @return function? # The loaded function.
--- @return string? error_message The load error message.
function loadfile(filename, mode, env) end


--- Loads a chunk from the given string.
--- 
--- @deprecated Use load instead.
--- @nodiscard
--- @param text string The text to load the function from.
--- @param chunkname string? The name of the chunk to load.
--- @return function? # The loaded function.
--- @return string? error_message The load error message.
function loadstring(text, chunkname) end

--- Allows a program to traverse all fields of a table. 
--- Its first argument is a table and its second argument is an index in this table. 
--- A call to `next` returns the next index of the table and its associated value. 
--- When called with `nil` as its second argument, `next` returns an initial index and its associated value. 
--- When called with the last index, or with `nil` in an empty table, `next` returns `nil`. 
--- If the second argument is absent, then it is interpreted as `nil`. In particular, you can use `next(t)` to check whether a table is empty.
--- 
--- The order in which the indices are enumerated is not specified, *even for numeric indices*. (To traverse a table in numerical order, use a numerical `for`.)
--- 
--- The behavior of `next` is undefined if, during the traversal, you assign any value to a non-existent field in the table. 
--- You may however modify existing fields. 
--- In particular, you may set existing fields to nil.
--- 
--- @nodiscard
--- @generic K The table's key type.
--- @generic V The table's value type.
--- @param table table<K, V> The table to traverse.
--- @param index K? The starting index.
--- @return K? index The next starting index.
--- @return V? The current value.
function next(table, index) end


--- If `t` has a metamethod `__pairs`, calls it with t as argument and returns the first three results from the call.
--- 
--- Otherwise, returns three values: the [next](command:extension.lua.doc?["en-us/54/manual.html/pdf-next"]) function, the table `t`, and `nil`, so that the construction
--- 
---     for k,v in pairs(t) do body end
--- 
--- will iterate over all key–value pairs of table `t`.
--- 
--- See function [next](command:extension.lua.doc?["en-us/54/manual.html/pdf-next"]) for the caveats of modifying the table during its traversal.
--- 
--- @generic T: table The type of table to iterate over.
--- @generic K The type of key to return.
--- @generic V The type of value to return.
--- @param t T The table to iterate over.
--- @return fun(table: table<K, V>, index: K?): K, V iterator The iterator function.
--- @return T table The table being iterated.
function pairs(t) end

--- Calls the function `f` with the given arguments in *protected mode*. This means that any error inside `f` is not propagated; instead, `pcall` catches the error and returns a status code. 
--- Its first result is the status code (a boolean), which is true if the call succeeds without errors. 
--- In such case, `pcall` also returns all results from the call, after this first result. 
--- In case of any error, `pcall` returns `false` plus the error object.
---
--- @param f async fun(...): ... The function to call.
--- @param ... any Arguments for the function.
--- @return boolean success Whether the function succeeded.
--- @return any | string error The first returned value of the function when succeeded, or the error message on failure.
--- @return any ... The remaining values returned from the function.
function pcall(f, ...) end