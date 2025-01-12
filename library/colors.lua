--- @meta _

--- Constants and functions for colour values, suitable for working with [`term`](lua://term) and [`redstone`](lua://redstone).
--- 
--- This is useful in conjunction with [Bundled Cables](lua://redstone.setBundledOutput) from mods like Project Red, and [colors on Advanced Computers and Advanced Monitors](lua://term.setTextColour).
--- 
--- For the non-American English version just replace [`colors`](lua://colors) with [`colours`](lua://colours). 
--- This alternative API is exactly the same, except the colours use British English (e.g. [`colors.gray`](lua://colors.gray) is spelt [`colours.grey`](lua://colours.grey)).
--- 
--- On basic terminals (such as the Computer and Monitor), all the colors are converted to grayscale. 
--- This means you can still use all 16 colors on the screen, but they will appear as the nearest tint of gray. 
--- You can check if a terminal supports color by using the function [`term.isColor`](lua://term.isColor).
--- 
--- Grayscale colors are calculated by taking the average of the three components, i.e. `(red + green + blue) / 3`.
--- 
--- @see colours    
--- 
--- @class colors: colors.shared
colors = {}

--- Gray: Written as `7` in paint files and [`term.blit`], has a default
--- terminal colour of #4C4C4C.
colors.gray = 0x80

--- Light gray: Written as `8` in paint files and [`term.blit`], has a
--- default terminal colour of #999999.
colors.lightGray = 0x100

--- @class colors.shared
local shared = {}

--- White: Written as `0` in paint files and [`term.blit`], has a default
--- terminal colour of #F0F0F0.
shared.white = 0x1

--- Orange: Written as `1` in paint files and [`term.blit`], has a
--- default terminal colour of #F2B233.
shared.orange = 0x2

--- Magenta: Written as `2` in paint files and [`term.blit`], has a
--- default terminal colour of #E57FD8.
shared.magenta = 0x4

--- Light blue: Written as `3` in paint files and [`term.blit`], has a
--- default terminal colour of #99B2F2.
shared.lightBlue = 0x8

--- Yellow: Written as `4` in paint files and [`term.blit`], has a
--- default terminal colour of #DEDE6C.
shared.yellow = 0x10

--- Lime: Written as `5` in paint files and [`term.blit`], has a default
--- terminal colour of #7FCC19.
shared.lime = 0x20

--- Pink: Written as `6` in paint files and [`term.blit`], has a default
--- terminal colour of #F2B2CC.
shared.pink = 0x40

--- Cyan: Written as `9` in paint files and [`term.blit`], has a default
--- terminal colour of #4C99B2.
shared.cyan = 0x200

--- Purple: Written as `a` in paint files and [`term.blit`], has a
--- default terminal colour of #B266E5.
shared.purple = 0x400

--- Blue: Written as `b` in paint files and [`term.blit`], has a default
--- terminal colour of #3366CC.
shared.blue = 0x800

--- Brown: Written as `c` in paint files and [`term.blit`], has a default
--- terminal colour of #7F664C.
shared.brown = 0x1000

--- Green: Written as `d` in paint files and [`term.blit`], has a default
--- terminal colour of #57A64E.
shared.green = 0x2000

--- Red: Written as `e` in paint files and [`term.blit`], has a default
--- terminal colour of #CC4C4C.
shared.red = 0x4000

--- Black: Written as `f` in paint files and [`term.blit`], has a default
--- terminal colour of #111111.
shared.black = 0x8000

--- Combines a set of colors (or sets of colors) into a larger set. 
--- Useful for Bundled Cables.
--- 
--- ```lua
--- colors.combine(colors.white, colors.magenta, colours.lightBlue)
--- -- => 13
--- ```
--- 
--- @nodiscard
--- @param ... number The colors to combine.
--- @return number # The union of the color sets given in `...`.
function shared.combine(...) end

--- Removes one or more colors (or sets of colors) from an initial set. 
--- Useful for Bundled Cables.
--- 
--- Each parameter beyond the first may be a single color or may be a set of colors (in the latter case, all colors in the set are removed from the original set).
--- 
--- ```lua
--- colours.subtract(colours.lime, colours.orange, colours.white)
--- -- => 32
--- ```
--- 
--- @nodiscard
--- @param colors number The color from which to subtract.
--- @param ... number The colors to subtract.
--- @return number # The resulting color.
function shared.subtract(colors, ...) end

--- Tests whether `color` is contained within `colors`.
--- Useful for Bundled Cables.
--- 
--- ```lua
--- colors.test(colors.combine(colors.white, colors.magenta, colours.lightBlue), colors.lightBlue)
--- -- => true
--- ```
--- 
--- @nodiscard
--- @param colors number A color, or color set.
--- @param color number A color or set of colors that `colors` should contain.
--- @return boolean # If `colors` contains all colors within `color`.
function shared.test(colors, color) end

--- Combine a three-colour RGB value into one hexadecimal representation.
--- 
--- ```lua
--- colors.packRGB(0.7, 0.2, 0.6)
--- -- => 0xb23399
--- ```
--- 
--- @nodiscard
--- @param r number The red channel, should be between 0 and 1.
--- @param g number The green channel, should be between 0 and 1.
--- @param b number The blue channel, should be between 0 and 1.
--- @return number # The combined hexadecimal colour.
function shared.packRGB(r, g, b) end

--- Separate a hexadecimal RGB colour into its three constituent channels.
--- 
--- ```lua
--- colors.unpackRGB(0xb23399)
--- -- => 0.7, 0.2, 0.6
--- ```
--- 
--- @see colors.packRGB
--- 
--- @nodiscard
--- @param rgb number The combined hexadecimal colour.
--- @return number # The red channel, will be between 0 and 1.
--- @return number # The green channel, will be between 0 and 1.
--- @return number # The blue channel, will be between 0 and 1.
function shared.unpackRGB(rgb) end

--- Either calls [`colors.packRGB`](lua://colors.packRGB) or [`colors.unpackRGB`](lua://colors.unpackRGB), depending on how many arguments it receives.
--- 
--- ```lua
--- colors.rgb8(0xb23399)
--- -- => 0.7, 0.2, 0.6
--- ```
--- 
--- ```lua
--- colors.rgb8(0.7, 0.2, 0.6)
--- -- => 0xb23399
--- ```
--- 
--- @deprecated Use packRGB or unpackRGB directly.
--- 
--- @param r number The red channel, as an argument to [`colors.packRGB`](lua://colors.packRGB).
--- @param g number The green channel, as an argument to [`colors.packRGB`](lua://colors.packRGB).
--- @param b number The blue channel, as an argument to [`colors.packRGB`](lua://colors.packRGB).
--- @return number #  The combined hexadecimal colour, as returned by [`colors.packRGB`](lua://colors.packRGB).
function shared.rgb8(r, g, b) end

--- Either calls [`colors.packRGB`](lua://colors.packRGB) or [`colors.unpackRGB`](lua://colors.unpackRGB), depending on how many arguments it receives.
--- 
--- ```lua
--- colors.rgb8(0xb23399)
--- -- => 0.7, 0.2, 0.6
--- ```
--- 
--- ```lua
--- colors.rgb8(0.7, 0.2, 0.6)
--- -- => 0xb23399
--- ```
--- 
--- @deprecated Use packRGB or unpackRGB directly.
--- 
--- @param rgb number The combined hexadecimal color, as an argument to [`colors.unpackRGB`](lua://colors.unpackRGB).
--- @return number # The red channel, as returned by [`colors.unpackRGB`](lua://colors.unpackRGB).
--- @return number # The green channel, as returned by [`colors.unpackRGB`](lua://colors.unpackRGB).
--- @return number # The blue channel, as returned by [`colors.unpackRGB`](lua://colors.unpackRGB).
function shared.rgb8(rgb) end

--- Converts the given color to a paint/blit hex character (0-9a-f).
--- 
--- This is equivalent to converting `floor(log_2(color))` to hexadecimal. 
--- Values outside the range of a valid colour will error.
--- 
--- ```lua
--- colors.toBlit(colors.red)
--- -- => "c"
--- ```
--- 
--- @see colors.fromBlit
--- 
--- @param color number The color to convert.
--- @return string # The blit hex code of the color.
function shared.toBlit(color) end

--- Converts the given paint/blit hex character (0-9a-f) to a color.
--- 
--- This is equivalent to converting the hex character to a number and then 2 ^ decimal.
--- 
--- ```lua
--- colors.fromBlit("e")
--- -- => 16384
--- ```
--- 
--- @see colors.toBlit
--- 
--- @param hex string The paint/blit hex character to convert.
--- @return number # The color.
function shared.fromBlit(hex) end