--- @meta _

--- Interact with a computer's terminal or monitors, writing text and drawing ASCII graphics.
--- 
--- ## Writing to the terminal
--- 
---  The simplest operation one can perform on a terminal is displaying (or writing) some text.
--- This can be performed with the  method.
--- 
--- ```lua
--- term.write("Hello, world!")
--- ```
--- 
--- When you write text, this advances the cursor, so the next call to [`term.write`](lua://term.write) will write text immediately after the previous one.
--- 
--- ```lua
--- term.write("Hello, world!")
--- term.write("Some more text")
--- ```
--- 
--- [`term.getCursorPos`](lua://term.getCursorPos) and [`term.setCursorPos`](lua://term.setCursorPos) can be used to manually change the cursor's position.
--- 
--- ```lua
--- term.clear()
--- 
--- term.setCursorPos(1, 1) -- The first column of line 1
--- term.write("First line")
---
--- term.setCursorPos(20, 2) -- The 20th column of line 2
--- term.write("Second line")
--- ```
--- 
--- [`term.write`](lua://term.write) is a relatively basic and low-level function, and does not handle more advanced features such as line breaks or word wrapping. 
--- If you just want to display text to the screen, you probably want to use [`print`](lua://print) or [`write`](lua://write) instead.
--- 
--- ## Colours
--- 
--- So far we've been writing text in black and white. 
--- However, advanced computers are also capable of displaying text in a variety of colours, with the [`term.setTextColour`](lua://term.setTextColour) and [`term.setBackgroundColour`](lua://term.setBackgroundColour) functions.
--- 
--- ```lua
--- print("This text is white")
--- term.setTextColour(colours.green)
--- print("This text is green")
--- ```
--- 
--- These functions accept any of the constants from the [`colors`](lua://colors) API. 
--- [Combinations of colours](lua://colors.combine) may be accepted, but will only display a single colour (typically following the behaviour of [`colors.toBlit`](lua://colors.toBlit)).
--- 
--- The [`paintutils`](lua://paintutils) API provides several helpful functions for displaying graphics using [`term.setBackgroundColour`](lua://term.setBackgroundColour).
--- @class termlib: term.redirect
term = {}

--- Get the default palette value for a colour.
--- 
--- Throws when given an invalid colour.
--- 
--- @see term.redirect.setPaletteColour To change the palette colour.
--- 
--- @nodiscard
--- @param colour number The colour whose palette should be fetched.
--- @return number # The red channel, will be between 0 and 1.
--- @return number # The green channel, will be between 0 and 1.
--- @return number # The blue channel, will be between 0 and 1.
function term.nativePaletteColour(colour) end

--- Get the default palette value for a colour.
--- 
--- Throws when given an invalid colour.
--- 
--- @see term.redirect.setPaletteColour To change the palette colour.
--- 
--- @nodiscard
--- @param colour number The colour whose palette should be fetched.
--- @return number # The red channel, will be between 0 and 1.
--- @return number # The green channel, will be between 0 and 1.
--- @return number # The blue channel, will be between 0 and 1.
function term.nativePaletteColor(colour) end

--- Returns the current terminal object of the computer.
--- 
--- Create a new [`window`](lua://window) which draws to the current redirect target:window.create
--- 
--- ```lua
--- window.create(term.current(), 1, 1, 10, 10)
--- ```
--- 
--- @nodiscard
--- @return term.redirect # The current terminal redirect.
function term.current() end

--- Get the native terminal object of the current computer.
--- 
--- It is recommended you do not use this function unless you absolutely have to. 
--- In a multitasked environment, [`term.native`](lua://term.native) will _not_ be the current terminal object, and so drawing may interfere with other programs.
--- 
--- @nodiscard
--- @return term.redirect # The native terminal redirect.
function term.native() end

--- Redirects terminal output to a monitor, a [`window`](lua://window), or any other custom terminal object. 
--- Once the redirect is performed, any calls to a "term" function - or to a function that makes use of a term function, as [`print`](lua://print) - will instead operate with the new terminal object.
--- 
--- A "terminal object" is simply a table that contains functions with the same names - and general features - as those found in the term table. 
--- For example, a wrapped monitor is suitable.
--- 
--- The redirect can be undone by pointing back to the previous terminal object (which this function returns whenever you switch).
--- 
--- Redirect to a monitor on the right of the computer:
--- 
--- ```lua
--- term.redirect(peripheral.wrap("right"))
--- ```
--- 
--- @param target term.redirect The terminal redirect the [`term`](lua://term) API will draw to.
--- @return term.redirect # The previous redirect object, as returned by [`term.current`](lua://term.current).
function term.redirect(target) end


--- A base class for all objects which interact with a terminal. 
--- Namely the [`term`](lua://term) and monitors.
--- @class term.redirect
local redirect = {}

--- Write `text` at the current cursor position, moving the cursor to the end of the text.
--- 
--- Unlike functions like `write` and `print`, this does not wrap the text - it simply copies the text to the current terminal line.
--- 
--- @param text string The text to write.
function redirect.write(text) end

--- Move all positions up (or down) by `y` pixels.
--- 
--- Every pixel in the terminal will be replaced by the line `y` pixels below it. If `y` is negative, it will copy pixels from above instead.
--- 
--- @param y number The number of lines to move up by. This may be a negative number.
function redirect.scroll(y) end

--- Get the position of the cursor.
--- 
--- @nodiscard
--- @return number # The x position of the cursor.
--- @return number # The y position of the cursor.
function redirect.getCursorPos() end

--- Set the position of the cursor. [terminal writes](lua://term.write) will begin from this position.
--- 
--- @param x number The new x position of the cursor.
--- @param y number The new y position of the cursor.
function redirect.setCursorPos(x, y) end

--- Checks if the cursor is currently blinking.
--- 
--- @nodiscard
--- @return boolean # If the cursor is blinking.
function redirect.getCursorBlink() end

--- Sets whether the cursor should be visible (and blinking) at the current [cursor position](lua://term.getCursorPos).
--- 
--- @param blink boolean Whether the cursor should blink.
function redirect.setCursorBlink(blink) end

--- Get the size of the terminal.
--- 
--- @nodiscard
--- @return number # The terminal's width.
--- @return number # The terminal's height.
function redirect.getSize() end

--- Clears the terminal, filling it with the [current background colour](lua://term.getBackgroundColour).
function redirect.clear() end

--- Clears the line the cursor is currently on, filling it with the [current background colour](lua://term.getBackgroundColour).
function redirect.clearLine() end

--- Return the colour that new text will be written as.
--- 
--- @see colors For a list of colour constants, returned by this function.
--- 
--- @nodiscard
--- @return number # The current text colour.
function redirect.getTextColour() end

--- Return the colour that new text will be written as.
--- 
--- @see colors For a list of colour constants, returned by this function.
--- 
--- @nodiscard
--- @return number # The current text colour.
function redirect.getTextColor() end

--- Set the colour that new text will be written as.
--- 
--- @see colors For a list of colour constants.
--- 
--- @param colour number The new text colour.
function redirect.setTextColour(colour) end

--- Set the colour that new text will be written as.
--- 
--- @see colors For a list of colour constants.
--- 
--- @param colour number The new text colour.
function redirect.setTextColor(colour) end

--- Return the current background colour. This is used when [writing text](lua://term.write) and [clearing](lua://term.clear) the terminal.
--- 
--- @see colors For a list of colour constants, returned by this function.
--- 
--- @nodiscard
--- @return number # The current background colour.
function redirect.getBackgroundColour() end

--- Return the current background colour. This is used when [writing text](lua://term.write) and [clearing](lua://term.clear) the terminal.
--- 
--- @see colors For a list of colour constants, returned by this function.
--- 
--- @nodiscard
--- @return number # The current background colour.
function redirect.getBackgroundColor() end

--- Set the current background colour. This is used when [writing text](lua://term.write) and [clearing](lua://term.clear) the terminal.
--- 
--- @see colors For a list of colour constants, returned by this function.
--- 
--- @param colour number The new background colour.
function redirect.setBackgroundColour(colour) end

--- Set the current background colour. This is used when [writing text](lua://term.write) and [clearing](lua://term.clear) the terminal.
--- 
--- @see colors For a list of colour constants, returned by this function.
--- 
--- @param colour number The new background colour.
function redirect.setBackgroundColor(colour) end

--- Determine if this terminal supports colour.
--- 
--- Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be displayed in greyscale.
--- 
--- @nodiscard
--- @return boolean # Whether this terminal supports colour.
function redirect.isColour() end

--- Determine if this terminal supports colour.
--- 
--- Terminals which do not support colour will still allow writing coloured text/backgrounds, but it will be displayed in greyscale.
--- 
--- @nodiscard
--- @return boolean # Whether this terminal supports colour.
function redirect.isColor() end

--- Writes `text` to the terminal with the specific foreground and background colours.
--- 
--- As with [`write`](lua://term.write), the text will be written at the current cursor location, with the cursor moving to the end of the text.
--- 
--- `textColour` and `backgroundColour` must both be strings the same length as `text`. 
--- All characters represent a single hexadecimal digit, 
--- which is converted to one of CC's colours. For instance, `"a"` corresponds to purple.
--- 
--- Prints "Hello, world!" in rainbow text:
--- 
--- ```lua
--- term.blit("Hello, world!","01234456789ab","0000000000000")
--- ```
--- 
--- @see colors For a list of colour constants, and their hexadecimal values.
--- 
--- Throws if the three inputs are not the same length.
--- 
--- @param text string The text to write.
--- @param textColour string The corresponding text colours.
--- @param backgroundColour string The corresponding background colours.
function redirect.blit(text, textColour, backgroundColour) end

--- Set the palette for a specific colour.
--- 
--- ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you can make [`colors.red`](lua://colors.red) _more red_ by setting its palette to #FF0000. 
--- This does now allow you to draw more colours - you are still limited to 16 on the screen at one time - but you can change which colours are used.
--- 
--- Change the [red colour](lua://colors.red) from the default #CC4C4C to #FF0000:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 0xFF0000)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- As above, but specifying each colour channel separately:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 1, 0, 0)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- @see colors.unpackRGB To convert from the 24-bit format to three separate channels.
--- @see colors.packRGB To convert from three separate channels to the 24-bit format.
--- 
--- @param index number The colour whose palette should be changed.
--- @param colour number A 24-bit integer representing the RGB value of the colour. For instance the integer `0xFF0000` corresponds to the colour #FF0000.
function redirect.setPaletteColour(index, colour) end


--- Set the palette for a specific colour.
--- 
--- ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you can make [`colors.red`](lua://colors.red) _more red_ by setting its palette to #FF0000. 
--- This does now allow you to draw more colours - you are still limited to 16 on the screen at one time - but you can change which colours are used.
--- 
--- Change the [red colour](lua://colors.red) from the default #CC4C4C to #FF0000:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 0xFF0000)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- As above, but specifying each colour channel separately:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 1, 0, 0)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- @see colors.unpackRGB To convert from the 24-bit format to three separate channels.
--- @see colors.packRGB To convert from three separate channels to the 24-bit format.
--- 
--- @param index number The colour whose palette should be changed.
--- @param r number The intensity of the red channel, between 0 and 1.
--- @param g number The intensity of the green channel, between 0 and 1.
--- @param b number The intensity of the blue channel, between 0 and 1.
function redirect.setPaletteColour(index, r, g, b) end

--- Set the palette for a specific colour.
--- 
--- ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you can make [`colors.red`](lua://colors.red) _more red_ by setting its palette to #FF0000. 
--- This does now allow you to draw more colours - you are still limited to 16 on the screen at one time - but you can change which colours are used.
--- 
--- Change the [red colour](lua://colors.red) from the default #CC4C4C to #FF0000:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 0xFF0000)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- As above, but specifying each colour channel separately:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 1, 0, 0)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- @see colors.unpackRGB To convert from the 24-bit format to three separate channels.
--- @see colors.packRGB To convert from three separate channels to the 24-bit format.
--- 
--- @param index number The colour whose palette should be changed.
--- @param colour number A 24-bit integer representing the RGB value of the colour. For instance the integer `0xFF0000` corresponds to the colour #FF0000.
function redirect.setPaletteColor(index, colour) end


--- Set the palette for a specific colour.
--- 
--- ComputerCraft's palette system allows you to change how a specific colour should be displayed. For instance, you can make [`colors.red`](lua://colors.red) _more red_ by setting its palette to #FF0000. 
--- This does now allow you to draw more colours - you are still limited to 16 on the screen at one time - but you can change which colours are used.
--- 
--- Change the [red colour](lua://colors.red) from the default #CC4C4C to #FF0000:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 0xFF0000)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- As above, but specifying each colour channel separately:
--- 
--- ```lua
--- term.setPaletteColour(colors.red, 1, 0, 0)
--- term.setTextColour(colors.red)
--- print("Hello, world!")
--- ```
--- 
--- @see colors.unpackRGB To convert from the 24-bit format to three separate channels.
--- @see colors.packRGB To convert from three separate channels to the 24-bit format.
--- 
--- @param index number The colour whose palette should be changed.
--- @param r number The intensity of the red channel, between 0 and 1.
--- @param g number The intensity of the green channel, between 0 and 1.
--- @param b number The intensity of the blue channel, between 0 and 1.
function redirect.setPaletteColor(index, r, g, b) end

--- Get the current palette for a specific colour.
--- 
--- @nodiscard
--- @param colour number The colour whose palette should be fetched.
--- @return number # The red channel, will be between 0 and 1.
--- @return number # The green channel, will be between 0 and 1.
--- @return number # The blue channel, will be between 0 and 1.
function redirect.getPaletteColour(colour) end

--- Get the current palette for a specific colour.
--- 
--- @nodiscard
--- @param colour number The colour whose palette should be fetched.
--- @return number # The red channel, will be between 0 and 1.
--- @return number # The green channel, will be between 0 and 1.
--- @return number # The blue channel, will be between 0 and 1.
function redirect.getPaletteColor(colour) end