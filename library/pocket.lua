--- @meta _

--- Control the current pocket computer, adding or removing upgrades.
--- 
--- This API is only available on pocket computers. As such, you may use its presence to determine what kind of computer you are using:
--- @class pocket
pocket = {}

--- Search the player's inventory for another upgrade, replacing the existing one with that item if found.
--- 
--- This inventory search starts from the player's currently selected slot, allowing you to prioritise upgrades.
--- 
--- @nodiscard
--- @return boolean # If an item was equipped.
--- @return string? # The reason an item was not equipped.
function pocket.equipBack() end

--- Remove the pocket computer's current upgrade.
--- 
--- @nodiscard
--- @return boolean # If the upgrade was unequipped.
--- @return string # The reason an upgrade was not unequipped.
function pocket.unequipBack() end