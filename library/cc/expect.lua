--- @meta cc.expect


--- The [`cc.expect`](lua://cc.expect) library provides helper functions for verifying that function arguments are well-formed and of the correct type.
--- 
--- Define a basic function and check it has the correct arguments:
--- 
--- ```lua
--- local expect = require "cc.expect"
--- local expect, field = expect.expect, expect.field
---
--- local function add_person(name, info)
---     expect(1, name, "string")
---     expect(2, info, "table", "nil")
---
---    if info then
---        print("Got age=", field(info, "age", "number"))
---        print("Got gender=", field(info, "gender", "string", "nil"))
---    end
--- end
---
--- add_person("Anastazja") -- `info' is optional
--- add_person("Kion", { age = 23 }) -- `gender' is optional
--- add_person("Caoimhin", { age = 23, gender = true }) -- error!
--- ```
--- 
--- @class cc.expect
local expect = {}

--- Expect an argument to have a specific type.
--- 
--- Throws if the value is not one of the allowed types.
--- 
--- @generic T The type of argument that was passed in.
--- 
--- @param index number The 1-based argument index.
--- @param value T The argument's value.
--- @param ... string The allowed types of the argument.
--- @return T # The given `value`.
function expect.expect(index, value, ...) end

--- Expect an field to have a specific type.
--- 
--- Throws if the field is not one of the allowed types.
--- 
--- @generic T The table value type.
--- 
--- @param tbl {[string]: T} The table to index.
--- @param index string The field name to check.
--- @param ... string The allowed types of the argument.
--- @return T # The contents of the given field.
function expect.field(tbl, index, ...) end

--- Expect a number to be within a specific range.
--- 
--- Throws if the value is outside of the allowed range.
--- 
--- @generic T: number The type of argument that was passed in.
--- 
--- @param num T The value to check.
--- @param min number? The minimum value. `-math.huge` by default.
--- @param max number? The maximum value. `math.huge` by default.
--- @return T # The given `value`.
function expect.range(num, min, max) end

return expect