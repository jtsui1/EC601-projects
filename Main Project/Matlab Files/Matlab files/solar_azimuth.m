function Zc = solar_azimuth(chi, omega)
%calculate azimuth constant

if -180 <= omega && omega < 0 && chi >= 0
    C = 0;
elseif 0 <= omega && omega < 180 && chi < 0
    C = 360;
else
    C = 180;
end
    
Zc = C + atand(chi);
end