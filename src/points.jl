"""
    points(r::Number, φ::Number)

Calculate points on the dart board given `r`, `φ`.

Only works if ``φ ∈ [-2π, 2π]``.
"""
function dart_points(r::Number, φ::Number)
    result = 1

    # Radial component
    ir = searchsortedfirst(radii, r)
    if ir == 1
        # inner bull
        return bullseye[1]
    elseif ir == 2
        # outer bull
        return bullseye[2]
    elseif ir == 4
        # triple
        result *= 3
    elseif ir == 6
        # double
        result *= 2
    elseif ir == 7
        # outside board
        return 0
    end

    # Polar component
    interval = 2π / nsections
    ϕ = φ < 0 ? φ + 2π : φ # only want positive angles
    i = ceil(Int, ϕ / interval + 0.5) % 20
    i == 0 && (i = 20)
    result *= points[i]

    return result
end
