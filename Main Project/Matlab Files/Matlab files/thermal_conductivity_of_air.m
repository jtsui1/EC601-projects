function kf = thermal_conductivity_of_air(Tfilm)
% W/m * deg Celsius
kf = 2.424 * 10^-2 + 7.477 * 10^-5 * Tfilm - 4.407 * 10^-9 * Tfilm^2;
end