function rtavg = conductor_resistance(rthigh, rtlow, thigh, tlow, tavg)
rtavg = ((rthigh-rtlow) / (thigh-tlow)) * (tavg-tlow) + rtlow;
end