"""
    hohmann_transfer(r1, r2, μ)

Calculate a Hohmann transfer between two coplanar circular orbits.
Radii are in km and μ is in km³/s². Velocity changes are in km/s and
transfer time is in seconds. Signed velocity changes are positive for
an acceleration and negative for a deceleration.
"""
function hohmann_transfer(r1::Real, r2::Real, μ::Real)
    for (name, value) in (("r1", r1), ("r2", r2), ("μ", μ))
        isfinite(value) && value > 0 || throw(ArgumentError("$name must be finite and positive"))
    end

    a_transfer = (r1 + r2) / 2
    v1 = sqrt(μ / r1)
    v2 = sqrt(μ / r2)
    v_transfer_1 = sqrt(μ * (2 / r1 - 1 / a_transfer))
    v_transfer_2 = sqrt(μ * (2 / r2 - 1 / a_transfer))

    Δv1 = v_transfer_1 - v1
    Δv2 = v2 - v_transfer_2

    return (
        departure_delta_v = Δv1,
        arrival_delta_v = Δv2,
        total_delta_v = abs(Δv1) + abs(Δv2),
        transfer_time = π * sqrt(a_transfer^3 / μ),
        transfer_semimajor_axis = a_transfer,
    )
end
