# Circular Earth orbits, with radii measured from Earth's center.
mu = 398600.4418  # km^3/s^2
r1 = 7000.0       # km
r2 = 42164.0      # km

# The transfer ellipse has its apsides on the two circular orbits.
a = (r1 + r2) / 2

v_circular_1 = sqrt(mu / r1)
v_circular_2 = sqrt(mu / r2)

# Vis-viva gives the transfer-orbit speed at each burn.
v_transfer_1 = sqrt(mu * (2 / r1 - 1 / a))
v_transfer_2 = sqrt(mu * (2 / r2 - 1 / a))

delta_v1 = v_transfer_1 - v_circular_1
delta_v2 = v_circular_2 - v_transfer_2
total_delta_v = abs(delta_v1) + abs(delta_v2)
transfer_time = pi * sqrt(a^3 / mu)

println("Transfer semimajor axis: ", round(a, digits=1), " km")
println("First burn: ", round(delta_v1, digits=4), " km/s")
println("Second burn: ", round(delta_v2, digits=4), " km/s")
println("Total delta-v: ", round(total_delta_v, digits=4), " km/s")
println("Transfer time: ", round(transfer_time / 3600, digits=2), " hours")
