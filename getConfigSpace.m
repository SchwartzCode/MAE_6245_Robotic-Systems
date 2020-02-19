function [xVals, yVals] = getConfigSpace(t1_min, t1_max, t2_min, t2_max)
    xVals = [];
    yVals = [];

    for i = t1_min:3:t1_max
        for j = t2_min:3:t2_max
            [x,y] = fwdKin3Link(i,j);
            xVals = [xVals, x];
            yVals = [yVals, y];
            
        end
    end
end