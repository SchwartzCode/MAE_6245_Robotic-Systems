function [theta1, theta2] = findAnglesInverseKin(xDes, yDes)
    a1 = 10;
    a2 = 10;

    theta2 = acos( (xDes^2 + yDes^2 - a1^2 - a2^2) / (2 * a1 * a2) );
    theta1 = atan2(-a2 * sin(theta2), a1 + a2*cos(theta2)) + atan2(sqrt( (a1 + a2*cos(theta2))^2 + (a2*sin(theta2))^2 - xDes^2), xDes);
    if(yDes < 0)
        theta1 = atan2(-a2 * sin(theta2), a1 + a2*cos(theta2)) - atan2(sqrt( (a1 + a2*cos(theta2))^2 + (a2*sin(theta2))^2 - xDes^2), xDes);
    end
   
    
end