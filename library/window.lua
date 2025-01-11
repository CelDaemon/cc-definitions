--- @meta _

--- A [terminal redirect](lua://term.redirect) occupying a smaller area of an existing terminal. 
--- This allows for easy definition of spaces within the display that can be written/drawn to, then later redrawn/repositioned/etc as need be. 
--- The API itself contains only one function, [`window.create`](lua://window.create), which returns the windows themselves.
--- 
--- Windows are considered terminal objects - as such, they have access to nearly all the commands in the term API (plus a few extras of their own, listed within said API) and are valid targets to redirect to.
--- 
--- Each window has a "parent" terminal object, which can be the computer's own display, a monitor, another window or even other, user-defined terminal objects. Whenever a window is rendered to, the actual screen-writing is performed via that parent (or, if that has one too, then that parent, and so forth). Bear in mind that the cursor of a window's parent will hence be moved around etc when writing a given child window.
--- 
--- Windows retain a memory of everything rendered "through" them (hence acting as display buffers), and if the parent's display is wiped, the window's content can be easily redrawn later. 
--- A window may also be flagged as invisible, preventing any changes to it from being rendered until it's flagged as visible once more.
--- 
--- A parent terminal object may have multiple children assigned to it, and windows may overlap. For example, the Multishell system functions by assigning each tab a window covering the screen, each using the starting terminal display as its parent, and only one of which is visible at a time.
--- @class windowlib
window = {}

--- Returns a terminal object that is a space within the specified parent terminal object. 
--- This can then be used (or even redirected to) in the same manner as eg a wrapped monitor. Refer to [the term API](lua://term) for a list of functions available to it.
--- 
--- [`term`](lua://term) itself may not be passed as the parent, though [`term.native`](lua://term.native) is acceptable. Generally, [`term.current`](lua://term.current) or a wrapped monitor will be most suitable, though windows may even have other windows assigned as their parents.
--- 
--- Create a smaller window, fill it red and write some text to it:
--- 
--- ```lua
--- local my_window = window.create(term.current(), 1, 1, 20, 5)
--- my_window.setBackgroundColour(colours.red)
--- my_window.setTextColour(colours.white)
--- my_window.clear()
--- my_window.write("Testing my window!")
--- ```
--- 
--- Create a smaller window and redirect to it:
--- 
--- ```lua
--- local my_window = window.create(term.current(), 1, 1, 25, 5)
--- term.redirect(my_window)
--- print("Writing some long text which will wrap around and show the bounds of this window.")
--- ```
--- 
--- @nodiscard
--- @param parent term.redirect The parent terminal redirect to draw to.
--- @param x number The x coordinate this window is drawn at in the parent terminal.
--- @param y number The y coordinate this window is drawn at in the parent terminal.
--- @param width number The width of this window.
--- @param height number The height of this window.
--- @param startVisible boolean? Whether this window is visible by default. Defaults to true.
--- @return window.window
function window.create(parent, x, y, width, height, startVisible) end

--- The window object. Refer to the [module's documentation](lua://window) for a full description.
--- 
--- @see term.redirect
--- 
--- @class window.window: term.redirect
local instance = {}

--- Get the buffered contents of a line in this window.
--- 
--- Throws if `y` is not between 1 and this window's height.
--- 
--- @nodiscard
--- @param y number The y position of the line to get.
--- @return string # The textual content of this line.
--- @return string # The text colours of this line, suitable for use with [`term.blit`](lua://term.blit).
--- @return string # The background colours of this line, suitable for use with [`term.blit`](lua://term.blit).
function instance.getLine(y) end

--- Set whether this window is visible. Invisible windows will not be drawn to the screen until they are made visible again.
--- 
--- Making an invisible window visible will immediately draw it.
--- 
--- @param visible boolean Whether this window is visible.
function instance.setVisible(visible) end

--- Get whether this window is visible. Invisible windows will not be drawn to the screen until they are made visible again.
--- 
--- @see window.window.setVisible
--- 
--- @return boolean # Whether this window is visible.
function instance.getVisible() end

--- Draw this window. This does nothing if the window is not visible.
--- 
--- @see window.window.setVisible
function instance.redraw() end

--- Set the current terminal's cursor to where this window's cursor is. 
--- This does nothing if the window is not visible.
function instance.restoreCursor() end

--- Get the position of the top left corner of this window.
--- 
--- @return number # The x position of this window.
--- @return number # The y position of this window.
function instance.getPosition() end

--- Reposition or resize the given window.
--- 
--- This function also accepts arguments to change the size of this window. 
--- It is recommended that you fire a `term_resize` event after changing a window's, to allow programs to adjust their sizing.
--- 
--- @param x number The new x position of this window.
--- @param y number The new y position of this window.
--- @param width number? The new width of this window.
--- @param height number? The new height of this window.
--- @param parent term.redirect? The new redirect object this window should draw to.
function instance.reposition(x, y, width, height, parent) end
