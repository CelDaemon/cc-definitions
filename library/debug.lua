--- @meta debug

--- @class debuglib
debug = {}


--- Returns the current environment in use by the function. `f` can be a Lua function or a number that specifies the function at that stack level.
--- 
--- @nodiscard
--- @param o any The object to set the environment of.
--- @return table # The object's environment table.
function debug.getfenv(o) end
--- Returns the current hook settings of the thread.
--- 
--- @nodiscard
--- @param co thread? The thread to returns hooks for.
--- @return function hook The hooked function.
--- @return string mask The hook mask
--- @return number count The hook count.
function debug.gethook(co) end


--- @class debuginfo
--- @field name string
--- @field namewhat string
--- @field source string
--- @field short_src string
--- @field linedefined number
--- @field lastlinedefined number
--- @field what string
--- @field currentline number
--- @field istailcall boolean
--- @field nups number
--- @field npargs number
--- @field isvarargs boolean
--- @field func function
--- @field activelines table

--- @alias infowhat
--- |+"n" # `name` and `namewhat`
--- |+"S" # `source`, `short_src`, `linedefined`, `lastlinedefined`, and `what`
--- |+"l" # `currentline`
--- |+"t" # `istailcall`
--- |+"u" # `nups`, `nparams`, and `isvararg`
--- |+"f" # `func`
--- |+"L" # `activelines`

--- Returns a table with information about a function.
--- 
--- @nodiscard
--- @param thread thread The thread to return the info of.
--- @param f number | async fun(...): ... The function to return the info of.
--- @param what infowhat? What info to return.
--- @return debuginfo # The function info.
function debug.getinfo(thread, f, what) end
--- Returns a table with information about a function.
--- 
--- @nodiscard
--- @param f number | async fun(...): ... The function to return the info of.
--- @param what infowhat? What info to return.
--- @return debuginfo # The function info.
function debug.getinfo(f, what) end

--- Returns the name and the value of the local variable with index `local` of the function at level `f` of the stack.
--- 
--- @nodiscard
--- @param thread thread The thread to return the local of.
--- @param f number | async fun(...): ... The function to return the local of.
--- @param index number The index of the local.
--- @return string name The name of the local.
--- @return any value The value of the local.
function debug.getlocal(thread, f, index) end

--- Returns the name and the value of the local variable with index `local` of the function at level `f` of the stack.
--- 
--- @nodiscard
--- @param f number | async fun(...): ... The function to return the local of.
--- @param index number The index of the local.
--- @return string name The name of the local.
--- @return any value The value of the local.
function debug.getlocal(f, index) end


--- Returns the metatable of the given value.
--- 
--- @nodiscard
--- @param object any The object to return the metatable of.
--- @return table # The object's metatable.
function debug.getmetatable(object) end


--- Returns the registry table.
--- 
--- @nodiscard
--- @return table # The registry table.
function debug.getregistry() end


--- Returns the name and the value of the upvalue with index `up` of the function.
--- 
--- @nodiscard
--- @param f async fun(...): ... The function to return the upvalue from.
--- @param up number The id of the upvalue.
--- @return string name The name of the upvalue.
--- @return any value The value of the upvalue.
function debug.getupvalue(f, up) end


--- Sets the environment to be used by the given function.
--- 
--- @generic T
--- @param object T The function to set the environment of.
--- @param env table The new environment.
--- @return T object The modified function.
function debug.setfenv(object, env) end

--- @alias hookmask string
--- |+"c" # Calls hook when Lua calls a function.
--- |+"r" # Calls hook when Lua returns from a function.
--- |+"l" # Calls hook when Lua enters a new line of code.

--- Sets the given function as a hook.
--- 
--- @param thread thread The thread to set the hook for.
--- @param hook async fun(...): ... The hook to be called.
--- @param mask hookmask The mask to hook into.
--- @param count number? The count of the hook.
function debug.sethook(thread, hook, mask, count) end

--- Sets the given function as a hook.
--- 
--- @param hook async fun(...): ... The hook to be called.
--- @param mask hookmask The mask to hook into.
--- @param count number? The count of the hook.
function debug.sethook(hook, mask, count) end
--- Sets the given function as a hook.
--- 
--- @param thread thread The thread to set the hook for.
function debug.sethook(thread) end

--- Sets the given function as a hook.
--- 
--- @param ... any The args for the hook.
function debug.sethook(...) end


--- Assigns the `value` to the local variable with index `local` of the function at `level` of the stack.
--- 
--- @param thread thread The thread to set the local for.
--- @param level number The level to set the local for.
--- @param index number The local index to set.
--- @param value any The value to set the local to.
--- @return string name The name of the local.
function debug.setlocal(thread, level, index, value) end

--- Assigns the `value` to the local variable with index `local` of the function at `level` of the stack.
--- 
--- @param level number The level to set the local for.
--- @param index number The local index to set.
--- @param value any The value to set the local to.
function debug.setlocal(level, index, value) end


--- Sets the metatable for the given value to the given table (which can be `nil`).
--- 
--- @generic T The type of the given value.
--- @param value T The value to set the metatable for.
--- @param meta table? The new metatable.
--- @return T value The modified value.
function debug.setmetatable(value, meta) end

--- Assigns the `value` to the upvalue with index `up` of the function.
---
--- @param f async fun(...): ... The function to set the upvalue for.
--- @param up number The id of the upvalue.
--- @param value any The new value of the upvalue.
--- @return string name The name of the upvalue.
function debug.setupvalue(f, up, value) end

--- Returns a string with a traceback of the call stack. The optional message string is appended at the beginning of the traceback.
--- 
--- @nodiscard
--- @param thread thread The thread to traceback.
--- @param message any? The message to append.    
--- @param level number? The level of the stack to trace back.
--- @return string message The traceback message.
function debug.traceback(thread, message, level) end

return debug