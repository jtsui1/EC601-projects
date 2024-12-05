function chi = solar_azimuth_variable(omega, lat, delta)
chi = sind(omega) / (sind(lat) * cosd(omega) - cosd(lat) * tand(delta));
end