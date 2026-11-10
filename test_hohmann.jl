using Test

include("hohmann.jl")

const EARTH_MU = 398600.4418

@testset "Hohmann transfer" begin
    transfer = hohmann_transfer(7000.0, 42164.0, EARTH_MU)
    @test transfer.departure_delta_v ≈ 2.3368 atol=0.0001
    @test transfer.arrival_delta_v ≈ 1.4339 atol=0.0001
    @test transfer.total_delta_v ≈ 3.7707 atol=0.0001
    @test transfer.transfer_time ≈ 19178.2 atol=1.0

    reverse = hohmann_transfer(42164.0, 7000.0, EARTH_MU)
    @test reverse.departure_delta_v ≈ -transfer.arrival_delta_v
    @test reverse.arrival_delta_v ≈ -transfer.departure_delta_v
    @test reverse.total_delta_v ≈ transfer.total_delta_v
    @test reverse.transfer_time ≈ transfer.transfer_time

    same_orbit = hohmann_transfer(7000.0, 7000.0, EARTH_MU)
    @test same_orbit.total_delta_v ≈ 0.0 atol=1e-12

    @test_throws ArgumentError hohmann_transfer(0.0, 7000.0, EARTH_MU)
    @test_throws ArgumentError hohmann_transfer(7000.0, -1.0, EARTH_MU)
    @test_throws ArgumentError hohmann_transfer(7000.0, 8000.0, Inf)
end

@testset "Transfer from altitudes" begin
    earth_radius = 6378.0
    from_altitudes = hohmann_transfer_altitudes(622.0, 35786.0, earth_radius, EARTH_MU)
    from_radii = hohmann_transfer(7000.0, 42164.0, EARTH_MU)

    @test from_altitudes == from_radii
    @test hohmann_transfer_altitudes(35786.0, 622.0, earth_radius, EARTH_MU) ==
          hohmann_transfer(42164.0, 7000.0, EARTH_MU)
    @test hohmann_transfer_altitudes(0.0, 622.0, earth_radius, EARTH_MU) ==
          hohmann_transfer(earth_radius, 7000.0, EARTH_MU)

    @test_throws ArgumentError hohmann_transfer_altitudes(-1.0, 622.0, earth_radius, EARTH_MU)
    @test_throws ArgumentError hohmann_transfer_altitudes(622.0, NaN, earth_radius, EARTH_MU)
    @test_throws ArgumentError hohmann_transfer_altitudes(622.0, 1000.0, 0.0, EARTH_MU)
    @test_throws ArgumentError hohmann_transfer_altitudes(622.0, 1000.0, Inf, EARTH_MU)
    @test_throws ArgumentError hohmann_transfer_altitudes(622.0, 1000.0, earth_radius, -1.0)
end
