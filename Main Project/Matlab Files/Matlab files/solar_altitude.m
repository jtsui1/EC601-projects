function Hc = solar_altitude(lat, delta, omega)
%N = day of the year
Hc_calc = asind(cosd(lat) * cosd(delta) * cosd(omega) + sind(lat) * sind(delta));
if Hc_calc < 0
    Hc = 0;
else
    Hc = Hc_calc;
end