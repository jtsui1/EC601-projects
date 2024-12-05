function Kangle = wind_direction_factor(ang)
% dimensionless
% ang = angle b/w wind direction and conductor axis
Kangle = 1.194 - cosd(ang) + .194 * cosd(2 * ang) + .368 * sind(2 * ang);
end