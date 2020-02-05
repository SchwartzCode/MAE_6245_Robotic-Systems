clear all;
close all;

xAxis = [1;0;0];
yAxis = [0;1;0];
zAxis = [0;0;1];

alpha = 60* pi / 180; %60 degrees
beta = 45*pi / 180;  %45 degrees
gamma = 30*pi / 180; %30 degrees

Rx = [1,    0,          0;
      0,    cos(gamma), -sin(gamma);
      0,    sin(gamma), cos(gamma)];
  
Ry = [cos(beta),    0,  -sin(beta);
      0,            1,      0;
      sin(beta),    0,  cos(beta)];
  
Rz = [cos(alpha),   -sin(alpha),    0;
      sin(alpha),   cos(alpha),     0;
      0,            0,              1];
  
R_tot = Rz*Ry*Rx;

q4 = 0.5*sqrt(1+R_tot(1,1)+R_tot(2,2)+R_tot(3,3));
q1 = (R_tot(2,3) - R_tot(3,2)) / (4*q4);
q2 = (R_tot(3,1) - R_tot(1,3)) / (4*q4);
q3 = (R_tot(1,2) - R_tot(2,1)) / (4*q4);

q = [q1; q2; q3; q4];
q_inv = [-q(1:3); q(4)];

xNew = quatMultiply(quatMultiply(q_inv, [xAxis;0]), q);
yNew = quatMultiply(quatMultiply(q_inv, [yAxis;0]), q);
zNew = quatMultiply(quatMultiply(q_inv, [zAxis;0]), q);

% ======== PLOTTING ==========
figure(1);
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');

quiver3(0,0,0,xAxis(1), xAxis(2), xAxis(3),'r', 'Linewidth', 2);
quiver3(0,0,0,yAxis(1), yAxis(2), yAxis(3),'g', 'Linewidth', 2);
quiver3(0,0,0,zAxis(1), zAxis(2), zAxis(3),'b', 'Linewidth', 2);

quiver3(0,0,0,xNew(1), xNew(2), xNew(3),'--r', 'Linewidth', 2);
quiver3(0,0,0,yNew(1), yNew(2), yNew(3),'--g', 'Linewidth', 2);
quiver3(0,0,0,zNew(1), zNew(2), zNew(3),'--b', 'Linewidth', 2);

xNew
