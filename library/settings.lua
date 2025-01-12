--- @meta _

--- Read and write configuration options for CraftOS and your programs.
--- 
--- When a computer starts, it reads the current value of settings from the `/.settings` file. These values then may be [read](lua://settings.get) or [modified](lua://settings.set).
--- 
--- > Warning:
--- > Calling [`settings.set`](lua://settings.set) does not update the settings file by default. You must call [`settings.save`](lua://settings.save) to persist values.
--- 
--- Define an basic setting 123 and read its value:
--- 
--- ```lua
--- settings.define("my.setting", {
---     description = "An example setting",
---     default = 123,
---     type = "number",
--- })
--- print("my.setting = " .. settings.get("my.setting")) -- 123
--- ```
--- 
--- You can then use the `set` program to change its value (e.g. `set my.setting 456`), and then re-run the `example` program to check it has changed.    
--- 
--- @class settings
settings = {}

--- A type that is used to check the value being set to a setting.
--- @alias settings.type
--- | "number"
--- | "string"
--- | "boolean"
--- | "table"

--- @alias settings.value
--- | number
--- | string
--- | boolean
--- | {[any]: settings.value?}

--- @class settings.setting Options for a setting.
--- @field description string? A description which may be printed when running the `set` program.
--- @field default settings.value? A default value, which is returned by [`settings.get`](lua://settings.get) if the setting has not been changed.
--- @field type settings.type? Require values to be of this type. [Setting](lua://settings.set) the value to another type will error.

--- @class settings.details: settings.setting Information about a setting. 
--- @field value settings.value? The value of the setting.

--- Define a new setting, optional specifying various properties about it.
--- 
--- While settings do not have to be added before being used, doing so allows you to provide defaults and additional metadata.
--- 
--- @param name string The name of this option.
--- @param options settings.setting? Options for this setting.
function settings.define(name, options) end

--- Remove a [definition](lua://settings.define) of a setting.
--- 
--- If a setting has been changed, this does not remove its value. Use [`settings.unset`](lua://settings.unset) for that.
--- 
--- @param name string The name of this option.
function settings.undefine(name) end

--- Set the value of a setting.
--- 
--- > Warning:
--- > Calling [`settings.set`](lua://settings.set) does not update the settings file by default. You must call [`settings.save`](lua://settings.save) to persist values.
--- 
--- Throws if this value cannot be serialised.
--- 
--- @see settings.unset
--- 
--- @param name string The name of the setting to set.
--- @param value settings.value The setting's value. This cannot be `nil`, and must be serialisable by [`textutils.serialize`](lua://textutils.serialize).
function settings.set(name, value) end

--- Get the value of a setting.
--- 
--- @nodiscard
--- @param name string The name of the setting to set.
--- @param default settings.value? The value to use should there be pre-existing value for this setting. If not given, it will use the setting's default value if given, or `nil` otherwise.
--- @return settings.value? # The setting's, or the default if the setting has not been changed.
function settings.get(name, default) end

--- Get details about a specific setting.
--- 
--- @nodiscard
--- @param name string The name of the setting to get.
--- @return settings.details # Information about this setting. This includes all information from [`settings.define`](lua://settings.define), as well as this setting's value.
function settings.getDetails(name) end

--- Remove the value of a setting, setting it to the default.
--- 
--- [`settings.get`](lua://settings.get) will return the default value until the setting's value is [set](lua://settings.set), or the computer is rebooted.
--- 
--- @see settings.set
--- @see settings.clear
--- 
--- @param name string The name of the setting to unset.
function settings.unset(name) end

--- Resets the value of all settings. Equivalent to calling [`settings.unset`](lua://settings.unset) on every setting.
--- 
--- @see settings.unset
function settings.clear() end

--- Get the names of all currently defined settings.
--- 
--- @nodiscard
--- @return string[] # An alphabetically sorted list of all currently-defined settings.
function settings.getNames() end

--- Load settings from the given file.
--- 
--- Existing settings will be merged with any pre-existing ones. Conflicting entries will be overwritten, but any others will be preserved.
--- 
--- @see settings.save
--- 
--- @nodiscard
--- @param path string? The file to load from. The default path is `".settings"` .
--- @return boolean # Whether settings were successfully read from this file. Reasons for failure may include the file not existing or being corrupted.
function settings.load(path) end

--- Save settings to the given file.
--- 
--- This will entirely overwrite the pre-existing file. Settings defined in the file, but not currently loaded will be removed.
--- 
--- @see settings.load
--- 
--- @nodiscard
--- @param path string? The path to save settings to. The default path is `".settings"` .
--- @return boolean # If the settings were successfully saved.
function settings.save(path) end