--- @meta _


--- Execute [Minecraft commands](https://minecraft.wiki/w/Commands) and gather data from the results from a command computer.
--- 
--- > Note:
--- > This API is only available on Command computers. It is not accessible to normal players.
--- 
--- While one may use [`commands.exec`](lua://commands.native.exec) directly to execute a command, the commands API also provides helper methods to execute every command. 
--- For instance, `commands.say("Hi!")` is equivalent to `commands.exec("say Hi!")`.
--- 
--- [`commands.async`](lua://commands.async) provides a similar interface to execute asynchronous commands. `commands.async.say("Hi!")` is equivalent to `commands.execAsync("say Hi!")`.
--- 
--- Set the block above this computer to stone:
--- 
--- ```lua
--- commands.setblock("~", "~1", "~", "minecraft:stone")
--- ```
--- 
--- @class commands: commands.native
--- The builtin commands API, without any generated command helper functions.
--- 
--- This may be useful if a built-in function (such as [`commands.list`](lua://commands.native.list)) has been overwritten by a command.
--- @field native commands.native
--- A table containing asynchronous wrappers for all commands.
--- 
--- As with [`commands.execAsync`](lua://commands.native.execAsync), this returns the "task id" of the enqueued command.
--- 
--- Asynchronously sets the block above the computer to stone:
--- 
--- ```lua
--- commands.async.setblock("~", "~1", "~", "minecraft:stone")
--- ```
--- 
--- @see commands.native.execAsync
--- @field async table
commands = {}


--- The builtin commands API, without any generated command helper functions.
--- This may be useful if a built-in function (such as [`commands.list`](lua://commands.list)) has been overwritten by a command.
--- 
--- @class commands.native
local native = {}

--- Execute a specific command.
--- 
--- Set the block above the command computer to stone:
--- 
--- ```lua
--- commands.exec("setblock ~ ~1 ~ minecraft:stone")
--- ```
--- 
--- @param command string The command to execute.
--- @return boolean # Whether the command executed successfully.
--- @return string[] # The output of this command, as a list of lines.
--- @return number? # The number of "affected" objects, or `nil` if the command failed. The definition of this varies from command to command.
function native.exec(command) end

--- Asynchronously execute a command.
--- 
--- Unlike [`exec`](lua://commands.exec), this will immediately return, instead of waiting for the command to execute. 
--- This allows you to run multiple commands at the same time.
--- 
--- When this command has finished executing, it will queue a `task_complete` event containing the result of executing this command (what [`exec`](lua://commands.exec) would return).
--- 
--- Asynchronously sets the block above the computer to stone:
--- 
--- ```lua
--- commands.execAsync("setblock ~ ~1 ~ minecraft:stone")
--- ```
--- 
--- @see parallel One may also use the parallel API to run multiple commands at once.
--- 
--- @param command string The command to execute.
--- @return number # The "task id". When this command has been executed, it will queue a task_complete event with a matching id.
function native.execAsync(command) end

--- List all available commands which the computer has permission to execute.
--- 
--- @nodiscard
--- @param ... string The sub-command to complete.
--- @return string[] # A list of all available commands.
function native.list(...) end

--- Get the position of the current command computer.
--- 
--- @see gps.locate To get the position of a non-command computer.
--- 
--- @nodiscard
--- @return number # This computer's x position.
--- @return number # This computer's y position.
--- @return number # This computer's z position.
function native.getBlockPosition() end

--- Get information about a range of blocks.
--- 
--- This returns the same information as [`getBlockInfo`](lua://commands.getBlockInfo), just for multiple blocks at once.
--- 
--- Blocks are traversed by ascending y level, followed by z and x - the returned table may be indexed using `x + z*width + y*width*depth + 1`.
--- 
--- Throws if the coordinates are not within the world, or if trying to get information about more than 4096 blocks.
--- 
--- Print out all blocks in a cube around the computer:
--- 
--- ```lua
--- -- Get a 3x3x3 cube around the computer
--- local x, y, z = commands.getBlockPosition()
--- local min_x, min_y, min_z, max_x, max_y, max_z = x - 1, y - 1, z - 1, x + 1, y + 1, z + 1
--- local blocks = commands.getBlockInfos(min_x, min_y, min_z, max_x, max_y, max_z)
---
--- -- Then loop over all blocks and print them out.
--- local width, height, depth = max_x - min_x + 1, max_y - min_y + 1, max_z - min_z + 1
--- for x = min_x, max_x do
---   for y = min_y, max_y do
---     for z = min_z, max_z do
---       print(("%d, %d %d => %s"):format(x, y, z, blocks[(x - min_x) + (z - min_z) * width + (y - min_y) * width * depth + 1].name))
---     end
---   end
--- end
--- ```
--- 
--- @nodiscard
--- @param minX number The start x coordinate of the range to query.
--- @param minY number The start y coordinate of the range to query.
--- @param minZ number The start z coordinate of the range to query.
--- @param maxX number The end x coordinate of the range to query.
--- @param maxY number The end y coordinate of the range to query.
--- @param maxZ number The end z coordinate of the range to query.
--- @param dimension string? The dimension to query (e.g. "minecraft:overworld"). Defaults to the current dimension.
--- @return table[] # A list of information about each block.
function native.getBlockInfos(minX, minY, minZ, maxX, maxY, maxZ, dimension) end

--- Get some basic information about a block.
--- 
--- The returned table contains the current name, metadata and block state (as with [`turtle.inspect`](lua://turtle.inspect)). 
--- If there is a block entity for that block, its NBT will also be returned.
--- 
--- Throws if the coordinates are not within the world, or are not currently loaded.
--- 
--- @nodiscard
--- @param x number The x position of the block to query.
--- @param y number The y position of the block to query.
--- @param z number The z position of the block to query.
--- @param dimension string? The dimension to query (e.g. "minecraft:overworld"). Defaults to the current dimension.
--- @return table # The given block's information.
function native.getBlockInfo(x, y, z, dimension) end