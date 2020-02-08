clear all;
close all;

xAxis = [1;0;0];
yAxis = [0;1;0];
zAxis = [0;0;1];

% FIRST ROTATION
alpha_1 = 10* pi / 180; %10 degrees
beta_1 = 20*pi / 180;  %20 degrees
gamma_1 = 30*pi / 180; %30 degrees

Rx_1 = [1,    0,          0;
        0,    cos(gamma_1), -sin(gamma_1);
        0,    sin(gamma_1), cos(gamma_1)];
  
Ry_1 = [cos(beta_1),    0,  -sin(beta_1);
        0,            1,      0;
        sin(beta_1),    0,  cos(beta_1)];
  
Rz_1 = [cos(alpha_1),   -sin(alpha_1),    0;
        sin(alpha_1),   cos(alpha_1),     0;
        0,            0,              1];

fprintf("Rotation Matrix i: ");
R_1 = Rz_1*Ry_1*Rx_1

fprintf("Inverse of i: ");
inv(R_1)

fprintf("Transpose of ii");
transpose(R_1)

fprintf("SIX CONSTRAINS OF ORTHONORMAL MATRICES:\n");
fprintf("Magnitude of Rows (should be 1 for all):");
norm(R_1(1,:))
norm(R_1(2,:))
norm(R_1(3,:))

fprintf("Row3 = Row1 cross Row2");
R_1(3,:) 
cross(R_1(1,:), R_1(2,:))

% SECOND ROTATION
alpha_2 = 30* pi / 180; %30 degrees
beta_2 = 90*pi / 180;  %90 degrees
gamma_2 = -55*pi / 180; %-55 degrees

Rx_2 = [1,    0,            0;
        0,    cos(gamma_2), -sin(gamma_2);
        0,    sin(gamma_2), cos(gamma_2)];
  
Ry_2 = [cos(beta_2),    0,  -sin(beta_2);
        0,              1,      0;
        sin(beta_2),    0,  cos(beta_2)];
  
Rz_2 = [cos(alpha_2),   -sin(alpha_2),    0;
        sin(alpha_2),   cos(alpha_2),     0;
        0,              0,                1];
  
fprintf("Rotation Matrix ii:");
R_2 = Rz_2*Ry_2*Rx_2


%REVERSE:

beta_input_1 = atan2(R_1(3,1), sqrt(R_1(1,1)^2 + R_1(2,1)^2))*180/pi
alpha_input_1 = atan2(R_1(2,1)/cos(beta_input_1), R_1(1,1)/cos(beta_input_1)) * 180/pi
gamma_input_1 = atan2(R_1(3,2)/cos(beta_input_1), R_1(3,3)/cos(beta_input_1)) * 180/pi


beta_input_2 = atan2(-R_2(3,1), sqrt(R_2(1,1)^2 + R_2(2,1)^2))*180/pi

if(beta_input_2 == 90):
    alpha = 0
    
else if(beta_input_2 == -90):
    %not sure what I'll do here
else:
%alpha_input_2 = atan2(R_2(2,1)/cos(beta_input_2), R_2(1,1)/cos(beta_input_2)) * 180/pi
%gamma_input_2 = atan2(R_2(3,2)/cos(beta_input_2), R_2(3,3)/cos(beta_input_2)) * 180/pi
