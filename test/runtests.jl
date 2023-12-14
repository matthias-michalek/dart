using Test
using Dart

@testset verbose = true "full" begin
    include("./transformations.jl")
end
