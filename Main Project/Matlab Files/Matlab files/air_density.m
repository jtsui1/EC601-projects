function pf = air_density(He, Tfilm)
% kg/m^3
pf = (1.293 - 1.525 * 10^-4 * He + 6.379 * 10^-9 * He^2) / (1 + .00367 * Tfilm);
end