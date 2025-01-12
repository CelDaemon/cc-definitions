--- @meta _


--- Get and set redstone signals adjacent to this computer.
--- 
--- The [`redstone`](lua://redstone) library exposes three "types" of redstone control:
--- 
--- - Binary input/output ([`setOutput`](lua://redstone.setOutput)/[`getInput`](lua://redstone.getInput)): 
--- These simply check if a redstone wire has any input or output. 
--- A signal strength of 1 and 15 are treated the same.
--- - Analogue input/output ([`setAnalogOutput`](lua://redstone.setAnalogOutput)/[`getAnalogInput`](lua://redstone.getAnalogInput)): 
--- These work with the actual signal strength of the redstone wired, from 0 to 15.
--- - Bundled cables ([`setBundledOutput`](lua://redstone.setBundledOutput)/[`getBundledInput`](lua://redstone.getBundledInput)): 
--- These interact with "bundled" cables, such as those from Project:Red. 
--- These allow you to send 16 separate on/off signals. 
--- Each channel corresponds to a colour, with the first being [`colors.white`](lua://colors.white) and the last [`colors.black`](lua://colors.black).
--- 
--- Whenever a redstone input changes, a [`redstone`](lua://redstone) event will be fired. 
--- This may be used instead of repeativly polling.
--- 
--- This module may also be referred to as `rs`. 
--- For example, one may call `rs.getSides()` instead of [`getSides`](lua://redstone.getSides).
--- 
--- Toggle the redstone signal above the computer every 0.5 seconds:
--- 
--- ```lua
--- while true do
---   redstone.setOutput("top", not redstone.getOutput("top"))
---   sleep(0.5)
--- end
--- ```
--- 
--- Mimic a redstone comparator in [subtraction mode](https://minecraft.wiki/w/Redstone_Comparator#Subtract_signal_strength):
--- 
--- ```lua
--- while true do
---   local rear = rs.getAnalogueInput("back")
---   local sides = math.max(rs.getAnalogueInput("left"), rs.getAnalogueInput("right"))
---   rs.setAnalogueOutput("front", math.max(rear - sides, 0))
---
---   os.pullEvent("redstone") -- Wait for a change to inputs.
--- end
--- ```
--- 
--- @class redstonelib
redstone = {}

--- Returns a table containing the six sides of the computer. 
--- Namely, "top", "bottom", "left", "right", "front" and "back".
--- 
--- @nodiscard
--- @return peripheral.side[] # A table of valid sides.
function redstone.getSides() end

--- Turn the redstone signal of a specific side on or off.
--- 
--- @param side peripheral.side The side to set.
--- @param on boolean Whether the redstone signal should be on or off. When on, a signal strength of 15 is emitted.
function redstone.setOutput(side, on) end

--- Get the current redstone output of a specific side.
--- 
--- 
--- @see redstone.setOutput
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return boolean # Whether the redstone output is on or off.
function redstone.getOutput(side) end

--- Get the current redstone input of a specific side.
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return boolean # Whether the redstone input is on or off.
function redstone.getInput(side) end

--- Set the redstone signal strength for a specific side.
--- 
--- Throws if `value` is not between 0 and 15.
--- 
--- @param side peripheral.side The side to set.
--- @param value number The signal strength between 0 and 15.
function redstone.setAnalogOutput(side, value) end

--- Set the redstone signal strength for a specific side.
--- 
--- Throws if `value` is not between 0 and 15.
--- 
--- @param side peripheral.side The side to set.
--- @param value number The signal strength between 0 and 15.
function redstone.setAnalogueOutput(side, value) end

--- Get the redstone output signal strength for a specific side.
--- 
--- @see redstone.setAnalogOutput
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return number # The output signal strength, between 0 and 15.
function redstone.getAnalogOutput(side) end

--- Get the redstone output signal strength for a specific side.
--- 
--- @see redstone.setAnalogOutput
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return number # The output signal strength, between 0 and 15.
function redstone.getAnalogueOutput(side) end

--- Get the redstone input signal strength for a specific side.
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return number # The input signal strength, between 0 and 15.
function redstone.getAnalogInput(side) end

--- Get the redstone input signal strength for a specific side.
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return number # The input signal strength, between 0 and 15.
function redstone.getAnalogueInput(side) end

--- Set the bundled cable output for a specific side.
--- 
--- @see colors.subtract For removing a colour from the bitmask.
--- @see colors.combine For adding a color to the bitmask.
--- 
--- @param side peripheral.side The side to set.
--- @param output number The colour bitmask to set.
function redstone.setBundledOutput(side, output) end

--- Get the bundled cable output for a specific side.
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return number # The bundle cable's output.
function redstone.getBundledOutput(side) end

--- Get the bundled cable input for a specific side.
--- 
--- @see redstone.testBundledInput To determine if a specific colour is set.
--- 
--- @nodiscard
--- @param side peripheral.side The side to get.
--- @return number # The bundle cable's input.
function redstone.getBundledInput(side) end

--- Determine if a specific combination of colours are on for the given side.
--- 
--- Check if [`colors.white`](lua://colors.white) and [`colors.black`](lua://colors.black) are on above this block:
--- 
--- ```lua
--- print(redstone.testBundledInput("top", colors.combine(colors.white, colors.black)))
--- ```
--- 
--- @see redstone.getBundledInput
--- 
--- @param side peripheral.side The side to test.
--- @param mask number The mask to test.
--- @return boolean # If the colours are on.
function redstone.testBundledInput(side, mask) end