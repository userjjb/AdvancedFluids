function [mDotL] = Calc_mDotL(PAir, H1, rhoL, PAtm, D3, g)
    mDotL = rhoL*pi*(D3^2/4)*sqrt(2*((PAir-PAtm)/rhoL-g*H1));
end