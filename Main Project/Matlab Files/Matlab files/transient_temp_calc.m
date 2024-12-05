function [Ts_final, tavg_final, current_final, current_start] = transient_temp_calc(iter_range, current_new, initial_current, rthigh, rtlow, tavg, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime)

%use steady_state_temp_calc to output temp for inputted current
[Ts_final, tavg_final] = steady_state_temp_calc(initial_current, rthigh, rtlow, tavg, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere);

%input desired current of 1000, will get 97.5 as output temp
%input desired initial current of 1025, will get 100 as output temp
%use new temp to find corresponding heat terms

mCp = conductor_heat_capacity(steel_mass, aluminum_mass);

%for 15 min - set range to 90

for i = 1:iter_range
    [~, rtavg, qc, qr, qs] = heat_terms(rthigh, rtlow, tavg_final, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts_final, Ta, ang, He ,vw, N, time, lat, atmosphere);
    deltaTavg = delta_temp(deltatime, mCp, current_new, rtavg, qc, qr, qs); %current_new may need to be changed for DLR calc
    Ts_final = Ts_final + deltaTavg;
    tavg_final = tavg_final + deltaTavg;
end

%calc second delta temp with new tavg_final and Ts_final
% [current_initial, rtavg, qc, qr, qs] = heat_terms(rthigh, rtlow, tavg_final, tlow, thigh, Z1,...
%     alpha, epsilon, D0, Aprime, Ts_final, Ta, ang, He ,vw, N, time, lat, atmosphere);
% 
% deltaTavg = delta_temp(deltatime, mCp, current_new, rtavg, qc, qr, qs)
% Ts_final = Ts_final + deltaTavg
% tavg_final = tavg_final + deltaTavg
%repeat as necessary 15 min (10 sec -> *6*15 = 90 iterations for 15 min)
current_start = initial_current;
current_final = current_new;

% %1 check if current steady-state temp is higher or lower than max temp
% if Ts_final > Ts
%     while Ts_final > Ts
%         current_target = current_target - .5;
%         [Ts_final, tavg_final] = steady_state_temp_calc(current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
%         alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere)
%         [current_initial, rtavg, qc, qr, qs] = heat_terms(rthigh, rtlow, tavg_final, tlow, thigh, Z1,...
%         alpha, epsilon, D0, Aprime, Ts_final, Ta, ang, He ,vw, N, time, lat, atmosphere)
    

%2 if lower, increment current until output temp increases to max-allowed temp
%3 then take prev current as rating if output is greater, or take current
%one as rating if they are exactly equal

%4 if higher, lower current until output temp decreases to max-allowed temp
%5 then take prev current as rating


% [~, rtavg, qc, qr, qs] = heat_terms(rthigh, rtlow, tavg, tlow, thigh, Z1,...
%     alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere)
% 
% mCp = conductor_heat_capacity(steel_mass, aluminum_mass);
% deltaTavg = delta_temp(deltatime, mCp, current, rtavg, qc, qr, qs)

