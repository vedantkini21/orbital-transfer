# Hohmann transfer

An analytical calculation of the two impulsive burns needed to transfer between coplanar circular orbits.

The model assumes a central gravitational field and instantaneous burns. It does not account for perturbations, inclination changes, or finite burn duration.

Radii are measured from the center of the attracting body, not from its surface. Use kilometers for radii and km³/s² for the gravitational parameter. The returned velocity changes are in km/s and the transfer time is in seconds. Individual velocity changes are signed; the total is the sum of their magnitudes.

```julia
include("hohmann.jl")

earth_mu = 398600.4418
transfer = hohmann_transfer(7000.0, 42164.0, earth_mu)
println(transfer)
```

If the orbits are given as altitudes above a spherical body, pass the body radius as well:

```julia
earth_radius = 6378.0
transfer = hohmann_transfer_altitudes(622.0, 35786.0, earth_radius, earth_mu)
println(transfer)
```

Altitudes and the body radius are in kilometers. The model does not check for the atmosphere or other physical obstacles.

Run the tests from this folder with:

```sh
julia test_hohmann.jl
```
