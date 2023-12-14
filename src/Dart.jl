module Dart

export polar,
    cartesian, dart_points, main, draw_board!, draw_annotations!, expectation_values

using CairoMakie
using LinearAlgebra

include("./parameters.jl")
include("./transformations.jl")
include("./points.jl")
include("plots.jl")
include("./eval_points.jl")

function area_circle_segment(ri, ro, dphi)
    return dphi * (ro^2 - ri^2)
end

function center_of_mass(v_rrphi, dphi)
    ri, ro, phi = v_rrphi
    return 2 / 3 * 1 / dphi * (ro^3 - ri^3) / (ro^2 - ri^2) *
           [sin(dphi + phi) - sin(phi), -cos(dphi + phi) + cos(phi)]
end

function calc_coms(rrphi, dphi)
    return center_of_mass.(rrphi, dphi)
end

function area_of_segment(v_rrphi, dphi)
    ri, ro, phi = v_rrphi
    return dphi / 2 * (ro^2 - ri^2)
end

function areas_of_segments(rrphi, dphi)
    areas = area_of_segment.(rrphi, dphi)
    return areas
end

function weights_of_segments(areas, vals)
    factors = [1, 3, 1, 2]
    return areas .* vals .* factors'
end

function main()
    rb_i = 6.35
    rb_o = 16.0

    ri_i = 99.0
    ri_o = 107.0

    ro_i = 162.0
    ro_o = 170.0

    vals = [50, 25, 6, 13, 4, 18, 1, 20, 5, 12, 9, 14, 11, 8, 16, 7, 19, 3, 17, 2, 15, 10]

    rs = [rb_i, rb_o, ri_i, ri_o, ro_i, ro_o]

    dphi = 2π / 20
    phis = LinRange(0, 2π - dphi, 20) .- dphi / 2

    rrphi = [[rs[j + 1], rs[j + 2], phi] for phi in phis, j in 1:4]

    coms = calc_coms(rrphi, dphi)
    areas = areas_of_segments(rrphi, dphi)
    weights = weights_of_segments(areas, vals[3:end])

    weights_be = [rb_i^2 * π * vals[1], (rb_o^2 - rb_i^2) * π * vals[2]]
    mass = sum(weights) + sum(weights_be)

    center_of_mass = sum(coms .* weights) / mass

    # Plot result
    f = Figure()
    colsize!(f.layout, 1, Aspect(1, 1.0))
    ax = Axis(f[1, 1])
    draw_board!(ax)
    draw_annotations!(ax, 200)
    scatter!(ax, [center_of_mass[1]], [center_of_mass[2]])
    resize_to_layout!(f)
    return f
end

end # of module
