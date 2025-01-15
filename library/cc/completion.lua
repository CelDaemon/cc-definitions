--- @meta cc.completion

--- A collection of helper methods for working with input completion, such as that require by [`read`](lua://read).
--- 
--- @see cc.shell.completion For additional helpers to use with [`shell.setCompletionFunction`](lua://shell.setCompletionFunction).
--- 
--- @class cc.completion
local completion = {}

--- Complete from a choice of one or more strings.
--- 
--- Call [`read`](lua://read), completing the names of various animals:
--- 
--- ```lua
--- local completion = require "cc.completion"
--- local animals = { "dog", "cat", "lion", "unicorn" }
--- read(nil, nil, function(text) return completion.choice(text, animals) end)
--- ```
--- 
--- @nodiscard
--- @param text string The input string to complete.
--- @param choices string[] The list of choices to complete from.
--- @param add_space boolean? Whether to add a space after the completed item.
--- @return string[] # A list of suffixes of matching strings.
function completion.choice(text, choices, add_space) end

--- Complete the name of a currently attached peripheral.
--- 
--- ```lua
--- local completion = require "cc.completion"
--- read(nil, nil, completion.peripheral)
--- ```
--- 
--- @nodiscard
--- @param text string The input string to complete.
--- @param add_space boolean? Whether to add a space after the completed name.
--- @return string[] # A list of suffixes of matching peripherals.
function completion.peripheral(text, add_space) end

--- Complete the side of a computer.
--- 
--- ```lua
--- local completion = require "cc.completion"
--- read(nil, nil, completion.side)
--- ```
--- 
--- @nodiscard
--- @param text string The input string to complete.
--- @param add_space boolean? Whether to add a space after the completed side.
--- @return string[] # A list of suffixes of matching sides.
function completion.side(text, add_space) end

--- Complete a [`setting`](lua://setting).
--- 
--- ```lua
--- local completion = require "cc.completion"
--- read(nil, nil, completion.setting)
--- ```
--- 
--- @nodiscard
--- @param text string The input string to complete.
--- @param add_space boolean? Whether to add a space after the completed settings.
--- @return string[] # A list of suffixes of matching settings.
function completion.setting(text, add_space) end

--- Complete the name of a Minecraft [command](lua://commands).
--- 
--- ```lua
--- local completion = require "cc.completion"
--- read(nil, nil, completion.command)
--- ```
--- 
--- @param text string The input string to complete.
--- @param add_space boolean? Whether to add a space after the completed command.   
--- @return string[] # A list of suffixes of matching commands.
function completion.command(text, add_space) end

return completion