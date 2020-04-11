function [bestTheta1, bestTheta2] = findAnglesBruteForce(xDes, yDes)
    %Link lengths
    a1 = 10;
    a2 = 10;

    min_err = 1e4; %make this more robust
    bestTheta1 = 0.0;
    bestTheta2 = -90;

    for i = 0:0.01:(pi/2)
        for j = (-pi/2):0.01:(pi/2)
            
            %Find end effector position given specified angles
            x = a1 * cos(i) + a2 * cos(i + j);
            y = a1 * sin(i) + a2 * sin(i + j);

            err = sqrt( (xDes - x)^2 + (yDes - y)^2 );

            if err < min_err
                min_err = err;
                bestTheta1 = i;
                bestTheta2 = j;
            end
        end
    end

end