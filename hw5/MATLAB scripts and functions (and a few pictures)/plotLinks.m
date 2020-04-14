function [] = plotLinks(theta1, theta2)
    % Link lengths
    a1 = 10;
    a2 = 10;

    % Initial point (origin)
    x0 = 0;
    y0 = 0;

    % Point where two links connect
    x1 = a1*cos(theta1);
    y1 = a1*sin(theta1);

    % End effector position
    x2 = x1 + a2*cos(theta1 + theta2);
    y2 = y1 + a2*sin(theta1 + theta2);

    % Store points into array to draw links
    xVals = [x0 x1 x2];
    yVals = [y0 y1 y2];

    
    % Draw line connecting points
    plot(xVals, yVals);
    xlim([-20,20]);
    ylim([-20,20]);
    title("Plotting Links (Joint Angles: " + theta1 + ", " + theta2 + ")");
    

    % Put a point at the origin, middle joint, and end effector (in that
    % order)
    hold on;
    plot(x0,y0,'b*');
    hold on;
    plot(x1,y1,'b*');
    hold on;
    plot(x2,y2,'r*');

    snapnow
end