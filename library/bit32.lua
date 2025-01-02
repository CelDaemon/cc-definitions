--- @meta bit32


--- @class bit32lib
bit32 = {}

--- Returns the number `x` shifted `disp` bits to the right. Negative displacements shift to the left.
--- 
--- This shift operation is what is called arithmetic shift. 
--- Vacant bits on the left are filled with copies of the higher bit of `x`; vacant bits on the right are filled with zeros.
--- 
--- @nodiscard
--- @param x number The number to shift.
--- @param disp number The amount to shift by.
--- @return number # The shifted number.
function bit32.arshift(x, disp) end

--- Returns the bitwise *and* of its operands.
--- 
--- @nodiscard
--- @param ... number The numbers to apply the bitwise `and` to.
--- @return number # The operator output.
function bit32.band(...) end

--- Returns the bitwise negation of `x`.
--- 
---     assert(bit32.bnot(x) == (-1 - x) % 2^32)
--- 
--- @nodiscard
--- @param x number The number to negate.
--- @return number # The negated number.
function bit32.bnot(x) end


--- Returns the bitwise *or* of its operands.
--- 
--- @nodiscard
--- @param ... number The numbers to apply the bitwise `or` to.
--- @return number # The operator output.
function bit32.bor(...) end

--- Returns a boolean signaling whether the bitwise *and* of its operands is different from zero.
--- 
--- @nodiscard
--- @param ... number The number to apply the test to.
--- @return boolean # The output of the test.
function bit32.btest(...) end


--- Returns the bitwise *exclusive or* of its operands.
--- 
--- @nodiscard
--- @param ... number The number to apply the bitwise `xor` to
--- @return number # The operator output.
function bit32.bxor(...) end


--- Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.
--- 
--- @nodiscard
--- @param n number The number to get the bits from.
--- @param field number The index of the field.
--- @param width number The width of the field.
--- @return number # THe extracted number.
function bit32.extract(n, field, width) end


--- Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v` .
--- 
--- @nodiscard
--- @param n number The number to set bits in.
--- @param v number The new bit value.
--- @param field number The index of the field.
--- @param width number The width of the field.
--- @return number # The modfied number.
function bit32.replace(n, v, field, width) end


--- Returns the number `x` rotated `disp` bits to the left. Negative displacements rotate to the right.
--- 
--- @nodiscard
--- @param x number The number to rotate.
--- @param distp number The number of bits to rotate by.
--- @return number # The rotated number.
function bit32.lrotate(x, distp) end

--- Returns the number `x` shifted `disp` bits to the left. 
--- Negative displacements shift to the right. In any direction, vacant bits are filled with zeros.
--- 
---     assert(bit32.lshift(b, disp) == (b * 2^disp) % 2^32)
--- 
--- @param x number The number to shift.
--- @param distp number The number of bits to shift by.
--- @return number # The shifted number.
function bit32.lshift(x, distp) end


--- Returns the number `x` rotated `disp` bits to the right. Negative displacements rotate to the left.
--- 
--- @nodiscard
--- @param x number The number to rotate.
--- @param distp number The number of bits to rotate by.
--- @return number # The rotated number.
function bit32.rrotate(x, distp) end

--- Returns the number `x` shifted `disp` bits to the right. 
--- Negative displacements shift to the left. In any direction, vacant bits are filled with zeros.
--- 
---     assert(bit32.rshift(b, disp) == math.floor(b % 2^32 / 2^disp))
--- 
--- @param x number The number to shift.
--- @param distp number The number of bits to shift by.
--- @return number # The shifted number.
function bit32.rshift(x, distp) end

return bit32