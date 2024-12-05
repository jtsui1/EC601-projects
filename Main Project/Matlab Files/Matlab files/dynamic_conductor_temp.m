function [final_rating_array] = dynamic_conductor_temp(temp_target, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts, Ta_vector, ang_vector, He ,vw_vector, lat, atmosphere, steel_mass, aluminum_mass, deltatime)

%each x value is a 15 min interval
%time_array = 1:35040; 
%each y value is the rating for that 15 min interval
final_rating_array = zeros(1, 35040);

index_counter = 334;
hour_counter = 334;

%wind_speed = readmatrix("20230101_to_20230210.csv", "range", "I2:I10")

%wind_direction_original = readmatrix("20230101_to_20230210.csv", "range", "J2:J10")
%%adjust original wind speed values to match conductor position
%%add 45 degrees
%wind_direction = wind_direction_original + 45 

%Ta_array = readmatrix("20230101_to_20230210.csv", "range", "E2:E10")

for N = 335:365
    for time = 1:24
        hour_counter = hour_counter + 1;
        %set hourly info (get new Ta, Vw(wind speed), ang)
        Ta = Ta_vector(hour_counter);
        ang = ang_vector(hour_counter);
        vw = vw_vector(hour_counter);
        %set the first values in the excel to the values in the example to
        %keep it consistent?
        %watch units when setting hourly info (km to m)
        for i = 1:4 %should be 1:4
            index_counter = index_counter + 1;
            %do transient_thermal rating with set N and time and new hourly
            %new Ta, Vw(wind speed), ang
            %possible change in current
            %output of thermal_transient_rating is new initial current for temp
            %that new_current becomes new inital_current
            %initial_current / current_target = current_final
            [current_final, ~, ~, ~] = transient_thermal_rating(temp_target, current_new, current_target, rthigh, rtlow, tavg, tlow, thigh, Z1,...
    alpha, epsilon, D0, Aprime, Ts, Ta, ang, He ,vw, N, time, lat, atmosphere, steel_mass, aluminum_mass, deltatime);
    final_rating_array(index_counter) = current_final;
    current_target = current_final;
    %current_new = current_final; %double check this line
    %value of current_new doesn't really matter, since it's just a test
    %current value, it will get incremented/decremented until temp reaches
    %our set max value
        end
    end
end


            
            
        