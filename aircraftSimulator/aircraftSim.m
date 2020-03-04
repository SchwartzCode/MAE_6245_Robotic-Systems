%% Program to Simulate 3-DOF Aircraft Kinematics

%% Fix Parameters
V = 50;            % Speed, m/s
tStep = 0.1;        % Time step, s
simTime = 10;       % Total simulation time, s

%% Propagate Equations
oldState = [0, 0, 0];
phi = 40*pi/180;            % Roll angle (rad), control input
figure(1);
hold on;
xLow = -50; xUpp = 500; yLow = -50; yUpp = 500;       % Note that the X and Y axes are inverted for an aircraft
axis([xLow,xUpp,yLow,yUpp]);
% axes equal;
xRange = xUpp - xLow;
yRange = yUpp - yLow;
rangeRatio = xRange/yRange;
for t = 0:tStep:simTime
    newState = aircraftDyn(oldState,V,phi,tStep);
    oldState = newState;
    % Plot image at specified location
    img = imread('sr71.jpg');                   % Load image
    rotDeg = 90+newState(3)*180/pi;             % Angle to Rotate Image by
%     img = imread('ac_black.jpg');                   % Load image
%     rotDeg = 180+newState(3)*180/pi;             % Angle to Rotate Image by
    imgRot = imrotate(img,rotDeg,'nearest','loose');
    picSize = 30;                       % Half the size of picture in SI units (on plot)
    h2 = image([newState(2)-picSize*rangeRatio,newState(2)+picSize*rangeRatio],[newState(1)-picSize,newState(1)+picSize],imgRot);
    pause(0.05);
    set(h2,'Visible','off');
end
