--- @meta _


--- Turtles are a robotic device, which can break and place blocks, attack mobs, and move about the world. 
--- They have an internal inventory of 16 slots, allowing them to store blocks they have broken or would like to place.
--- 
--- ## Movement
--- 
--- Turtles are capable of moving through the world. As turtles are blocks themselves, they are confined to Minecraft's
--- grid, moving a single block at a time.
--- 
--- [`turtle.forward`](lua://turtle.forward) and [`turtle.back`](lua://turtle.back) move the turtle in the direction it is facing, while [`turtle.up`](lua://turtle.up) and
--- [`turtle.down`](lua://turtle.down) move it up and down (as one might expect!). In order to move left or right, you first need
--- to turn the turtle using [`turtle.turnLeft`](lua://turtle.turnLeft)/[`turtle.turnRight`](lua://turtle.turnRight) and then move forward or backwards.
--- 
--- > Info:
--- > The name "turtle" comes from [Turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics), which originated from the Logo programming language. Here you'd
--- > move a turtle with various commands like "move 10" and "turn left", much like ComputerCraft's turtles!
--- 
--- Moving a turtle (though not turning it) consumes *fuel*. If a turtle does not have any [fuel](lua://turtle.refuel), it
--- won't move, and the movement functions will return `false`. If your turtle isn't going anywhere, the first thing to
--- check is if you've fuelled your turtle.
--- 
--- > Tip: Handling errors
--- > Many turtle functions can fail in various ways. For instance, a turtle cannot move forward if there's already a
--- > block there. Instead of erroring, functions which can fail either return `true` if they succeed, or `false` and
--- > some error message if they fail.
--- >
--- > Unexpected failures can often lead to strange behaviour. It's often a good idea to check the return values of these
--- > functions, or wrap them in [`assert`](lua://assert) (for instance, use `assert(turtle.forward())` rather than `turtle.forward()`),
--- > so the program doesn't misbehave.
--- 
--- ## Turtle upgrades
--- 
--- While a normal turtle can move about the world and place blocks, its functionality is limited. Thankfully, turtles
--- can be upgraded with upgrades. Turtles have two upgrade slots, one on the left and right sides. Upgrades can be
--- equipped by crafting a turtle with the upgrade, or calling the [`turtle.equipLeft`](lua://turtle.equipLeft)/[`turtle.equipRight`](lua://turtle.equipRight) functions.
--- 
--- By default, any diamond tool may be used as an upgrade (though more may be added with [datapacks](https://datapacks.madefor.cc)). The diamond
--- pickaxe may be used to break blocks (with [`turtle.dig`](lua://turtle.dig)), while the sword can attack entities ([`turtle.attack`](lua://turtle.attach)).
--- Other tools have more niche use-cases, for instance hoes can til dirt.
--- 
--- Some peripherals (namely [speakers](lua://speaker) and Ender and Wireless [modems](lua://modem)) can also be equipped as
--- upgrades. These are then accessible by accessing the `"left"` or `"right"` peripheral.
--- 
--- @class turtle
turtle = {}

--- Craft a recipe based on the turtle's inventory.
--- The turtle's inventory should set up like a crafting grid. For instance, to
--- craft sticks, slots 1 and 5 should contain planks. _All_ other slots should be
--- empty, including those outside the crafting "grid".
---
--- Throws when limit is less than 1 or greater than 64.
---
--- @nodiscard
--- @param limit number? The maximum number of crafting steps to run. The default is 64.
--- @return boolean # Whether the crafting succeeded.
--- @return string? # A string describing why crafting failed.
function turtle.craft(limit) end

--- Move the turtle forward one block.
---
--- @nodiscard
--- @return boolean # Whether the turtle could successfully move.
--- @return string? # The reason the turtle could not move.
function turtle.forward() end

--- Move the turtle backwards one block.
---
--- @nodiscard
--- @return boolean # Whether the turtle could successfully move.
--- @return string? # The reason the turtle could not move.
function turtle.back() end

--- Move the turtle up one block.
---
--- @nodiscard
--- @return boolean # Whether the turtle could successfully move.
--- @return string? # The reason the turtle could not move.
function turtle.up() end

--- Move the turtle down one block.
---
--- @nodiscard
--- @return boolean # Whether the turtle could successfully move.
--- @return string? # The reason the turtle could not move.
function turtle.down() end

--- Rotate the turtle 90 degrees to the left.
---
--- @nodiscard
--- @return boolean # Whether the turtle could successfully turn.
--- @return string? # The reason the turtle could not turn.
function turtle.turnLeft() end

--- Rotate the turtle 90 degrees to the right.
---
--- @nodiscard
--- @return boolean # Whether the turtle could successfully turn.
--- @return string? # The reason the turtle could not turn.
function turtle.turnRight() end

--- Attempt to break the block in front of the turtle.
--- This requires a turtle tool capable of breaking the block. Diamond pickaxes (mining turtles) can break any vanilla block, but other tools (such as axes) are more limited.
---
--- @nodiscard
--- @param side "left" | "right"? The specific tool to use.
--- @return boolean # Whether a block was broken.
--- @return string? # The reason no block was broken.
function turtle.dig(side) end

--- Attempt to break the block above the turtle. See [`dig`](lua://turtle.dig) for full details.
---
--- @nodiscard
--- @param side "left" | "right"? The specific tool to use.
--- @return boolean # Whether a block was broken.
--- @return string? # The reason no block was broken.
function turtle.digUp(side) end

--- Attempt to break the block below the turtle. See [`dig`](lua://turtle.dig) for full details.
---
--- @nodiscard
--- @param side "left" | "right"? The specific tool to use.
--- @return boolean # Whether a block was broken.
--- @return string? # The reason no block was broken.
function turtle.digDown(side) end

--- Place a block or item into the world in front of the turtle.
---
--- "Placing" an item allows it to interact with blocks and entities in front of the turtle.
--- For instance, buckets can pick up and place down fluids, and wheat can be used to breed cows.
--- However, you cannot use [`place`](lua://turtle.place) to perform arbitrary block interactions,
--- such as clicking buttons or flipping levers.
---
--- @nodiscard
--- @param text string? When placing a sign, set its contents to this text.
--- @return boolean # Whether the block could be placed.
--- @return string? # The reason the block was not placed.
function turtle.place(text) end

--- Place a block or item into the world above the turtle.
---
--- @see turtle.place For more information about placing items.
---
--- @nodiscard
--- @param text string? When placing a sign, set its contents to this text.
--- @return boolean # Whether the block could be placed.
--- @return string? # The reason the block was not placed.
function turtle.placeUp(text) end

--- Place a block or item into the world below the turtle.
---
--- @see turtle.place For more information about placing items.
---
--- @nodiscard
--- @param text string? When placing a sign, set its contents to this text.
--- @return boolean # Whether the block could be placed.
--- @return string? # The reason the block was not placed.
function turtle.placeDown(text) end

--- Drop the currently selected stack into the inventory in front of the turtle, or as an item into the world if there is no inventory.
---
--- Throws if dropping an invalid number of items.
---
--- @see turtle.select
---
--- @nodiscard
--- @param count number? The number of items to drop. If not given, the entire stack will be dropped.
--- @return boolean # Whether items were dropped.
--- @return string? # The reason the no items were dropped.
---
function turtle.drop(count) end

--- Drop the currently selected stack into the inventory above the turtle, or as an item into the world if there is no inventory.
---
--- Throws if dropping an invalid number of items.
---
--- @see turtle.select
---
--- @nodiscard
--- @param count number? The number of items to drop. If not given, the entire stack will be dropped.
--- @return boolean # Whether items were dropped.
--- @return string? # The reason the no items were dropped.
function turtle.dropUp(count) end

--- Drop the currently selected stack into the inventory below the turtle, or as an item into the world if there is no inventory.
---
--- Throws if dropping an invalid number of items.
---
--- @see turtle.select
---
--- @nodiscard
--- @param count number? The number of items to drop. If not given, the entire stack will be dropped.
--- @return boolean # Whether items were dropped.
--- @return string? # The reason the no items were dropped.
function turtle.dropDown(count) end

--- Change the currently selected slot.
---
--- The selected slot is determines what slot actions like [`drop`](lua://turtle.drop) or [`getItemCount`](lua://turtle.getItemCount) act on.
---
--- Throws if the slot is out of range.
---
--- @see turtle.getSelectedSlot
---
--- @nodiscard
--- @param slot number The slot to select.
--- @return boolean # Whether the slot has been selected.
function turtle.select(slot) end

--- Get the number of items in the given slot.
---
--- Throws if the slot is out of range.
---
--- @nodiscard
--- @param slot number? The slot we wish to check. Defaults to the [selected slot](lua://turtle.select).
--- @returns number # The number of items in this slot.
function turtle.getItemCount(slot) end

--- Get the remaining number of items which may be stored in this stack.
---
--- For instance, if a slot contains 13 blocks of dirt, it has room for another 51.
---
--- Throws if the slot is out of range.
---
--- @nodiscard
--- @param slot number? The slot we wish to check. Defaults to the [selected slot](lua://turtle.select).
function turtle.getItemSpace(slot) end

--- Check if there is a solid block in front of the turtle. In this case, solid refers to any non-air or liquid block.
--- 
--- @nodiscard
--- @return boolean # If there is a solid block in front.
function turtle.detect() end


--- Check if there is a solid block above the turtle. In this case, solid refers to any non-air or liquid block.
--- 
--- @nodiscard
--- @return boolean # If there is a solid block above.
function turtle.detectUp() end

--- Check if there is a solid block below the turtle. In this case, solid refers to any non-air or liquid block.
--- 
--- @nodiscard
--- @return boolean # If there is a solid block below.
function turtle.detectDown() end

--- Check if the block in front of the turtle is equal to the item in the currently selected slot.
--- 
--- @nodiscard
--- @return boolean # If the block and item are equal.
function turtle.compare() end

--- Check if the block above the turtle is equal to the item in the currently selected slot.
--- 
--- @nodiscard
--- @return boolean # If the block and item are equal.
function turtle.compareUp() end

--- Check if the block below the turtle is equal to the item in the currently selected slot.
--- 
--- @nodiscard
--- @return boolean # If the block and item are equal.
function turtle.compareDown() end

--- Attack the entity in front of the turtle.
--- 
--- @nodiscard
--- @param side "left" | "right"? The specific tool to use.
--- @return boolean # Whether an entity was attacked.
--- @return string? # The reason nothing was attacked.
function turtle.attack(side) end

--- Attack the entity above the turtle.
--- 
--- @nodiscard
--- @param side "left" | "right"? The specific tool to use.
--- @return boolean # Whether an entity was attacked.
--- @return string? # The reason nothing was attacked.
function turtle.attachUp(side) end

--- Attack the entity below the turtle.
--- 
--- @nodiscard
--- @param side "left" | "right"? The specific tool to use.
--- @return boolean # Whether an entity was attacked.
--- @return string? # The reason nothing was attacked.
function turtle.attachDown(side) end

--- Suck an item from the inventory in front of the turtle, or from an item floating in the world.
--- 
--- This will pull items into the first acceptable slot, starting at the [currently selected](lua://turtle.select) one.
--- 
--- Throws if given an invalid number of items.
--- 
--- @nodiscard
--- @param count number? The number of items to suck. If not given, up to a stack of items will be picked up.
--- @return boolean # Whether items were picked up.
--- @return string? # The reason the no items were picked up.
function turtle.suck(count) end

--- Suck an item from the inventory above the turtle, or from an item floating in the world.
--- 
--- Throws if given an invalid number of items.
--- 
--- @nodiscard
--- @param count number? The number of items to suck. If not given, up to a stack of items will be picked up.
--- @return boolean # Whether items were picked up.
--- @return string? # The reason the no items were picked up.
function turtle.suckUp(count) end


--- Suck an item from the inventory below the turtle, or from an item floating in the world.
--- 
--- Throws if given an invalid number of items.
--- 
--- @nodiscard
--- @param count number? The number of items to suck. If not given, up to a stack of items will be picked up.
--- @return boolean # Whether items were picked up.
--- @return string? # The reason the no items were picked up.
function turtle.suckDown(count) end

--- Get the maximum amount of fuel this turtle currently holds.
--- 
--- @see turtle.getFuelLimit
--- @see turtle.refuel
--- 
--- @nodiscard
--- @return number | "unlimited" # The current amount of fuel a turtle this turtle has, or "unlimited" if turtles do not consume fuel when moving.
function turtle.getFuelLevel() end

--- Refuel this turtle.
--- 
--- While most actions a turtle can perform (such as digging or placing blocks) are free, moving consumes fuel from the turtle's internal buffer. If a turtle has no fuel, it will not move.
--- 
--- [`refuel`](lua://turtle.refuel) refuels the turtle, consuming fuel items (such as coal or lava buckets) from the currently selected slot and converting them into energy. This finishes once the turtle is fully refuelled or all items have been consumed.
--- 
--- Throws if the refuel count is out of range.
--- 
--- Refuel a turtle from the currently selected slot:
--- 
--- ```lua
--- local level = turtle.getFuelLevel()
--- if level == "unlimited" then error("Turtle does not need fuel", 0) end
---
--- local ok, err = turtle.refuel()
--- if ok then
---     local new_level = turtle.getFuelLevel()
---     print(("Refuelled %d, current level is %d"):format(new_level - level, new_level))
--- else
---     printError(err)
--- end
--- ```
--- 
--- Check if the current item is a valid fuel source:
--- 
--- ```lua
--- local is_fuel, reason = turtle.refuel(0)
--- if not is_fuel then printError(reason) end
--- ```
--- 
--- @see turtle.getFuelLevel 
--- @see turtle.getFuelLimit
--- 
--- @nodiscard
--- @param count number? The maximum number of items to consume. One can pass `0` to check if an item is combustable or not.
--- @return boolean # Whether the turtle was refuelled.
--- @return string? # The reason the turtle was not refuelled.
function turtle.refuel(count) end

--- Compare the item in the currently selected slot to the item in another slot.
--- 
--- Throws if the slot is out of range.
--- 
--- @nodiscard
--- @param slot number The slot to compare to.
--- @return boolean # If the two items are equal.
function turtle.compareTo(slot) end



--- Move an item from the selected slot to another one.
--- 
--- Throws If the slot, or the number of items is out of range.
--- 
--- @nodiscard
--- @param slot number The slot to move this item to.
--- @param count number? The maximum number of items to move.
--- @return boolean # If some items were successfully moved.
function turtle.transferTo(slot, count) end


--- Get the currently selected slot.
--- 
--- @see turtle.select
--- 
--- @nodiscard
--- @return number # The current slot.
function turtle.getSelectedSlot() end

--- Get the maximum amount of fuel this turtle can hold.
--- 
--- By default, normal turtles have a limit of 20,000 and advanced turtles of 100,000.
--- 
--- @see turtle.getFuelLevel
--- @see turtle.refuel
--- 
--- @nodiscard
--- @return number | "unlimited" # The maximum amount of fuel a turtle can hold, or "unlimited" if turtles do not consume fuel when moving.
function turtle.getFuelLimit() end

--- Equip (or unequip) an item on the left side of this turtle.
--- 
--- This finds the item in the currently selected slot and attempts to equip it to the left side of the turtle. 
--- The previous upgrade is removed and placed into the turtle's inventory. 
--- If there is no item in the slot, the previous upgrade is removed, but no new one is equipped.
--- 
--- @see turtle.equipRight
--- 
--- @nodiscard
--- @return boolean # Whether the item was equipped.
--- @return string? # The reason equipping this item failed.
function turtle.equipLeft() end


--- Equip (or unequip) an item on the right side of this turtle.
--- 
--- This finds the item in the currently selected slot and attempts to equip it to the right side of the turtle. 
--- The previous upgrade is removed and placed into the turtle's inventory. 
--- If there is no item in the slot, the previous upgrade is removed, but no new one is equipped.
--- 
--- @see turtle.equipLeft
--- 
--- @nodiscard
--- @return boolean # Whether the item was equipped.
--- @return string? # The reason equipping this item failed.
function turtle.equipRight() end


--- Get information about the block in front of the turtle.
--- 
--- ```lua
--- local has_block, data = turtle.inspect()
--- if has_block then
---     print(textutils.serialise(data))
---     -- {
---     --   name = "minecraft:oak_log",
---     --   state = { axis = "x" },
---     --   tags = { ["minecraft:logs"] = true, ... },
---     -- }
--- else
---     print("No block in front of the turtle")
--- end
--- ```
--- 
--- @nodiscard
--- @return boolean # Whether there is a block in front of the turtle.
--- @return table | string # Information about the block in front, or a message explaining that there is no block.
function turtle.inspect() end


--- Get information about the block above the turtle.
--- 
--- @nodiscard
--- @return boolean # Whether there is a block above the turtle.
--- @return table | string # Information about the block above, or a message explaining that there is no block.
function turtle.inspectUp() end


--- Get information about the block below the turtle.
--- 
--- @nodiscard
--- @return boolean # Whether there is a block below the turtle.
--- @return table | string # Information about the block below, or a message explaining that there is no block.
function turtle.inspectDown() end


--- Get detailed information about the items in the given slot.
--- 
--- Throws if the slot is out of range.
--- 
--- Print the current slot, assuming it contains 13 dirt:
--- 
--- ```lua
--- print(textutils.serialise(turtle.getItemDetail()))
--- -- => {
--- --  name = "minecraft:dirt",
--- --  count = 13,
--- -- }
--- ```
--- 
--- Throws if the slot is out of range.
--- 
--- @see inventory.getItemDetail
--- 
--- @nodiscard
--- @param slot number? The slot to get information about. Defaults to the [selected slot](lua://turtle.select).
--- @param detailed boolean? Whether to include "detailed" information. When true the method will contain much more information about the item at the cost of taking longer to run.
--- @return table? # Information about the given slot, or nil if it is empty.
function turtle.getItemDetail(slot, detailed) end