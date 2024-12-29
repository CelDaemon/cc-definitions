--- @meta disk

--- Interact with disk drives.
--- 
--- These functions can operate on locally attached or remote disk drives. 
--- To use a locally attached drive, specify “side” as one of the six sides (e.g. `left`); 
--- to use a remote disk drive, specify its name as printed when enabling its modem (e.g. `drive_0`).
--- 
--- > Tip:
--- > All computers (except command computers), turtles and pocket computers 
--- > can be placed within a disk drive to access it's internal storage like a disk.
disk = {}

--- Checks whether any item at all is in the disk drive.
--- 
---     disk.isPresent("top")
--- 
--- @nodiscard
--- @param name string The name of the disk drive.
--- @return boolean # If something is in the disk drive.
function disk.isPresent(name) end