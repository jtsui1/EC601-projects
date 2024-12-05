function [current_final, current_start, Ts_final, tavg_final] = transient_thermal_rating(temp_target, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime)

%do transient_temp_calc with trial current_new
[Ts_final, tavg_final, ~, ~] = transient_temp_calc(600, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime);

%after 15 min interal, check if calulated temp is above or below desired temp
%increment or decrement current_new until you get desired temp
if Ts_final > temp_target
    while Ts_final > temp_target
        current_new = current_new - .5;
        [Ts_final, tavg_final, ~, ~] = transient_temp_calc(90, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime);
    end
    if Ts_final ~= temp_target
        current_new = current_new + .5;
        [Ts_final, tavg_final, ~, ~] = transient_temp_calc(90, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime);
        current_start = current_target;
        current_final = current_new;
    else
        current_start = current_target;
        current_final = current_new;
        %Ts_final and tavg_final stay the same
    end
elseif Ts_final < temp_target
   while Ts_final < temp_target
        current_new = current_new + .5;
        [Ts_final, tavg_final, ~, ~] = transient_temp_calc(90, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime);
    end
    if Ts_final ~= temp_target
        current_new = current_new - .5;
        [Ts_final, tavg_final, ~, ~] = transient_temp_calc(90, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
        alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime);
        current_start = current_target;
        current_final = current_new;
    else
        current_start = current_target;
        current_final = current_new;
        %Ts_final and tavg_final stay the same
    end     
else
    current_start = current_target;
    current_final = current_new;
    Ts_final = temp_target;
    tavg_final = temp_target;
end


% for dynamic
%copy transient_thermal rating
%do 4x 1-900 loops assuming constant current and weather (1 hr)
%for 1-4
    %for 1-900
%at end of 1 hr, update weather and current parameters
%8760 hours in a year
%for 1 to 8760 for each hour
    %for 1-4 break each hour into 15 min interval
        %for 1-900 break each 15 min interval into 10 sec intervals