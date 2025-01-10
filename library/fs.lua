--- @meta _

--- Interact with the computer's files and filesystem, allowing you to manipulate files, directories and paths. 
--- This includes:
--- 
--- - Reading and writing files: Call [open](lua://fs.open) to obtain a file "handle", which can be used to read from or write to a file.
--- - Path manipulation: [`combine`](lua://fs.combine), [`getName`](lua://fs.getName) and [`getDir`](lua://fs.getDir) allow you to manipulate file paths, joining them together or extracting components.
--- - Querying paths: For instance, checking if a file exists, or whether it's a directory. 
--- See [`getSize`](lua://fs.getSize), [`exists`](lua://fs.exists), [`isDir`](lua://fs.isDir), [`isReadOnly`](lua://fs.isReadOnly) and [`attributes`](lua://fs.attributes).
--- - File and directory manipulation: For instance, moving or copying files. See [`makeDir`](lua://fs.makeDir), [`move`](lua://fs.move), [`copy`](lua://fs.copy) and [`delete`](lua://fs.delete).
--- 
--- > Note:
--- > All functions in the API work on absolute paths, and do not take the [current directory](lua://fs.dir) into account. 
--- > You can use [`shell.resolve`](lua://shell.resolve) to convert a relative path into an absolute one.
--- 
--- ## Mounts
--- 
--- While a computer can only have one hard drive and filesystem, other filesystems may be "mounted" inside it. 
--- For instance, the [drive peripheral](lua://peripheral.drive) mounts its disk's contents at `"disk/"`, `"disk1/"`, etc...
--- 
--- You can see which mount a path belongs to with the [`getDrive`](lua://fs.getDrive) function. 
--- This returns `"hdd"` for the computer's main filesystem (`"/"`), `"rom"` for the rom (`"rom/"`).
--- 
--- Most filesystems have a limited capacity, operations which would cause that capacity to be reached (such as writing an incredibly large file) will fail. 
--- You can see a mount's capacity with [`getCapacity`](lua://fs.getCapacity) and the remaining space with [`getFreeSpace`](lua://fs.getFreeSpace).
--- @class fslib
fs = {}


--- Provides completion for a file or directory name, suitable for use with [`_G.read`](lua://_G.read).
--- 
--- When a directory is a possible candidate for completion, two entries are included - one with a trailing slash (indicating that entries within this directory exist) and one without it (meaning this entry is an immediate completion candidate). 
--- `include_dirs` can be set to false to only include those with a trailing slash.
--- 
--- Complete files in the root directory:
--- 
--- ```lua
--- read(nil, nil, function(str)
---     return fs.complete(str, "", true, false)
--- end)
--- ```
--- 
--- Complete files in the root directory, hiding hidden files by default:
--- 
--- ```lua
--- read(nil, nil, function(str)
---     return fs.complete(str, "", {
---         include_files = true,
---         include_dirs = false,
---         include_hidden = false,
---     })
--- end)
--- ```
--- 
--- @param path string The path to complete.
--- @param location string The location where paths are resolved from.
--- @param include_files boolean? When false, only directories will be included in the returned list. The default is true.
--- @param include_dirs boolean? When false, "raw" directories will not be included in the returned list. The default is true.
--- @return string[] # A list of possible completion candidates.
function fs.complete(path, location, include_files, include_dirs) end


--- @class fs.complete_options Options for [`fs.complete`](lua://fs.complete)
--- @field include_dirs boolean? When false, "raw" directories will not be included in the returned list.
--- @field include_files boolean? When false, only directories will be included in the returned list.
--- @field include_hidden boolean? Whether to include hidden files (those starting with `.`) by default. They will still be shown when typing a `.`.

--- Provides completion for a file or directory name, suitable for use with [`_G.read`](lua://_G.read).
--- 
--- When a directory is a possible candidate for completion, two entries are included - one with a trailing slash (indicating that entries within this directory exist) and one without it (meaning this entry is an immediate completion candidate). 
--- `include_dirs` can be set to false to only include those with a trailing slash.
--- 
--- Complete files in the root directory:
--- 
--- ```lua
--- read(nil, nil, function(str)
---     return fs.complete(str, "", true, false)
--- end)
--- ```
--- 
--- Complete files in the root directory, hiding hidden files by default:
--- 
--- ```lua
--- read(nil, nil, function(str)
---     return fs.complete(str, "", {
---         include_files = true,
---         include_dirs = false,
---         include_hidden = false,
---     })
--- end)
--- ```
--- 
--- @param path string The path to complete.
--- @param location string The location where paths are resolved from.
--- @param options fs.complete_options This table form is an expanded version of the previous syntax. The `include_files` and `include_dirs` arguments from above are passed in as fields.
--- @return string[] # A list of possible completion candidates.
function fs.complete(path, location, options) end

--- Searches for files matching a string with wildcards.
--- 
--- This string looks like a normal path string, but can include wildcards, which can match multiple paths:
--- 
--- - `"?"` matches any single character in a file name.
--- - `"*"` matches any number of characters.
--- 
--- For example, `rom/*/command*` will look for any path starting with `command` inside any subdirectory of `/rom`.
--- 
--- Note that these wildcards match a single segment of the path. For instance `rom/*.lua` will include `rom/startup.lua` but not include `rom/programs/list.lua`.
--- 
--- Throws if the supplied path was invalid.
--- 
--- List all Markdown files in the help folder:
--- 
--- ```lua
--- fs.find("rom/help/*.md")
--- ```
--- 
--- @param path string The wildcard-qualified path to search for.
--- @return string[] # A list of paths that match the search string.
function fs.find(path) end

--- Returns true if a path is mounted to the parent filesystem.
--- 
--- The root filesystem `"/"` is considered a mount, along with disk folders and the rom folder.
--- 
--- Throws if the path does not exist.
--- 
--- @see fs.getDrive
--- 
--- @param path string The path to check.
--- @return boolean # If the path is mounted, rather than a normal file/folder.
function fs.isDriveRoot(path) end

--- Returns a list of files in a directory.
--- 
--- Throws if the path doesn't exist.
--- 
--- List all files under `/rom/`:
--- 
--- ```lua
--- local files = fs.list("/rom/")
--- for i = 1, #files do
---     print(files[i])
--- end
--- 
--- @param path string The path to list.
--- @return string[] # A table with a list of files in the directory.
function fs.list(path) end


--- Combines several parts of a path into one full path, adding separators as needed.
--- 
--- Throws on argument errors.
--- 
--- Combine several file paths together:
--- 
--- ```lua
--- fs.combine("/rom/programs", "../apis", "parallel.lua")
--- -- => rom/apis/parallel.lua
--- ```
--- 
--- @param path string The first part of the path. For example, a parent directory path.
--- @param ... string Additional parts of the path to combine.
--- @return string # The new path, with separators added between parts as needed.
function fs.combine(path, ...) end

--- Returns the file name portion of a path.
--- 
--- Get the file name of `rom/startup.lua`:
--- 
--- ```lua
--- fs.getName("rom/startup.lua")
--- -- => startup.lua
--- ```
--- 
--- @param path string The path to get the name from.
--- @return string # The final part of the path (the file name).
function fs.getName(path) end


--- Returns the parent directory portion of a path.
--- 
--- Get the directory name of `rom/startup.lua`:
--- 
--- ```lua
--- fs.getDir("rom/startup.lua")
--- -- => rom
--- ```
--- 
--- @param path string The path to get the directory from.
--- @return string # The path with the final part removed (the parent directory).
function fs.getDir(path) end

--- Returns the size of the specified file.
--- 
--- Throws if the path doesn't exist.
--- 
--- @param path string The file to get the file size of.
--- @return number # The size of the file, in bytes.
function fs.getSize(path) end

--- Returns whether the specified path exists.
--- 
--- @param path string The path to check the existence of.
--- @return boolean # Whether the path exists.
function fs.exists(path) end

--- Returns whether the specified path is a directory.
--- 
--- @param path string The path to check.
--- @return boolean # Whether the path is a directory.
function fs.isDir(path) end

--- Returns whether a path is read-only.
--- 
--- @param path string The path to check.
--- @return boolean # Whether the path cannot be written to.
function fs.isReadOnly(path) end

--- Creates a directory, and any missing parents, at the specified path.
--- 
--- Throws if the directory couldn't be created.
--- 
--- @param path string The path to the directory to create.
function fs.makeDir(path) end

--- Moves a file or directory from one path to another.
--- 
--- Any parent directories are created as needed.
--- 
--- Throws if the file or directory couldn't be moved.
--- 
--- @param path string The current file or directory to move from.
--- @param dest string The destination path for the file or directory.
function fs.move(path, dest) end

--- Copies a file or directory to a new path.
--- 
--- Any parent directories are created as needed.
--- 
--- Throws if the file or directory couldn't be copied.
--- 
--- @param path string The file or directory to copy.
--- @param dest string The path to the destination file or directory.
function fs.copy(path, dest) end

--- @class fs.basic_handle
local basic_handle = {}

--- Close this file, freeing any resources it uses.
--- 
--- Once a file is closed it may no longer be read or written to.
--- 
--- Throws if the file has already been closed.
function basic_handle.close() end

--- The origin for [`seek`](lua://basic_handle.seek)
--- @alias fs.whence
--- | "set" # `offset` is relative to the beginning of the file.
--- | "cur" # Relative to the current position. This is the default.
--- | "end" # Relative to the end of the file.

--- Seek to a new position within the file, changing where bytes are written to. 
--- The new position is an offset given by `offset`, relative to a start position determined by `whence`.
--- 
--- In case of success, `seek` returns the new file position from the beginning of the file.
--- 
--- Throws if the file has been closed.
--- 
--- @param whence fs.whence? Where the offset is relative to.
--- @param offset number? The offset to seek to.
--- @return number? # The new position, or `nil` if seeking failed.
--- @return string? # The reason seeking failed.
function basic_handle.seek(whence, offset) end

--- @class fs.basic_read_handle: fs.basic_handle
local basic_read_handle = {}

--- Read the remainder of the file.
--- 
--- Throws if the file has been closed.
--- 
--- @return string? # The remaining contents of the file, or `nil` in the event of an error.
function basic_read_handle.readAll() end

--- Read a line from the file.
--- 
--- Throws if the file has been closed.
--- 
--- @param trailing boolean? Whether to include the newline characters with the returned string. Defaults to false.
--- @return string? # The read line or `nil` if at the end of the file.
function basic_read_handle.readLine(trailing) end


--- @class fs.read_handle: fs.basic_read_handle
local read_handle = {}

--- Read a number of bytes from this file.
--- 
--- Throws when trying to read a negative number of bytes, or if the file has been closed.
--- 
--- @param count number? The number of bytes to read. This may be 0 to determine we are at the end of the file. When absent, a single byte will be read.
--- @return string? # The bytes read as a string, or `nil` if we are at the end of the file.
function read_handle.read(count) end

--- @class fs.read_byte_handle: fs.basic_read_handle
local read_byte_handle = {}

--- Read a number of bytes from this file.
--- 
--- Throws when trying to read a negative number of bytes, or if the file has been closed.
--- 
--- @return number? # The value of the byte read, or `nil` if we are at the end of the file.
function read_byte_handle.read() end

--- @param count number The number of bytes to read. This may be 0 to determine we are at the end of the file. When absent, a single byte will be read.
--- @return string? # The bytes read as a string, or `nil` if we are at the end of the file.
function read_byte_handle.read(count) end


--- @class fs.write_handle: fs.basic_handle
local write_handle = {}

--- Write a string or byte to the file.
--- 
--- Throws if the file has been closed.
--- 
--- @param contents string The string to write.
function write_handle.write(contents) end

--- Write a string of characters to the file, following them with a new line character.
--- 
--- Throws if the file has been closed.
--- 
--- @param text string The text to write to the file.
function write_handle.writeLine(text) end

--- Save the current file without closing it.
--- 
--- Throws if the file has been closed.
function write_handle.flush() end

--- @class fs.write_byte_handle: fs.write_handle
local write_byte_handle = {}

--- Write a string or byte to the file.
--- 
--- Throws if the file has been closed.
--- 
--- @param contents string The string to write.
function write_byte_handle.write(contents) end

--- Write a string or byte to the file.
--- 
--- Throws if the file has been closed.
--- 
--- @param charcode number The byte to write.
function write_byte_handle.write(charcode) end

--- @class fs.read_write_handle: fs.read_handle, fs.write_handle

--- @class fs.read_write_byte_handle: fs.read_byte_handle, fs.write_byte_handle

--- Opens a file for reading or writing at a path.
--- 
--- Throws if an invalid mode was specified.
--- 
--- Read the contents of a file:
--- 
--- ```lua
--- local file = fs.open("/rom/help/intro.txt", "r")
--- local contents = file.readAll()
--- file.close()
---
--- print(contents)
--- ```
--- 
--- Open a file and read all lines into a table. [`io.lines`](lua://io.lines) offers an alternative way to do this.
--- 
--- ```lua
--- local file = fs.open("/rom/motd.txt", "r")
--- local lines = {}
--- while true do
---   local line = file.readLine()
---
---   -- If line is nil then we've reached the end of the file and should stop
---   if not line then break end
---
---   lines[#lines + 1] = line
--- end
---
--- file.close()
---
--- print(lines[math.random(#lines)]) -- Pick a random line and print it.
--- ```
--- 
--- Open a file and write some text to it. You can run `edit out.txt` to see the written text:
--- 
--- ```lua
--- local file = fs.open("out.txt", "w")
--- file.write("Just testing some code")
--- file.close() -- Remember to call close, otherwise changes may not be written!
--- ```
--- 
--- @param path string The path to the file to open.
--- @param mode "r" The mode to open the file with.
--- @return fs.read_handle
function fs.open(path, mode) end

--- Opens a file for reading or writing at a path.
--- 
--- Throws if an invalid mode was specified.
--- 
--- Read the contents of a file:
--- 
--- ```lua
--- local file = fs.open("/rom/help/intro.txt", "r")
--- local contents = file.readAll()
--- file.close()
---
--- print(contents)
--- ```
--- 
--- Open a file and read all lines into a table. [`io.lines`](lua://io.lines) offers an alternative way to do this.
--- 
--- ```lua
--- local file = fs.open("/rom/motd.txt", "r")
--- local lines = {}
--- while true do
---   local line = file.readLine()
---
---   -- If line is nil then we've reached the end of the file and should stop
---   if not line then break end
---
---   lines[#lines + 1] = line
--- end
---
--- file.close()
---
--- print(lines[math.random(#lines)]) -- Pick a random line and print it.
--- ```
--- 
--- Open a file and write some text to it. You can run `edit out.txt` to see the written text:
--- 
--- ```lua
--- local file = fs.open("out.txt", "w")
--- file.write("Just testing some code")
--- file.close() -- Remember to call close, otherwise changes may not be written!
--- ```
--- 
--- @param path string The path to the file to open.
--- @param mode "rb" The mode to open the file with.
--- @return fs.read_byte_handle
function fs.open(path, mode) end

--- Opens a file for reading or writing at a path.
--- 
--- Throws if an invalid mode was specified.
--- 
--- Read the contents of a file:
--- 
--- ```lua
--- local file = fs.open("/rom/help/intro.txt", "r")
--- local contents = file.readAll()
--- file.close()
---
--- print(contents)
--- ```
--- 
--- Open a file and read all lines into a table. [`io.lines`](lua://io.lines) offers an alternative way to do this.
--- 
--- ```lua
--- local file = fs.open("/rom/motd.txt", "r")
--- local lines = {}
--- while true do
---   local line = file.readLine()
---
---   -- If line is nil then we've reached the end of the file and should stop
---   if not line then break end
---
---   lines[#lines + 1] = line
--- end
---
--- file.close()
---
--- print(lines[math.random(#lines)]) -- Pick a random line and print it.
--- ```
--- 
--- Open a file and write some text to it. You can run `edit out.txt` to see the written text:
--- 
--- ```lua
--- local file = fs.open("out.txt", "w")
--- file.write("Just testing some code")
--- file.close() -- Remember to call close, otherwise changes may not be written!
--- ```
--- 
--- @param path string The path to the file to open.
--- @param mode "w" The mode to open the file with.
--- @return fs.write_handle
function fs.open(path, mode) end

--- Opens a file for reading or writing at a path.
--- 
--- Throws if an invalid mode was specified.
--- 
--- Read the contents of a file:
--- 
--- ```lua
--- local file = fs.open("/rom/help/intro.txt", "r")
--- local contents = file.readAll()
--- file.close()
---
--- print(contents)
--- ```
--- 
--- Open a file and read all lines into a table. [`io.lines`](lua://io.lines) offers an alternative way to do this.
--- 
--- ```lua
--- local file = fs.open("/rom/motd.txt", "r")
--- local lines = {}
--- while true do
---   local line = file.readLine()
---
---   -- If line is nil then we've reached the end of the file and should stop
---   if not line then break end
---
---   lines[#lines + 1] = line
--- end
---
--- file.close()
---
--- print(lines[math.random(#lines)]) -- Pick a random line and print it.
--- ```
--- 
--- Open a file and write some text to it. You can run `edit out.txt` to see the written text:
--- 
--- ```lua
--- local file = fs.open("out.txt", "w")
--- file.write("Just testing some code")
--- file.close() -- Remember to call close, otherwise changes may not be written!
--- ```
--- 
--- @param path string The path to the file to open.
--- @param mode "wb" The mode to open the file with.
--- @return fs.write_byte_handle
function fs.open(path, mode) end

--- Opens a file for reading or writing at a path.
--- 
--- Throws if an invalid mode was specified.
--- 
--- Read the contents of a file:
--- 
--- ```lua
--- local file = fs.open("/rom/help/intro.txt", "r")
--- local contents = file.readAll()
--- file.close()
---
--- print(contents)
--- ```
--- 
--- Open a file and read all lines into a table. [`io.lines`](lua://io.lines) offers an alternative way to do this.
--- 
--- ```lua
--- local file = fs.open("/rom/motd.txt", "r")
--- local lines = {}
--- while true do
---   local line = file.readLine()
---
---   -- If line is nil then we've reached the end of the file and should stop
---   if not line then break end
---
---   lines[#lines + 1] = line
--- end
---
--- file.close()
---
--- print(lines[math.random(#lines)]) -- Pick a random line and print it.
--- ```
--- 
--- Open a file and write some text to it. You can run `edit out.txt` to see the written text:
--- 
--- ```lua
--- local file = fs.open("out.txt", "w")
--- file.write("Just testing some code")
--- file.close() -- Remember to call close, otherwise changes may not be written!
--- ```
--- 
--- @param path string The path to the file to open.
--- @param mode "w+" | "r+" The mode to open the file with.
--- @return fs.read_write_handle
function fs.open(path, mode) end

--- Opens a file for reading or writing at a path.
--- 
--- Throws if an invalid mode was specified.
--- 
--- Read the contents of a file:
--- 
--- ```lua
--- local file = fs.open("/rom/help/intro.txt", "r")
--- local contents = file.readAll()
--- file.close()
---
--- print(contents)
--- ```
--- 
--- Open a file and read all lines into a table. [`io.lines`](lua://io.lines) offers an alternative way to do this.
--- 
--- ```lua
--- local file = fs.open("/rom/motd.txt", "r")
--- local lines = {}
--- while true do
---   local line = file.readLine()
---
---   -- If line is nil then we've reached the end of the file and should stop
---   if not line then break end
---
---   lines[#lines + 1] = line
--- end
---
--- file.close()
---
--- print(lines[math.random(#lines)]) -- Pick a random line and print it.
--- ```
--- 
--- Open a file and write some text to it. You can run `edit out.txt` to see the written text:
--- 
--- ```lua
--- local file = fs.open("out.txt", "w")
--- file.write("Just testing some code")
--- file.close() -- Remember to call close, otherwise changes may not be written!
--- ```
--- 
--- @param path string The path to the file to open.
--- @param mode "w+b" | "r+b" The mode to open the file with.
--- @return fs.read_write_byte_handle? # A file handle object for the file, or `nil` if the file does not exist, or cannot be opened.
--- @return string? # A message explaining why the file cannot be opened.
function fs.open(path, mode) end

--- Returns the name of the mount that the specified path is located on.
--- 
--- Throws if the path doesn't exist.
--- 
--- Print the drives of a couple of mounts:
--- 
--- ```lua
--- print("/: " .. fs.getDrive("/"))
--- print("/rom/: " .. fs.getDrive("rom"))
--- ```
--- 
--- @param path string The path to get the drive of.
--- @return string? # The name of the drive that the file is on; e.g. `hdd` for local files, or `rom` for ROM files.
function fs.getDrive(path) end

--- Returns the amount of free space available on the drive the path is located on.
--- 
--- Throws if the path doesn't exist.   
--- 
--- @see fs.getCapacity To get the capacity of this drive.
--- 
--- @param path string The path to check the free space for.
--- @return number | "unlimited" # The amount of free space available, in bytes, or `"unlimited"`.
function fs.getFreeSpace(path) end

--- Returns the capacity of the drive the path is located on.
--- 
--- Throws if the capacity cannot be determined.
--- 
--- @see fs.getFreeSpace To get the free space available on this drive.
--- 
--- @param path string The path of the drive to get.
--- @return number? # This drive's capacity. This will be `nil` for "read-only" drives, such as the ROM or treasure disks.
function fs.getCapacity(path) end

--- @class fs.attributes
--- @field size number The byte size of the file.
--- @field isDir boolean Whether the file is a directory.
--- @field isReadOnly boolean Whether the file is read only.
--- @field created number The UNIX timestamp on which the file was created.
--- @field modified number The UNIX timestamp on which the file was last modified.


--- Get attributes about a specific file or folder.
--- 
--- The returned attributes table contains information about the size of the file, whether it is a directory, 
--- when it was created and last modified, and whether it is read only.
--- 
--- The creation and modification times are given as the number of milliseconds since the UNIX epoch. 
--- This may be given to [`os.date`](lua://os.date) in order to convert it to more usable form.
--- 
--- Throws if the path does not exist.
--- 
--- @see fs.getSize
--- @see fs.isDir
--- 
--- @param path string The path to get attributes for.
--- @return fs.attributes The resulting attributes.
function fs.attributes(path) end