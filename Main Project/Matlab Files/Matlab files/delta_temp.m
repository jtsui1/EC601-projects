function deltaTavg = delta_temp(deltatime, mCp, current, rtavg, qc, qr, qs)

deltaTavg = (1/mCp)*(rtavg * current^2 + qs - qc - qr) * deltatime;

end