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

"""
    hohmann_transfer_altitudes(h1, h2, body_radius, μ)

Calculate a transfer using altitudes above a spherical body's surface.
Altitudes and body radius are in km; μ is in km³/s². The returned values
use the same units and sign convention as `hohmann_transfer`.
"""
function hohmann_transfer_altitudes(h1::Real, h2::Real, body_radius::Real, μ::Real)
    for (name, value) in (("h1", h1), ("h2", h2))
        isfinite(value) && value >= 0 || throw(ArgumentError("$name must be finite and nonnegative"))
    end
    isfinite(body_radius) && body_radius > 0 ||
        throw(ArgumentError("body_radius must be finite and positive"))

    r1 = float(body_radius) + float(h1)
    r2 = float(body_radius) + float(h2)
    return hohmann_transfer(r1, r2, μ)
end
