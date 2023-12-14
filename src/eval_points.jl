# evaluate board

using Distributions

function random_samples(μ::Vector, cov::Matrix, n::Int)
    d = MvNormal(µ, cov)
    return transpose(rand(d, n))
end

function expectation_value(μ::Vector, cov::Matrix, n::Int)
    samples = random_samples(μ, cov, n)
    rs, phis = polar(samples)
    return sum(dart_points(r, phi) for (r, phi) in zip(rs, phis)) / n
end

"""
    expectation_values(xs, ys, cov::Matrix, n::Int=1000)

Return expectation values on grid `xs`, `ys`.

For each point generate `n` random samples of a bivariate distribution
with covariance `cov`.
"""
function expectation_values(xs, ys, cov::Matrix, n::Int=1000)
    zs = Matrix{Float64}(undef, length(xs), length(ys))

    for (i, x) in enumerate(xs)
        for (j, y) in enumerate(ys)
            zs[i, j] = expectation_value([x, y], cov, n)
        end
    end
    return zs
end
