--- @meta math

--- @class mathlib
--- A value larger than any other numeric value.
--- @field huge number
--- The value of *π*.
--- @field pi number
math = {}

--- Returns the absolute value of `x`.
--- 
--- @nodiscard
--- @param x number The number to return the absolute value of.
--- @return number # The absolute value of the number.
function math.abs(x) end

--- Returns the arc cosine of `x` (in radians).
--- 
--- @nodiscard
--- @param x number The number to use for the cosine.
--- @return number # The calculated cosine.
function math.acos(x) end

--- Returns the arc sine of `x` (in radians).
--- 
--- @nodiscard
--- @param x number The number to use for the sine.
--- @return number # The calculated sine.
function math.asin(x) end

--- Returns the arc tangent of `y/x` (in radians).
--- 
--- @nodiscard
--- @param y number The y argument to use for the tangent.
--- @param x number? The x argument to use for the tangent.
--- @return number # The calculated tangent.
function math.atan(y, x) end


--- Returns the arc tangent of `y/x` (in radians).
--- 
--- @deprecated Use math.atan instead.
--- @nodiscard
--- @param y number The y argument to use for the tangent.
--- @param x number? The x argument to use for the tangent.
--- @return number # The calculated tangent.
function math.atan2(y, x) end

--- Returns the smallest integral value larger than or equal to `x`.
--- 
--- @nodiscard
--- @param x number The number to round.
--- @return number # The rounded number.
function math.ceil(x) end

--- Returns the cosine of `x` (assumed to be in radians).
--- 
--- @nodiscard
--- @param x number The number to use for the cosine.
--- @return number # The calculated cosine.
function math.cos(x) end

--- Returns the hyperbolic cosine of `x` (assumed to be in radians).
--- 
--- @nodiscard
--- @param x number The number to use for the cosine.
--- @return number # The calculated cosine.
function math.cosh(x) end

--- Converts the angle `x` from radians to degrees.
--- 
--- @nodiscard
--- @param x number The number to convert to degrees.
--- @return number # The number converted to degrees.
function math.deg(x) end

--- Returns the value `e^x` (where `e` is the base of natural logarithms).
--- 
--- @nodiscard
--- @param x number The number to use for the exponent.
--- @return number # The value of the exponent.
function math.exp(x) end


--- Returns the largest integral value smaller than or equal to `x`.
--- 
--- @nodiscard
--- @param x number The number to round.
--- @return number # The rounded number.    
function math.floor(x) end

--- Returns the remainder of the division of `x` by `y` that rounds the quotient towards zero.
--- 
--- @nodiscard
--- @param x number The number to divide.
--- @param y number The number to divide by.
--- @return number # The output of the modulos.
function math.fmod(x, y) end

--- Decompose `x` into tails and exponents. 
--- Returns `m` and `e` such that `x = m * (2 ^ e)`, `e` is an integer and the absolute value of `m` is in the range [0.5, 1) (or zero when `x` is zero).
--- 
--- @nodiscard
--- @param x number The number to decompose.
--- @return number m The extracted tails.
--- @return number e The extracted exponents.
function math.frexp(x) end

--- Returns `m * (2 ^ e)` .
--- 
--- @nodiscard
--- @param m number The tail for the final number.
--- @param e number The exponents for the final number.
--- @return number # The final combined number.
function math.ldexp(m, e) end

--- Returns the logarithm of `x` in the given base.
--- 
--- @nodiscard
--- @param x number The value to use for the logarithm.
--- @param base number The base to use for the logarithm.
--- @return number # The calculated logarithm.
function math.log(x, base) end

--- Returns the base-10 logarithm of x.
--- 
--- @deprecated Use math.log instead.
--- 
--- @nodiscard
--- @param x number The value to use for the logarithm.
--- @return number # The calculated logarithm.
function math.log10(x) end


--- Returns the argument with the maximum value, according to the Lua operator `<`.
--- 
--- @nodiscard
--- @param ... number The arguments to find the maximum number of.
--- @return number # The maximum value among the provided arguments.
function math.max(...) end

--- Returns the argument with the minimum value, according to the Lua operator `<`.
--- @nodiscard
--- @param ... number The arguments to find the minimum number of.
--- @return number # The minimum value among the provided arguments.
function math.min(...) end

--- Returns the integral part of `x` and the fractional part of `x`.
--- 
--- @nodiscard
--- @param x number The number to divide.
--- @return number integer The integral part of the value.
--- @return number fraction The fractional part of the value.
function math.modf(x) end

--- Returns `x ^ y` .
--- 
--- @nodiscard
--- @param x number The base for the power.
--- @param y number The exponent for the power.
--- @return number # The calculated power.
function math.pow(x, y) end

--- Converts the angle `x` from degrees to radians.
--- 
--- @nodiscard
--- @param x number The degrees to convert.
--- @return number # The converted radians.
function math.rad(x) end

--- Returns a float in the range [0,1).
--- 
--- @nodiscard
--- @return number # The generated number.
function math.random() end

--- Returns a integer in the range [1, m].
--- 
--- @nodiscard
--- @param m number The maxmimum number that can be generated.
--- @return number # The generated number.
function math.random(m) end

--- Returns a integer in the range [m, n].
--- 
--- @nodiscard
--- @param m number The minimum number that can be generated.
--- @param n number The maxmimum number that can be generated.
--- @return number # The generated number.
function math.random(m, n) end