--- @meta cc.pretty



--- A pretty printer for rendering data structures in an aesthetically pleasing manner.
--- 
--- In order to display something using [`cc.pretty`](lua://cc.pretty), you build up a series of [documents](lua://cc.pretty.document). 
--- These behave a little bit like strings; you can concatenate them together and then print them to the screen.
--- 
--- However, documents also allow you to control how they should be printed. There are several functions (such as [`nest`](lua://cc.pretty.nest) and [`group`](lua://cc.pretty.group)) which allow you to control the "layout" of the document. 
--- When you come to display the document, the 'best' (most compact) layout is used.
--- 
--- The structure of this module is based on [A Prettier Printer](https://homepages.inf.ed.ac.uk/wadler/papers/prettier/prettier.pdf).
--- 
--- Print a table to the terminal:
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- pretty.pretty_print({ 1, 2, 3 })
--- ```
--- 
--- Build a custom document and display it:
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- pretty.print(pretty.group(pretty.text("hello") .. pretty.space_line .. pretty.text("world")))
--- ```
--- 
--- @class cc.pretty
--- @field empty document An empty document.
--- @field space document A document with a single space in it.
--- @field line document A line break. When collapsed with [`group`](lua://cc.pretty.group), this will be replaced with [`empty`](lua://cc.pretty.empty).
--- @field space_line document A line break. When collapsed with [`group`](lua://cc.pretty.group), this will be replaced with [`space`](lua://cc.pretty.space).
local pretty = {}

--- A document containing formatted text, with multiple possible layouts.
--- 
--- Documents effectively represent a sequence of strings in alternative layouts, which we will try to print in the most compact form necessary.
--- @class document

--- Create a new document from a string.
--- 
--- If your string contains multiple lines, [`group`](lua://cc.pretty.group) will flatten the string into a single line, with spaces between each line.
--- 
--- Write some blue text:
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- pretty.print(pretty.text("Hello!", colours.blue))
--- ```
--- 
--- @nodiscard
--- @param text string The string to construct a new document with.
--- @param colour number? The colour this text should be printed with. If not given, we default to the current colour.
--- @return document # The document with the provided text.
function pretty.text(text, colour) end

--- Concatenate several documents together. This behaves very similar to string concatenation.
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- local doc1, doc2 = pretty.text("doc1"), pretty.text("doc2")
--- print(pretty.concat(doc1, " - ", doc2))
--- print(doc1 .. " - " .. doc2) -- Also supports ..
--- ```
--- 
--- @nodiscard
--- @param ... document | string The documents to concatenate.  
--- @return document # The concatenated documents.
function pretty.concat(...) end

--- Indent later lines of the given document with the given number of spaces.
--- 
--- For instance, nesting the document
--- 
--- ```
--- foo
--- bar
--- ```
--- 
--- by two spaces will produce
--- 
--- ```
--- foo
---   bar
--- ```
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- print(pretty.nest(2, pretty.text("foo\nbar")))
--- ```
--- 
--- @nodiscard
--- @param depth number The number of spaces with which the document should be indented.
--- @param doc document The document to indent.
--- @return document # The nested document.
function pretty.nest(depth, doc) end

--- Builds a document which is displayed on a single line if there is enough room, or as normal if not.
--- 
--- Uses group to show things being displayed on one or multiple lines:
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- local doc = pretty.group("Hello" .. pretty.space_line .. "World")
--- print(pretty.render(doc, 5)) -- On multiple lines
--- print(pretty.render(doc, 20)) -- Collapsed onto one.
--- ```
--- 
--- @nodiscard
--- @param doc document The document to group.
--- @return document # The grouped document.
function pretty.group(doc) end

--- Display a document on the terminal.
--- 
--- @param doc document The document to render.
--- @param ribbon_frac number? The maximum fraction of the width that we should write in. The default is `0.6`.
function pretty.write(doc, ribbon_frac) end

--- Display a document on the terminal with a trailing new line.
--- 
--- @param doc document The document to render.
--- @param ribbon_frac number? The maximum fraction of the width that we should write in. The default is `0.6`.
function pretty.print(doc, ribbon_frac) end

--- Render a document, converting it into a string.
--- 
--- @nodiscard
--- @param doc document The document to render.
--- @param width number? The maximum width of this document. Note that long strings will not be wrapped to fit this width - it is only used for finding the best layout.
--- @param ribbon_frac number The maximum fraction of the width that we should write in. The default is `0.6`.
--- @return string # The rendered document as a string.
function pretty.render(doc, width, ribbon_frac) end

--- Controls how various properties are displayed.
--- @class pretty.options
--- @field function_args boolean? Show the arguments to a function if known (`false` by default).
--- @field function_source boolean? Show where the function was defined, instead of `function: xxxxxxxx` (`false` by default).

--- Pretty-print an arbitrary object, converting it into a document.
--- 
--- This can then be rendered with [`write`](lua://cc.pretty.write) or [`print`](lua://cc.pretty.print).
--- 
--- Display a table on the screen:
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- pretty.print(pretty.pretty({ 1, 2, 3 }))
--- ```
--- 
--- @see cc.pretty.pretty_print for a shorthand to prettify and print an object.
--- 
--- @nodiscard
--- @param obj any The object to pretty-print.
--- @param options pretty.options? Controls how various properties are displayed.
--- @return document # The object formatted as a document.
function pretty.pretty(obj, options) end

--- A shortcut for calling [`pretty`](lua://cc.pretty.pretty) and [`print`](lua://cc.pretty.print) together.
--- 
--- Display a table on the screen:
--- 
--- ```lua
--- local pretty = require "cc.pretty"
--- pretty.pretty_print({ 1, 2, 3 })
--- ```
--- 
--- @see cc.pretty.pretty
--- @see cc.pretty.print
--- 
--- @param obj any The object to pretty-print.
--- @param options pretty.options? Controls how various properties are displayed.
--- @param ribbon_frac number? The maximum fraction of the width that we should write in. The default is `0.6`.  
function pretty.pretty_print(obj, options, ribbon_frac) end

return pretty