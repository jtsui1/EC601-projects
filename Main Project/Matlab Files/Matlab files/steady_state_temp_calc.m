function [Ts_final, tavg_final, current_final] = steady_state_temp_calc(current_target, rthigh, rtlow, tavg_test, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts_test, Ta, ang, He ,vw, N, time, lat, atmosphere)
%define desired current
%choose a trial conductor temperature


%calculate current for chosen trial temp
[current_calc, ~, ~, ~, ~] = heat_terms(rthigh, rtlow, tavg_test, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts_test, Ta, ang, He ,vw, N, time, lat, atmosphere);

%compare calcaulted current with desired current
if current_calc < current_target
    while current_calc < current_target
        Ts_test = Ts_test + .5;
        tavg_test = tavg_test + .5;
        [current_calc, ~, ~, ~, ~] = heat_terms(rthigh, rtlow, tavg_test, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts_test, Ta, ang, He ,vw, N, time, lat, atmosphere);
    end
    if current_calc ~= current_target
        Ts_final = Ts_test - .5;
        tavg_final = tavg_test - .5;
        [current_final, ~, ~, ~, ~] = heat_terms(rthigh, rtlow, tavg_final, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts_final, Ta, ang, He ,vw, N, time, lat, atmosphere);
    else
        Ts_final = Ts_test;
        tavg_final = tavg_test;
        current_final = current_calc;
    end
elseif current_calc > current_target
    while current_calc > current_target
        Ts_test = Ts_test - .5;
        tavg_test = tavg_test - .5;
        [current_calc, ~, ~, ~, ~] = heat_terms(rthigh, rtlow, tavg_test, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts_test, Ta, ang, He ,vw, N, time, lat, atmosphere);
    end
    if current_calc ~= current_target
        Ts_final = Ts_test + .5;
        tavg_final = tavg_test + .5;
        [current_final, ~, ~, ~, ~] = heat_terms(rthigh, rtlow, tavg_final, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts_final, Ta, ang, He ,vw, N, time, lat, atmosphere);
    else
        Ts_final = Ts_test;
        tavg_final = tavg_test;
        current_final = current_calc;
    end
else
    Ts_final = Ts_test;
    tavg_final = tavg_test;
    current_final = current_calc;
end
    

%output should be temp (tavg and Ts, which are the same)

