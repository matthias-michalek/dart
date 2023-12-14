# Transformation between cartesian/polar coordinates.

"""
    polar(x::Number, y::Number)

Convert ``(x, y) → (r, φ)``.
"""
@inline function polar(x::Number, y::Number)
    r = sqrt(x^2 + y^2)
    φ = atan(y, x)
    return (r, φ)
end

"""
    cartesian(r::Number, φ::Number)

Convert ``(r, φ) → (x, y)``.
"""
@inline function cartesian(r::Number, φ::Number)
    x = r * cos(φ)
    y = r * sin(φ)
    return (x, y)
end

"""
    polar(xys)

Convert ``n×2`` matrix `xys` to polar coordinates.

First (second) column is the  `x` (`y`) component.

Returns two vectors. First contains distance `r`, second angle `φ`.
"""
function polar(xys)
    r = sqrt.(sum(xys .^ 2; dims=2))[:, 1]
    φ = atan.(xys[:, 2], xys[:, 1])
    return (r, φ)
end
