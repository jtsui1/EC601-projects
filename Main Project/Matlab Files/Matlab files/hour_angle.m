function omega = hour_angle(time)
%(Time - Noon)*15 degrees
%Time is 24 hour
omega = (time - 12)*15; 
end