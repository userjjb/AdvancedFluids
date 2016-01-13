function [PDot] = Calc_PDot(PAir, H3, mDotL, mDotA, rhoL, D1, R, T)
    PDot = (4/(pi*D1^2*H3))*(mDotA*R*T - (PAir*mDotL/rhoL));
end

