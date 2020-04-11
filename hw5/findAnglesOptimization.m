function [f] = findAnglesOptimization(inputs)

    %Link lengths
    a1 = 10;
    a2 = 10;
    
    % Read in inital guess
    thetas = inputs(1:2);

    %Desired End Effector Position
    global xDesired;
    global yDesired;

    xDes = xDesired;
    yDes = yDesired;  

    %Find end effector position given specified angles
    x = a1 * cos(thetas(1)) + a2 * cos(thetas(1) + thetas(2));
    y = a1 * sin(thetas(1)) + a2 * sin(thetas(1) + thetas(2));
    
    %Calculate Mean Squared Error of attempted solution
    f = sqrt( (xDes - x)^2 + (yDes - y)^2 );
end