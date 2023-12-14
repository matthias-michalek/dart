# MVP of a heatmap without gaussian.

using CairoMakie

function mvp()
    xs = range(-200, 200; length=400)
    ys = range(-200, 200; length=400)
    zs2 = [dart_points(polar(x, y)...) for x in xs, y in ys]

    f = Figure()
    colsize!(f.layout, 1, Aspect(1, 1.0))
    ax = Axis(f[1, 1])

    heatmap!(ax, xs, ys, zs2)
    draw_board!(ax)
    draw_annotations!(ax, 180; color=:white)
    Colorbar(f[:, end + 1]; limits=(0, 60))
    resize_to_layout!(f)
    return f
end
