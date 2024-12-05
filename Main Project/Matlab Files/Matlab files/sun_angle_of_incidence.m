function ang_sun = sun_angle_of_incidence(Hc, Zc, Z1)
ang_sun = acosd(cosd(Hc) * cosd(Zc-Z1));
end