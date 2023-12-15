using CairoMakie

function draw_circle!(ax::Axis, r::Number; kwargs...)
    arc!(ax, Point2f(0), r, 0.0, 2 * π; color=:black, kwargs...)
    return nothing
end

function draw_circles!(ax::Axis, radii; kwargs...)
    for r in radii
        arc!(ax, Point2f(0), r, 0.0, 2 * π; color=:black, kwargs...)
    end
    return nothing
end

@inline function draw_line!(ax::Axis, ri::Number, ro::Number, φ::Number; kwargs...)
    x = [ri, ro] * cos(φ)
    y = [ri, ro] * sin(φ)
    lines!(ax, x, y; color=:black, kwargs...)
    return nothing
end

function draw_lines!(ax::Axis, ri::Number, ro::Number, φs; kwargs...)
    for φ in φs
        draw_line!(ax, ri, ro, φ; kwargs...)
    end
end

"""
    draw_board!(ax::Axis; kwargs...)

Draw a dart board on `ax`.
"""
function draw_board!(ax::Axis; kwargs...)
    ri = radii[2]
    ro = radii[end]
    draw_lines!(ax, ri, ro, φs .- π / nsections; kwargs...)
    draw_circles!(ax, radii; kwargs...)
    return nothing
end

"""
    draw_annotations!(ax::Axis, r::Number=200)

Annotate sections of dart board.

`r` is the radius at which the numbers are written.
Since the board itself has a radius of 170, larger numbers than that are recommended.
"""
function draw_annotations!(ax::Axis, r::Number=200; kwargs...)
    φs = range(0, 2π * (1 - 1 / nsections), nsections)
    xs = r * [cos(φ) for φ in φs]
    ys = r * [sin(φ) for φ in φs]

    annotations!(
        ax,
        [string(p) for p in points],
        [Point(x, y) for (x, y) in zip(xs, ys)];
        align=(:center, :center),
        kwargs...,
    )
    return nothing
end

"""
    draw_heatmap(xs, ys, zs)

Return a `Figure` containing a heatmap.

`xs`, `ys` is the grid, `zs` contains the values.
"""
function draw_heatmap(xs, ys, zs)
    f = Figure()
    colsize!(f.layout, 1, Aspect(1, 1.0))
    ax = Axis(f[1, 1])

    heatmap!(ax, xs, ys, zs; colorrange=(0, 60))
    draw_board!(ax)
    draw_annotations!(ax, 185; color=:white)
    Colorbar(f[:, end + 1]; limits=(0, 60))
    resize_to_layout!(f)
    return f
end
