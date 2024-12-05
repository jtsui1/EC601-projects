function [current, rtavg, qc, qr, qs] = heat_terms(rthigh, rtlow, tavg, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere)

Tfilm = mean_film_temp(Ts,Ta);
pf = air_density(He, Tfilm);

qcn = 3.645 * pf^.5 * D0^.75 * (Ts-Ta)^1.25;

uf = air_dynamic_viscosity(Tfilm);
Nre = reynolds_num(D0, pf, vw, uf);

Kangle = wind_direction_factor(ang);

kf = thermal_conductivity_of_air(Tfilm);
qc1 = Kangle*(1.01+1.35*Nre^.52)*kf*(Ts-Ta);
qc2 = Kangle*.754*Nre^.6*kf*(Ts-Ta);

qc_array = [qcn qc1 qc2];
qc = max(qc_array);

qr = 17.8*D0*epsilon*((((Ts+273)/100)^4)-(((Ta+273)/100)^4));

omega = hour_angle(time);
delta = solar_declination(N);

Hc = solar_altitude(lat, delta, omega);

chi = solar_azimuth_variable(omega, lat, delta);

Zc = solar_azimuth(chi, omega);

Qse = heat_intensity(Hc, He, atmosphere);

ang_sun = sun_angle_of_incidence(Hc, Zc, Z1);
qs = alpha*Qse*sind(ang_sun)*Aprime;

rtavg = conductor_resistance(rthigh, rtlow, thigh, tlow, tavg);

current = sqrt((qc+qr-qs)/rtavg);
end