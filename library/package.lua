--- @meta package


--- Loads the given module, returns any value returned by the searcher(`true` when `nil`). 
--- Besides that value, also returns as a second result the loader data returned by the searcher, which indicates how `require` found the module. 
--- (For instance, if the module came from a file, this loader data is the file path.)
--- 
--- @param modname string The name of the module to load.
--- @return any # The loaded module.
--- @return any loaderdata Information about how the module was loaded.
function require(modname) end

--- @class packagelib
--- A table used by `require` to control which modules are already loaded.
--- @field loaded table
--- The path used by `require` to search for a Lua loader.
--- @field path string
--- A table to store loaders for specific modules.
--- @field preload table
package = {}

--- A string describing some compile-time configurations for packages.
package.config = [[
/
;
?
!
-]]

--- A table used by `require` to control how to load modules.
package.loaders = {}

--- Searches for the given `name` in the given `path`.
--- 
--- @nodiscard
--- @param name string The name of the library to search for.
--- @param path string The path to search on.
--- @param sep string? The directory seperator in the library name.
--- @param rep string? The directory seperator on the filesystem.
--- @return string? filename The found file path.
--- @return string? errmsg The error message when an error occurred.
function package.searchpath(name, path, sep, rep) end

return package