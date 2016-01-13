function [p1,p2,p3,p4,p5] = PlotResults(time, data, D1, saved_H2, saved_H3, saved_rhoA, rhoL, saved_mDotL, saved_PAir)
    saved_mL =pi*(D1^2/4)*saved_H2*rhoL;
    saved_mA =pi*(D1^2/4)*saved_H3.*saved_rhoA;
    saved_mAL =saved_mA + saved_mL;
    p1=subplot(231);plot(time, saved_mDotL(data));xlabel('time (s)');ylabel('Mass Flow at Outlet (kg/s)');
    p2=subplot(232);plot(time, saved_PAir(data));xlabel('time (s)');ylabel('Internal Air Pressure(gauge Pa)');
    p3=subplot(234);plot(time, saved_mA(data));xlabel('time (s)');ylabel('Mass of Air (kg)');
    p4=subplot(235);plot(time, saved_mL(data));xlabel('time (s)');ylabel('Mass of Water (kg)');
    p5=subplot(236);plot(time, saved_mAL(data));xlabel('time (s)');ylabel('Mass of Air+Water (kg)');
end

