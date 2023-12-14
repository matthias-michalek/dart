using Test

@testset "transformations" begin
    @testset "polar" begin
        @test polar(1, 0) == (1, 0)
        @test polar(0, 2) == (2, π / 2)
        @test polar(-3, 0) == (3, 1π)
        @test polar(0, -4) == (4, -π / 2)
        @test polar(1, 1) == (sqrt(2), π / 4)
        @test polar(3, 4) == (5, atan(4, 3))
    end # polar

    @testset "cartesian" begin
        @test cartesian(1, 0) == (1, 0)
        x, y = cartesian(2, π / 2)
        @test isapprox(x, 0, atol=eps())
        @test y == 2
        @test cartesian(3, π) == (-3, 0)
        x, y = cartesian(4, -π / 2)
        @test isapprox(x, 0, atol=2 * eps())
        @test y == -4
        x, y = cartesian(sqrt(2), π / 4)
        @test isapprox(x, 1, atol=eps())
        @test y == 1
        x, y = cartesian(5, atan(4, 3))
        @test isapprox(x, 3, rtol=1E-15)
        @test isapprox(y, 4, rtol=1E-15)
    end # cartesian
end # transformations
