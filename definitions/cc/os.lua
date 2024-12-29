--- @meta os

--- The [`os`](lua://os) API allows interacting with the current computer.
os = {}

--- Loads the given API into the global environment.
--- 
--- This function loads and executes the file at the given path, and all global
--- variables and functions exported by it will by available through the use of
--- `myAPI.<function name>`, where `myAPI` is the base name of the API file.
--- 
--- [`require`](lua://require) should be used to load libraries instead.
--- 
--- @deprecated When possible it's best to avoid using this function. It pollutes the global table and can mask errors.
--- 
--- @nodiscard
--- @param path string The path of the API to load.
--- @return boolean # Whether or not the API was successfully loaded.
function os.loadAPI(path) end

--- Unloads an API which was loaded by [`os.loadAPI`](lua://os.loadAPI).
--- 
--- This effectively removes the specified table from `_G`.
--- 
--- @deprecated See os.loadAPI for why.
--- 
--- @param name string The name of the API to unload.
function os.unloadAPI(name) end


--- Pause execution of the current thread and waits for any events matching `filter`.
--- 
--- This function [yields](lua://coroutine.yield) the current process and waits for it
--- to be resumed with a vararg list where the first element matches `filter`.
--- If no `filter` is supplied, this will match all events.
--- 
--- Unlike [`os.pullEventRaw`](lua://os.pullEventRaw), it will stop the application upon a "terminate"
--- event, printing the error "Terminated".
--- 
--- Listen for `mouse_click` events:
---     
---     while true do
---         local event, button, x, y = os.pullEvent("mouse_click")
---         print("Button", button, "was clicked at", x, ",", y)
---     end
--- 
--- Listen for multiple events:
--- 
---     while true do
---         local eventData = {os.pullEvent()}
---         local event = eventData[1]
---
---         if event == "mouse_click" then
---             print("Button", eventData[2], "was clicked at", eventData[3], ",", eventData[4])
---         elseif event == "key" then
---             print("Key code", eventData[2], "was pressed")
---         end
---     end
--- 
--- @see os.pullEventRaw To pull the terminate event.
--- 
--- @param filter string? Event to filter for.
--- @return string event The name of the event that fired.
--- @return any param... Optional additional parameters of the event.
function os.pullEvent(filter) end

--- Pause execution of the current thread and waits for events, including the `terminate` event.
--- 
--- This behaves almost the same as [`os.pullEvent`](lua://os.pullEvent), except it allows you to handle
--- the `terminate` event yourself - the program will not stop execution when
--- <kbd>Ctrl</kbd> + <kbd>T</kbd> is pressed.
--- 
--- Listen for `terminate` events:
--- 
---     while true do
---         local event = os.pullEventRaw()
---         if event == "terminate" then
---             print("Caught terminate event!")
---         end
---     end
--- 
--- @see os.pullEvent To pull events normally.
--- 
--- @param filter string? Event to filter for.
--- @return string event The name of the event that fired.
--- @return any param... Optional additional parameters of the event.
function os.pullEventRaw(filter) end


--- Pauses execution for the specified number of seconds, alias of [`_G.sleep`](lua://sleep).
--- 
--- @param time number The number of seconds to sleep for, rounded up to the nearest multiple of 0.05.
function os.sleep(time) end

--- Get the current CraftOS version (for example, `CraftOS 1.9`).
--- 
--- This is defined by `bios.lua`. For the current version of CC:Tweaked, this
--- should return `CraftOS 1.9`.
--- 
---     os.version()
--- 
--- @nodiscard
--- @return string # The current CraftOS version.
function os.version() end

--- Run the program at the given path with the specified environment and arguments.
--- 
--- This function does not resolve program names like the shell does. This means
--- that, for example, `os.run("edit")` will not work. As well as this, it does not
--- provide access to the [`shell`](lua://shell) API in the environment. For this behaviour, use
--- [`shell.run`](lua://shell.run) instead.
--- 
--- If the program cannot be found, or failed to run, it will print the error and
--- return `false`. If you want to handle this more gracefully, use an alternative
--- such as [`loadfile`](lua://loadfile).
--- 
--- Run the default shell from within your program:
--- 
---     os.run({}, "/rom/programs/shell.lua")
--- 
--- @see shell.run
--- @see loadfile
--- 
--- @param env table The environment to run the program with.
--- @param path string The exact path of the program to run.
--- @param ... any The arguments to pass to the program.
--- @return boolean # Whether or not the program ran successfully.
function os.run(env, path, ...) end

--- Adds an event to the event queue. This event can later be pulled with os.pullEvent.
--- 
--- @see os.pullEvent To pull the event queued.
--- 
--- @param name string The name of the event to queue.
--- @param ... boolean | number | string | table The parameters of the event. These can be any primitive type (boolean, number, string) as well as tables. Other types (like functions), as well as metatables, will not be preserved.
function os.queueEvent(name, ...) end


--- Starts a timer that will run for the specified number of seconds. 
--- Once the timer fires, a [`timer`](lua://timer) event will be added to the queue with the ID returned from this function as the first parameter.
--- 
--- As with [`sleep`](lua://sleep), the time will automatically be rounded up to the nearest multiple of 0.05 seconds, as it waits for a fixed amount of world ticks.
--- 
--- Throws if the time is below zero.
--- 
--- @see os.cancelTimer To cancel a timer.
--- 
--- @param time number The number of seconds until the timer fires.
--- @return number # The ID of the new timer. This can be used to filter the [`timer`](lua://timer) event, or [cancel the timer](lua://os.cancelTimer).
function os.startTimer(time) end


--- Cancels a timer previously started with [`startTimer`](lua://os.startTimer). This will stop the timer from firing.
--- 
--- @see os.startTimer To start a timer.
--- 
--- @param token number The ID of the timer to cancel.
function os.cancelTimer(token) end


--- Sets an alarm that will fire at the specified [in-game time](lua://os.time). 
--- When it fires, an `alarm` event will be added to the event queue with the ID returned from this function as the first parameter.
--- 
--- Throws if the time is out of range.
--- 
--- @see os.cancelAlarm To cancel an alarm.
--- 
--- @param time number The time at which to fire the alarm, in the range [0.0, 24.0).
--- @return number # The ID of the new alarm. This can be used to filter the `alarm` event, or cancel the alarm.
function os.setAlarm(time) end

--- Cancels an alarm previously started with setAlarm. This will stop the alarm from firing.
--- 
--- @see os.setAlarm To set an alarm.
--- 
--- @param token number The ID of the alarm to cancel.
function os.cancelAlarm(token) end


--- Shuts down the computer immediately.
function os.shutdown() end

--- Reboots the computer immediately.
function os.reboot() end

--- Returns the ID of the computer.
--- 
--- @nodiscard
--- @return number # The ID of the computer.
function os.getComputerID() end

--- Returns the ID of the computer.
--- 
--- @deprecated Use os.getComputerID instead.
--- 
--- @nodiscard
--- @return number # The ID of the computer.
function os.computerID() end

--- Returns the label of the computer, or nil if none is set.
--- 
--- @nodiscard
--- @return string? # The label of the computer.
function os.getComputerLabel() end

--- Returns the label of the computer, or nil if none is set.
--- 
--- @deprecated Use os.getComputerLabel instead.
--- 
--- @nodiscard
--- @return string? # The label of the computer.
function os.computerLabel() end

--- Set the label of this computer.
--- 
--- @param label string? The new label. May be nil in order to clear it.
function os.setComputerLabel(label) end


--- Returns the number of seconds that the computer has been running.
--- 
--- @nodiscard
--- @return number # The computer's uptime.
function os.clock() end

--- Returns the current time depending on the string passed in. This will always be in the range [0.0, 24.0).
--- 
--- - If called with `ingame`, the current world time will be returned. This is the default if nothing is passed.
--- - If called with `utc`, returns the hour of the day in UTC time.
--- - If called with `local`, returns the hour of the day in the timezone the server is located in.
--- 
--- This function can also be called with a table returned from [`date`](lua://os.date), which will convert the date fields into a UNIX timestamp (number of seconds since 1 January 1970).
--- 
--- Throws if an invalid locale is passed.
--- 
--- Print the current in-game time:
--- 
---     textutils.formatTime(os.time())
--- 
--- @see textutils.formatTime
--- @see os.date
--- 
--- @nodiscard
--- @param locale string | table The locale of the time, or a table filled by `os.date("*t")` to decode. Defaults to `ingame` locale if not specified.
--- @return number # The hour of the selected locale, or a UNIX timestamp from the table, depending on the argument passed in.
function os.time(locale) end


--- Returns the day depending on the locale specified.
--- 
--- - If called with `ingame`, returns the number of days since the world was created. This is the default.
--- - If called with `utc`, returns the number of days since 1 January 1970 in the UTC timezone.
--- - If called with `local`, returns the number of days since 1 January 1970 in the server's local timezone.
--- 
--- Throws if an invalid locale is passed.
--- 
--- @nodiscard
--- @param args string? The locale to get the day for. Defaults to `ingame` if not set.
--- @return number # The day depending on the selected locale.
function os.day(args) end

--- Returns the number of milliseconds since an epoch depending on the locale.
--- 
--- - If called with `ingame`, returns the number of in-game milliseconds since the world was created. This is the default.
--- - If called with `utc`, returns the number of milliseconds since 1 January 1970 in the UTC timezone.
--- - If called with `local`, returns the number of milliseconds since 1 January 1970 in the server's local timezone.
--- 
--- > Info:
--- > The ingame time zone assumes that one Minecraft day consists of 86,400,000 milliseconds. 
--- > Since one in-game day is much faster than a real day (20 minutes), this will change quicker than real time - one real second is equal to 72000 in-game milliseconds. 
--- > If you wish to convert this value to real time, divide by 72000; to convert to ticks (where a day is 24000 ticks), divide by 3600.
--- 
--- Throws if an invalid locale is passed.
--- 
--- Get the current time and use date to convert it to a table:
--- 
---     -- Dividing by 1000 converts it from milliseconds to seconds.
---     local time = os.epoch("local") / 1000
---     local time_table = os.date("*t", time)
---     print(textutils.serialize(time_table))
--- 
--- @nodiscard
--- @param args string? The locale to get the milliseconds for. Defaults to `ingame` if not set.
--- @return number # The milliseconds since the epoch depending on the selected locale.
function os.epoch(args) end


--- Returns a date string (or table) using a specified format string and optional time to format.
--- 
--- The format string takes the same formats as C's [strftime](http://www.cplusplus.com/reference/ctime/strftime/) function. 
--- The format string can also be prefixed with an exclamation mark (`!`) to use UTC time instead of the server's local timezone.
--- 
--- If the format is exactly `"*t"` (or `"!*t"` ), a table representation of the timestamp will be returned instead. 
--- This table has fields for the year, month, day, hour, minute, second, day of the week, day of the year, and whether Daylight Savings Time is in effect. 
--- This table can be converted back to a timestamp with [`time`](lua://os.time).
--- 
--- Throws if an invalid format is passed.
--- 
--- Print the current date in a user-friendly string:
--- 
---     os.date("%A %d %B %Y") -- See the reference above!
--- 
--- Convert a timestamp to a table:
--- 
---     os.date("!*t", 1242534247)
---     --[=[ {
---         -- Date
---         year  = 2009,
---         month = 5,
---         day   = 17,
---         yday  = 137,
---         wday  = 1,
---         -- Time
---         hour  = 4,
---         min   = 24,
---         sec   = 7,
---         isdst = false,
---     } ]=]
--- 
--- @nodiscard
--- @param format string? The format of the string to return. This defaults to `%c`, which expands to a string similar to "Sat Dec 24 16:58:00 2011".
--- @param time number? The timestamp to convert to a string. This defaults to the current time.
--- @return string | table # The resulting formated string, or table.
function os.date(format, time) end