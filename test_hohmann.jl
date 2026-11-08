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
