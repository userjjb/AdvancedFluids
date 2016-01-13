function [PDot] = Calc_PDotMOD(rhoA, H3, mDotL, mDotA, rhoL, D1, R, T)
    PDot = (4*R*T/(pi*D1^2*H3))*(mDotA - (rhoA*mDotL/rhoL));
end

