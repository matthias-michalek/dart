# MVP of a heatmap without gaussian.

using CairoMakie

function mvp()
    xs = range(-200, 200; length=400)
    ys = range(-200, 200; length=400)
    return zs = [dart_points(polar(x, y)...) for x in xs, y in ys]
end

function exp_val(vec_xy, σ_x::Number, σ_y::Number, cov_xy::Number=0, n_samples::Int=1000)
    samples = random_samples(σ_x, σ_y, n_samples, cov_xy)
    samples' .+= vec_xy
    rs, phis = polar(samples)
    return sum(dart_points(r, phi) for (r, phi) in zip(rs, phis)) / n_samples
end

function exp_vals(
    nx::Int, ny::Int, σ_x::Number, σ_y::Number, cov_xy::Number=0, n_samples::Int=1000
)
    xs = range(-radii[6], radii[6], nx)
    ys = range(-radii[6], radii[6], nx)
    zs = Matrix{Float64}(undef, nx, ny)

    for (i, x) in enumerate(xs)
        for (j, y) in enumerate(ys)
            zs[i, j] = exp_val([x, y], σ_x, σ_y, cov_xy, n_samples)
        end
    end
    return xs, ys, zs
end