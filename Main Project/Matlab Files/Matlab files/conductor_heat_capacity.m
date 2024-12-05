function mCp = conductor_heat_capacity(steel_mass, aluminum_mass)

steel_heat = 476;
aluminum_heat = 955;

mCp = steel_mass * steel_heat + aluminum_mass * aluminum_heat;

end