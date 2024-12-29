--- @meta _

--- @class coroutinelib
coroutine = {}

--- Creates a new coroutine, with body `f`. `f` must be a function. Returns this new coroutine, an object with type `"thread"`.
--- 
--- @nodiscard
--- @param f async fun(...):...
--- @return thread # The new coroutine.
function coroutine.create(f) end

--- Returns true when the running coroutine can yield.
--- 
--- @nodiscard
--- @return boolean # Whether or not the running coroutine can yield.
function coroutine.isyieldable() end

--- Starts or continues the execution of coroutine `co`.
--- 
--- @param co thread The coroutine to start or continue.
--- @param ... any Extra arguments to pass to the coroutine.
--- @return boolean success Whether the coroutine succeeded.
--- @return any ... Extra data returned from the coroutine.
function coroutine.resume(co, ...) end

--- Returns the running coroutine plus a boolean, true when the running coroutine is the main one.
--- 
--- @nodiscard
--- @return thread running The currently running coroutine.
--- @return boolean ismain Whether the running coroutine is the main coroutine.
function coroutine.running() end


--- Returns the status of coroutine `co`.
--- 
--- @nodiscard
--- @param co thread The coroutine to return the status of.
--- @return 
---| 'running' # Is running.
---| 'suspended' # Is suspended or not started.
---| 'normal' # Is active but not running.'
---| 'dead' # Has finished or stopped with an error.
function coroutine.status(co) end

--- Creates a new coroutine, with body `f`; `f` must be a function. Returns a function that resumes the coroutine each time it is called.
--- 
--- @nodiscard
--- @param f async fun(...):...
--- @return fun(...):...
--- @nodiscard
function coroutine.wrap(f) end

--- Suspends the execution of the calling coroutine.
--- 
--- @async
--- @return any ...
function coroutine.yield(...) end