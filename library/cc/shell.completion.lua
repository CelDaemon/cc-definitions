--- @meta cc.shell.completion

--- @alias cc.shell.completion.function fun(shell: table, text:string, previous: string[], add_space: boolean?): string[]

--- @alias cc.shell.completion.table {[1]: cc.shell.completion.function}

--- A collection of helper methods for working with shell completion.
--- 
--- Most programs may be completed using the [`build`](lua://cc.shell.completion.build) helper method, rather than manually switching on the argument index.
--- 
--- Note, the helper functions within this module do not accept an argument index, and so are not directly usable with the [shell.setCompletionFunction](lua://shell.setCompletionFunction). 
--- Instead, wrap them using [`build`](lua://cc.shell.completion.build), or your own custom function.
--- 
--- Register a completion handler for example.lua which prompts for a choice of options, followed by a directory, and then multiple files:
--- 
--- ```lua
--- local completion = require "cc.shell.completion"
--- local complete = completion.build(
---   { completion.choice, { "get", "put" } },
---   completion.dir,
---   { completion.file, many = true }
--- )
--- shell.setCompletionFunction("example.lua", complete)
--- read(nil, nil, shell.complete, "example ")
--- ```
--- 
--- @see cc.completion For more general helpers, suitable for use with [`_G.read`](lua://read).
--- @see shell.setCompletionFunction
--- 
--- @class cc.shell.completion
--- @field help cc.shell.completion.function Wraps [`help.completeTopic`](lua://help.completeTopic) as a [`build`](lua://cc.shell.completion.build) compatible function.
--- @field choice cc.shell.completion.function Wraps [`cc.completion.choice`](lua://cc.completion.choice) as a [`build`](lua://cc.shell.completion.build) compatible function.
--- @field peripheral cc.shell.completion.function Wraps [`cc.completion.peripheral`](lua://cc.completion.peripheral) as a [`build`](lua://cc.shell.completion.build) compatible function.
--- @field side cc.shell.completion.function Wraps [`cc.completion.side`](lua://cc.completion.side) as a [`build`](lua://cc.shell.completion.build) compatible function.
--- @field setting cc.shell.completion.function Wraps [`cc.completion.setting`](lua://cc.completion.setting) as a [`build`](lua://cc.shell.completion.build) compatible function.
--- @field command cc.shell.completion.function Wraps [`cc.completion.command`](lua://cc.completion.command) as a [`build`](lua://cc.shell.completion.build) compatible function.
local completion = {}


--- Complete the name of a file relative to the current working directory.
--- 
--- @param shell table The shell we're completing in.
--- @param text string Current text to complete.
--- @return string[] # A list of suffixes of matching files.
function completion.file(shell, text) end

--- Complete the name of a directory relative to the current working directory.
--- 
--- @param shell table The shell we're completing in.
--- @param text string Current text to complete.
--- @return string[] # A list of suffixes of matching directories.
function completion.dir(shell, text) end

--- Complete the name of a file or directory relative to the current working directory.
--- 
--- @param shell table The shell we're completing in.
--- @param text string Current text to complete.
--- @param previous string[] The shell arguments before this one.
--- @param add_space boolean? Whether to add a space after the completed item.
--- @return string[] # A list of suffixes of matching files and directories.
function completion.dirOrFile(shell, text, previous, add_space) end

--- Complete the name of a program.
--- 
--- @see shell.completeProgram
--- 
--- @param shell table The shell we're completing in.
--- @param text string Current text to complete.
--- @return string[] # A list of suffixes of matching programs.
function completion.program(shell, text) end

--- Complete arguments of a program.
--- 
--- @param shell table The shell we're completing in.
--- @param text string Current text to complete.
--- @param previous string[] The shell arguments before this one.
--- @param starting number Which argument index this program and args start at.
--- @return string[] # A list of suffixes of matching programs or arguments.
function completion.programWithArgs(shell, text, previous, starting) end

--- @alias cc.shell.completion.source
--- | nil # This argument will not be completed.
--- | cc.shell.completion.function # This argument will be completed with the given function. It is called with the [`shell`](lua://shell) object, the string to complete and the arguments before this one.
--- | cc.shell.completion.table # This acts as a more powerful version of the function case. 
--- The table must have a function as the first item - this will be called with the shell, string and preceding arguments as above, but also followed by any additional items in the table. 
--- This provides a more convenient interface to pass options to your completion functions.
--- If this table is the last argument, it may also set the many key to true, which states this function should be used to complete any remaining arguments.

--- A helper function for building shell completion arguments.
--- 
--- This accepts a series of single-argument completion functions, and combines them into a function suitable for use with [`shell.setCompletionFunction`](lua://shell.setCompletionFunction).
--- 
--- @param ... cc.shell.completion.source The sources to build.
--- @return cc.shell.completion.function # The built completion function.
function completion.build(...) end

return completion