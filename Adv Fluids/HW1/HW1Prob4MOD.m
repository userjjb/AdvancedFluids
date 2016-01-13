%Short program to simulate conditions in air powered water pump
%Josh Bevan Sept 2013
%22.581 HW#1, Problem 4

clc

%Physical constants
g =9.8; %m/s^2
rhoL =1000; %kg/m^3
PAtm =101325; %Pa
R =287.058; %J/kg K
c_air =340; %m/s

%Problem ICs
%    |      A
% ___|___   | H1
% |  H3 |   V
% |=====|   A
% |     |   | H2
% |_____|   V

T =293; %K
H1_0 =0.15; %m
H2_0 =0.4;
H3_0 =0.1;
D1 =0.3; %m
D2 =0.02;
D3 =0.02;
mDotL_0 =0; %kg/s Flow of water through exit
P0 =g* rhoL* H1_0 + PAtm; %Pressure of air in pump

%Inputs
mDotA =0.01; %kg/s Flow of air into pumped port________________________________Modify Here
rhoA =1.225;
del_t =0.001; %s Timestep for iterative time marching
max_t =40; %s Maximum time to simulate for
steps =floor(max_t/del_t +1);

%Functions defined:
%[mDotL] = Calc_mDotL(PAir, H1, rhoL, PAtm, D3, g)
%[PDot] = Calc_PDotMOD(PAir, H3, mDotL, mDotA, rhoL, D1, R, T)
%[p1,p2,p3,p4,p5] = PlotResults(time, data, D1, saved_H2, saved_H3, saved_rhoA, rhoL, saved_mDotL, saved_PAir)

%Main loop
%%Initialization
PAir =P0;
H1 =H1_0;
H2 =H2_0;
H3 =H3_0;
mDotL =mDotL_0;

%Preallocate save structures
step=1;
saved_mDotL =zeros(steps,1);
saved_H2=zeros(steps,1);
saved_H3=zeros(steps,1);
saved_PAir=zeros(steps,1);
saved_mDotL(step)=mDotL;
saved_H2(step)=H2;
saved_H3(step)=H3;
saved_PAir(step)=PAir-PAtm;

for t=0:del_t:max_t;
    step =step+1;
    PDot =Calc_PDotMOD(rhoA, H3, mDotL, mDotA, rhoL, D1, R, T);
    mDotL =Calc_mDotL(PAir, H1, rhoL, PAtm, D3, g);

    PAir =PAir + PDot*del_t; %Pa Calculate new PAir based on rate of change
    if H2 %If water hasn't been exhausted
        del_H2 =del_t*((-4* mDotL)/(pi* D1^2* rhoL)); %m Calculate change in water height due to water flow out
        H2 = max(H2+del_H2,0);
        H1 =H1-del_H2; %
        H3 =H3-del_H2; %Both H1 and H3 decrease in magnitude by del_H3
        %Save data    
        saved_mDotL(step)=mDotL;
        saved_H2(step)=H2;
        saved_H3(step)=H3;
        saved_PAir(step)=PAir-PAtm;
        saved_rhoA =PAir/(R*T);
    else %Plot when empty
        PlotResults(0:del_t:t,1:step-1, D1, saved_H2, saved_H3, saved_rhoA, rhoL, saved_mDotL, saved_PAir);
        return
    end
end

%If sim hasn't run to conclusion, plot what we have
PlotResults(0:del_t:max_t+del_t,1:steps+1, D1, saved_H2, saved_H3, saved_rhoA, rhoL, saved_mDotL, saved_PAir);

%For the purposes of printing, function files:
% function [mDotL] = Calc_mDotL(PAir, H1, rhoL, PAtm, D3, g)
%     mDotL = rhoL*pi*(D3^2/4)*sqrt(2*((PAir-PAtm)/rhoL-g*H1));
% end
% 
% function [PDot] = Calc_PDotMOD(PAir, H3, mDotL, mDotA, rhoL, D1, R, T)
%     PDot = (4/(pi*D1^2*H3))*(mDotA*R*T - (PAir*mDotL/rhoL));
% end
%
% function [p1,p2,p3,p4,p5] = PlotResults(time, data, D1, saved_H2, saved_H3, saved_rhoA, rhoL, saved_mDotL, saved_PAir)
%     saved_mL =pi*(D1^2/4)*saved_H2*rhoL;
%     saved_mA =pi*(D1^2/4)*saved_H3.*saved_rhoA;
%     saved_mAL =saved_mA + saved_mL;
%     p1=subplot(231);plot(time, saved_mDotL(data));xlabel('time (s)');ylabel('Mass Flow at Outlet (kg/s)');
%     p2=subplot(232);plot(time, saved_PAir(data));xlabel('time (s)');ylabel('Internal Air Pressure(gauge Pa)');
%     p3=subplot(234);plot(time, saved_mA(data));xlabel('time (s)');ylabel('Mass of Air (kg)');
%     p4=subplot(235);plot(time, saved_mL(data));xlabel('time (s)');ylabel('Mass of Water (kg)');
%     p5=subplot(236);plot(time, saved_mAL(data));xlabel('time (s)');ylabel('Mass of Air+Water (kg)');
% end