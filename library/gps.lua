--- @meta _

--- Use [`modems`](lua://peripheral.modems) to locate the position of the current turtle or computers.
--- 
--- It broadcasts a PING message over [`rednet`](lua://rednet) and wait for responses. 
--- In order for this system to work, there must be at least 4 computers used as gps hosts which will respond and allow trilateration. 
--- Three of these hosts should be in a plane, and the fourth should be either above or below the other three. 
--- The three in a plane should not be in a line with each other. You can set up hosts using the gps program.
--- 
--- > Note:
--- > When entering in the coordinates for the host you need to put in the `x`, `y`, and `z` coordinates of the block that the modem is connected to, not the modem. 
--- > All modem distances are measured from the block that the modem is placed on.
--- 
--- Also note that you may choose which axes x, y, or z refers to - so long as your systems have the same definition as any GPS servers that're in range, it works just the same. 
--- For example, you might build a GPS cluster according to [this tutorial](https://ccf.squiddev.cc/forums2/index.php?/topic/3088-how-to-guide-gps-global-position-system/), using z to account for height, or you might use y to account for height in the way that Minecraft's debug screen displays.
--- 
--- See [`Setting up GPS`](https://tweaked.cc/guide/gps_setup.html) for more detailed instructions on setting up GPS.
--- 
--- @class gps
gps = {}

gps.CHANNEL_GPS = 65534

--- Tries to retrieve the computer or turtles own location.
--- 
--- @param timeout number The maximum time in seconds taken to establish our position, the default is `2`.
--- @param debug number Print debugging messages, the default is `false`.
--- @return number? # This computer's `x` position.
--- @return number? # This computer's `y` position.
--- @return number? # This computer's `z` position.
function gps.locate(timeout, debug) end