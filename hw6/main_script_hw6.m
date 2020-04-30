clear all;
close all;
clc;

L1 = 10; % [m]
L2 = 10; % [m]
L3 = 0;  % [m]
theta1 = 30 * pi/180; % [30 degrees in radians]
theta2 = 45 * pi/180; % [45 degrees in radians]
theta3 = 0; % [0 degrees = 0 radians]

R_01 = [cos(theta1) -sin(theta1) 0;
        sin(theta1) cos(theta1) 0;
        0           0            1];

R_12 = [cos(theta2)  0 sin(theta2);
        0            1           0;
        -sin(theta2) 0 cos(theta2)];
    
R_23 = [cos(theta3)  0 sin(theta3);
        0            1           0;
        -sin(theta3) 0 cos(theta3)];

theta_vals = [theta1, theta2, theta3];
theta_dot_vals = [0.3, 0.2, 0.1]; % [rad/sec]
R_mats = [R_01 R_12 R_23];

%R_mats(1:3, 1:3);

rot_axes = [0 0 0;
            1 0 0;
            0 1 1];
        
P_vecs = [0 L1 L2;
          0 0   0;
          0 0   0];
      
d_dot = 0;

v_prop = [0; 0; 0];
w_prop = [0; 0; 0];

for i = 1:length(theta_vals)
    [v_prop, w_prop] = propogateVels(v_prop, w_prop, R_mats(1:3,1+3*(i-1):3+3*(i-1)),rot_axes(1:3,i), theta_dot_vals(i), P_vecs(1:3,i), d_dot);
end
v_prop, w_prop 

[v_CF, w_CF] = closedFormSolution(L1, L2, theta1, theta2, theta3, theta_dot_vals(1), theta_dot_vals(2), theta_dot_vals(3))