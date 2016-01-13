%Short program to simulate operation of a jet-ski with constant relative
%jet velocity
%Josh Bevan Sept 2013
%22.581 HW#2, Problem 4

clc
close all
clear all

%Physical constants
g =9.8; %m/s^2
RhoW =1000; %kg/m^3

%Problem ICs at t=0
x_ski=0; %m/s Distance travelled by jet-ski
v_ski=0; %m/s Velocity of jet-ski

%Inputs
CDA =6.87E-3; %m^2 Drag-area
u_rel =21; %m/s Relative jet velocity
AOut =pi*(0.075^2); %m^2 Area of jet outlet
mass_ski =450; %kg Mass of jet-ski
%
del_t =0.001; %s Timestep for iterative time marching
max_t =2.5; %s Maximum time to simulate for
steps =floor(max_t/del_t +1);

%Main loop
%Initialization
Thrust =RhoW*AOut*(u_rel^2 + u_rel*v_ski); %Newtons Thrust of jet-ski
a_ski =-(RhoW/mass_ski)*(AOut*(u_rel^2 + u_rel*v_ski) - (CDA*v_ski^2)/2); %m/s^2 Acceleration of jet-ski

%Preallocate save structures
step=1;
saved_Thrust=zeros(steps,1);
saved_Accel=zeros(steps,1);
saved_Velocity=zeros(steps,1);
saved_Dist=zeros(steps,1);
saved_Thrust(step)=Thrust;
saved_Accel(step)=a_ski;
saved_Velocity(step)=v_ski;
saved_Dist(step)=x_ski;

for t=0:del_t:max_t;
    step =step+1;
    if abs(v_ski)<=16 %If ski hasn't reached desired speed
        x_ski = x_ski - v_ski*del_t;
        v_ski = v_ski + a_ski*del_t;
        Thrust =RhoW*AOut*(u_rel^2 + u_rel*v_ski); %Newtons Thrust of jet-ski
        a_ski =-(RhoW/mass_ski)*(AOut*(u_rel^2 + u_rel*v_ski) - (CDA*v_ski^2)/2); %m/s^2 Acceleration of jet-ski
        %Save data    
        saved_Thrust(step)=Thrust;
        saved_Accel(step)=a_ski;
        saved_Velocity(step)=v_ski;
        saved_Dist(step)=x_ski;
    else %Plot when empty
        PlotResults(0:del_t:t,1:step-1, saved_Thrust, saved_Accel, saved_Velocity, saved_Dist);
        return
    end
end 

%If sim hasn't run to conclusion, plot what we have
PlotResults(0:del_t:max_t+del_t,1:steps+1, saved_Thrust, saved_Accel, saved_Velocity, saved_Dist);

%For the purposes of printing, function files:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [p1,p2,p3,p4] = PlotResults(time, data, saved_Thrust, saved_Accel, saved_Velocity, saved_Dist)
%     p1=subplot(221);plot(time, saved_Thrust(data));xlabel('time (s)');ylabel('Thrust of jet-ski (N)');
%     p2=subplot(222);plot(time, saved_Accel(data));xlabel('time (s)');ylabel('Acceleration of jet-ski (m/s^2)');
%     p3=subplot(223);plot(time, saved_Velocity(data));xlabel('time (s)');ylabel('Velocity of jet-ski (m/s)');
%     p4=subplot(224);plot(time, saved_Dist(data));xlabel('time (s)');ylabel('Distance travelled by jet-ski (m)');
% end