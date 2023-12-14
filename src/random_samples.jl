using Distributions

"""
    random_samples(σ_x::Number, σ_y::Number, n::Int=1000, cov_xy::Number=0.0)

Get `n` random samples of a bivariate distribution with variances `σ_x^2`, `σ_y^2`, and covariance `cov_xy`.
"""
function random_samples(σ_x::Number, σ_y::Number, n::Int=1000, cov_xy::Number=0)
    C = [σ_x^2 cov_xy; cov_xy σ_y^2]
    µ = [0, 0]
    d = MvNormal(µ, C)
    return transpose(rand(d, n))
end
