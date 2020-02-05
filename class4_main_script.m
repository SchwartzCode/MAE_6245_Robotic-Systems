clear all;
close all;

%quatMultiply([1;2;3;0.5],[2;3;1;0.75])

alpha = 0* pi / 180; %60 degrees
beta = 0*pi / 180;  %25 degrees
gamma = 90*pi / 180; %30 degrees

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
q3 = (R_tot(2,1) - R_tot(2,1)) / (4*q4);

q = [q1; q2; q3; q4];
q_inv = [-q(1:3); q(4)];

v=[0;0;1];

v_rot = quatMultiply(quatMultiply(q_inv, [v;0]), q)
