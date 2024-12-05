function Qse = heat_intensity(Hc, He, atmosphere)
%SI units
if atmosphere == "clear" 
    A = -42.2391;
    B = 63.8044;
    C = -1.9220;
    D = 3.46921 * 10^-2;
    E = -3.61118 * 10^-4;
    F = 1.94318 * 10^-6;
    G = -4.07608 *10^-9;
elseif atmosphere == "industrial"
    A = 53.1821;
    B = 14.2110;
    C = 6.6138 * 10^-1;
    D = -3.1658 * 10^-2;
    E = 5.4654 * 10^-4;
    F = -4.3446 * 10^-6;
    G = 1.3236 *10^-8;
end

Qs = A + B * Hc + C * Hc^2 + D * Hc^3 + E * Hc^4 + F * Hc^5 + G * Hc^6;

%Qs corrected for elevation
A_elevation = 1;
B_elevation = 1.148 * 10^-4;
C_elevation = -1.108 * 10^-8;

Ksolar = A_elevation + B_elevation * He + C_elevation * He^2;

Qse = Ksolar * Qs;
end