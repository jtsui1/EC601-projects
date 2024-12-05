function delta = solar_declination(N)
%N = day of the year
delta = 23.45 * sind((284 + N) / 365 * 360); 
end