% Function to Calculate Residual
function [f] = inverseEqn2(theta1)
    x = 20/sqrt(2);
    y = 20/sqrt(2);
    a1 = 10;
    a2 = 10;

    f = -(a1*sin(theta1) + a2*sin(acos((x - a1*cos(theta1))/a2)) - y);
end