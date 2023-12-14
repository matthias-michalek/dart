using Test
using Dart

@testset "points" begin
    # bull
    for φ in rand(10)
        @test dart_points(6, φ) == 50
        @test dart_points(10, φ) == 25
    end

    @test dart_points(20, 0.1) == 6
    @test dart_points(100, 0.1) == 3 * 6
    @test dart_points(165, 0.1) == 2 * 6

    @test dart_points(20, 0.4) == 13
    @test dart_points(100, 0.4) == 3 * 13
    @test dart_points(165, 0.4) == 2 * 13

    @test dart_points(20, 0.7) == 4
    @test dart_points(100, 0.7) == 3 * 4
    @test dart_points(165, 0.7) == 2 * 4

    @test dart_points(20, 1.0) == 18
    @test dart_points(100, 1.0) == 3 * 18
    @test dart_points(165, 1.0) == 2 * 18

    @test dart_points(20, 5.0) == 17
    @test dart_points(100, 5.0) == 3 * 17
    @test dart_points(165, 5.0) == 2 * 17

    @test dart_points(20, -0.1) == 6
    @test dart_points(100, -0.1) == 3 * 6
    @test dart_points(165, -0.1) == 2 * 6

    @test dart_points(20, -0.3) == 10
    @test dart_points(100, -0.3) == 3 * 10
    @test dart_points(165, -0.3) == 2 * 10
end # points
