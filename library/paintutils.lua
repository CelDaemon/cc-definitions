--- @meta _

--- Utilities for drawing more complex graphics, such as pixels, lines and images.
--- @class paintutils
paintutils = {}

--- @alias paintutils.image number[][]

--- Parses an image from a multi-line string
--- 
--- @param image string The string containing the raw-image data.
--- @return paintutils.image # The parsed image data, suitable for use with [`paintutils.drawImage`](lua://paintutils.drawImage).
function paintutils.parseImage(image) end

--- Loads an image from a file.
--- 
--- You can create a file suitable for being loaded using the `paint` program.
--- 
--- Load an image and draw it:
--- 
--- ```lua
--- local image = paintutils.loadImage("data/example.nfp")
--- paintutils.drawImage(image, term.getCursorPos())
--- ```
--- 
--- @param path string The file to load.
--- @return paintutils.image? # The parsed image data, suitable for use with [`paintutils.drawImage`](lua://paintutils.drawImage), or `nil` if the file does not exist.
function paintutils.loadImage(path) end

--- Draws a single pixel to the current term at the specified position.
--- 
--- Be warned, this may change the position of the cursor and the current background colour. 
--- You should not expect either to be preserved.
--- 
--- @param x number The x position to draw at, where 1 is the far left.
--- @param y number The y position to draw at, where 1 is the very top.
--- @param colour number? The [`color`](lua://color) of this pixel. This will be the current background colour if not specified.
function paintutils.drawPixel(x, y, colour) end

--- Draws a straight line from the start to end position.
--- 
--- Be warned, this may change the position of the cursor and the current background colour. 
--- You should not expect either to be preserved.
--- 
--- ```lua
--- paintutils.drawLine(2, 3, 30, 7, colors.red)
--- ```
--- 
--- @param startX number The starting x position of the line.
--- @param startY number The starting y position of the line.
--- @param endX number The end x position of the line.
--- @param endY number The end Y position of the line.
--- @param colour number? The [`color`](lua://color) of this pixel. This will be the current background colour if not specified.
function paintutils.drawLine(startX, startY, endX, endY, colour) end

--- Draws the outline of a box on the current term from the specified start position to the specified end position.
--- 
--- Be warned, this may change the position of the cursor and the current background colour. 
--- You should not expect either to be preserved.
--- 
--- ```lua
--- paintutils.drawBox(2, 3, 30, 7, colors.red)
--- ```
--- 
--- @param startX number The starting x position of the line.
--- @param startY number The starting y position of the line.
--- @param endX number The end x position of the line.
--- @param endY number The end Y position of the line.
--- @param colour number? The [`color`](lua://color) of this pixel. This will be the current background colour if not specified.
function paintutils.drawBox(startX, startY, endX, endY, colour) end

--- Draws a filled box on the current term from the specified start position to the specified end position.
--- 
--- Be warned, this may change the position of the cursor and the current background colour. 
--- You should not expect either to be preserved.
--- 
--- ```lua
--- paintutils.drawFilledBox(2, 3, 30, 7, colors.red)
--- ```
--- 
--- @param startX number The starting x position of the line.
--- @param startY number The starting y position of the line.
--- @param endX number The end x position of the line.
--- @param endY number The end Y position of the line.
--- @param colour number? The [`color`](lua://color) of this pixel. This will be the current background colour if not specified.
function paintutils.drawFilledBox(startX, startY, endX, endY, colour) end

--- Draw an image loaded by [`paintutils.parseImage`](lua://paintutils.parseImage) or [`paintutils.loadImage`](lua://paintutils.loadImage).
--- 
--- @param image paintutils.image The parsed image data.
--- @param x number The x position to start drawing at.
--- @param y number The y position to start drawing at.
function paintutils.drawImage(image, x, y) end