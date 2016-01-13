function [p1,p2,p3,p4] = PlotResults(time, data, saved_Thrust, saved_Accel, saved_Velocity, saved_Dist)
    p1=subplot(221);plot(time, saved_Thrust(data));xlabel('time (s)');ylabel('Thrust of jet-ski (N)');
    p2=subplot(222);plot(time, saved_Accel(data));xlabel('time (s)');ylabel('Acceleration of jet-ski (m/s^2)');
    p3=subplot(223);plot(time, saved_Velocity(data));xlabel('time (s)');ylabel('Velocity of jet-ski (m/s)');
    p4=subplot(224);plot(time, saved_Dist(data));xlabel('time (s)');ylabel('Distance travelled by jet-ski (m)');
end

