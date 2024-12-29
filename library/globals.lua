--- @meta _

--- Functions in the global environment, defined in `bios.lua`. This does not
--- include standard Lua functions.
--- @class _G
_G = {}

--- Pauses execution for the specified number of seconds.
--- 
--- As it waits for a fixed amount of world ticks, `time` will automatically be
--- rounded up to the nearest multiple of 0.05 seconds. If you are using coroutines
--- or the [parallel API](lua://parallel), it will only pause execution of the current
--- thread, not the whole program.
--- 
--- > Tip:
--- > Because sleep internally uses timers, it is a function that yields. This means
--- > that you can use it to prevent "Too long without yielding" errors. However, as
--- > the minimum sleep time is 0.05 seconds, it will slow your program down.
--- 
--- > Warning:
--- > Internally, this function queues and waits for a timer event (using
--- > [`os.startTimer`](lua://os.startTimer), however it does not listen for any other events. This means
--- > that any event that occurs while sleeping will be entirely discarded. If you
--- > need to receive events while sleeping, consider using [timers](lua://os.startTimer),
--- > or the [parallel API](lua://parallel).
--- 
--- Sleep for three seconds:
--- 
---     print("Sleeping for three seconds")
---     sleep(3)
---     print("Done!")
--- 
--- @see os.startTimer
--- @param time number The number of seconds to sleep for, rounded up to the nearest multiple of 0.05.
function sleep(time) end

--- Writes a line of text to the screen without a newline at the end, wrapping
--- text if necessary.
--- 
---     write("Hello, world")
--- 
--- @see print A wrapper around write that adds a newline and accepts multiple arguments.
--- 
--- @param text string The text to write to the string.
--- @return number # The number of lines written.
function write(text) end

--- Prints the specified values to the screen separated by spaces, wrapping if
--- necessary. After printing, the cursor is moved to the next line.
--- 
---     print("Hello, world!")
--- 
--- @param ... any The values to print on the screen.
--- @return number # The number of lines written.
function print(...) end


--- Prints the specified values to the screen in red, separated by spaces,
--- wrapping if necessary. After printing, the cursor is moved to the next line.
--- 
---     printError("Something went wrong!")
--- 
--- @param ... any The values to print on the screen.
function printError(...) end


--- Reads user input from the terminal. This automatically handles arrow keys,
--- pasting, character replacement, history scrollback, auto-completion, and
--- default values.
--- 
--- Read a string and echo it back to the user:
--- 
---     write("> ")
---     local msg = read()
---     print(msg)
--- 
--- Prompt a user for a password:
--- 
---     while true do
---         write("Password> ")
---         local pwd = read("*")
---         if pwd == "let me in" then break end
---         print("Incorrect password, try again.")
---     end
---     print("Logged in!")
--- 
--- A complete example with completion, history and a default value:
--- 
---     local completion = require "cc.completion"
---     local history = { "potato", "orange", "apple" }
---     local choices = { "apple", "orange", "banana", "strawberry" }
---     write("> ")
---     local msg = read(nil, history, function(text) return completion.choice(text, choices) end, "app")
---     print(msg)
--- 
--- @see cc.completion
--- 
--- @param replaceChar string? A character to replace each typed character with. This can be used for hiding passwords, for example.
--- @param history table<integer, string>? A table holding history items that can be scrolled back to with the up/down arrow keys. The oldest item is at index 1, while the newest item is at the highest index.
--- @param completeFn ?fun(partial: string): string[]? A function to be used for completion. This function should take the partial text typed so far, and returns a list of possible completion options.
--- @param default string? Default text which should already be entered into the prompt.
--- @return string # The text typed in.
function read(replaceChar, history, completeFn, default) end

--- Stores the current ComputerCraft and Minecraft versions.
--- 
--- Outside of Minecraft (for instance, in an emulator) [`_HOST`](lua://_HOST) will contain the
--- emulator's version instead.
--- 
--- For example, `ComputerCraft 1.93.0 (Minecraft 1.15.2)`.
--- 
--- Print the current computer's environment:
---     
---     print(_HOST)
--- 
--- @type string
_HOST = _HOST

--- The default computer settings as defined in the ComputerCraft configuration.
--- 
--- This is a comma-separated list of settings pairs defined by the mod
--- configuration or server owner. By default, it is empty.
--- 
--- An example value to disable autocompletion:
--- 
---     shell.autocomplete=false,lua.autocomplete=false,edit.autocomplete=false
--- 
--- @type string
_CC_DEFAULT_SETTINGS = _CC_DEFAULT_SETTINGS