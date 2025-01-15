--- @meta cc.image.nft

--- Read and draw nft ("Nitrogen Fingers Text") images.
--- 
--- nft ("Nitrogen Fingers Text") is a file format for drawing basic images. 
--- Unlike the images that [`paintutils.parseImage`](lua://paintutils.parseImage) uses, nft supports coloured text as well as simple coloured pixels.
--- 
--- Load an image from example.nft and draw it:
--- 
--- ```lua
--- local nft = require "cc.image.nft"
--- local image = assert(nft.load("data/example.nft"))
--- nft.draw(image, term.getCursorPos())
--- ```
--- 
--- @class cc.image.nft
local nft = {}

--- @class cc.image.nft.line
--- @field background string
--- @field foreground string
--- @field text string

--- @alias cc.image.nft.image cc.image.nft.line[]

--- Parse an nft image from a string.
--- 
--- @param image string The image contents.
--- @return cc.image.nft.image # The parsed image.
function nft.parse(image) end