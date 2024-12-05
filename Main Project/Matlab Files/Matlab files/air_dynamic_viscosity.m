function uf = air_dynamic_viscosity(Tfilm)
% kg/m-s or N-s/m^2
uf = (1.458 * 10^-6 * (Tfilm + 273)^1.5) / (Tfilm + 383.4);
end