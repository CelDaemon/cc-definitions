--- @meta cc.require

--- A pure Lua implementation of the builtin [`require`](lua://require) function and [`package`](lua://package) library.
--- 
--- Generally you do not need to use this module - it is injected into the every program's environment. 
--- However, it may be useful when building a custom shell or when running programs yourself.
--- 
--- Construct the package and require function, and insert them into a custom environment:
--- 
--- ```lua
--- local r = require "cc.require"
--- local env = setmetatable({}, { __index = _ENV })
--- env.require, env.package = r.make(env, "/")
---
--- -- Now we have our own require function, separate to the original.
--- local r2 = env.require "cc.require"
--- print(r, r2)
--- ```
--- 
--- [Reusing code with require](https://tweaked.cc/guide/using_require.html) For an introduction on how to use [`require`](lua://require).
--- @class cc.require   
local require = {}

--- Build an implementation of Lua's [`package`](lua://package) library, and a [`require`](lua://require) function to load modules within it.
--- 
--- @param env table The environment to load packages into.
--- @param dir string The directory that relative packages are loaded from.
--- @return fun(modname: string): any, any # The new [`require`](lua://require) function.
--- @return table # The new [`package`](lua://package) library.
function require.make(env, dir) end

return require