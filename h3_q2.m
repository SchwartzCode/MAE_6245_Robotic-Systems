clear all;
close all;

L1 = 10; %m
L2 = 10; %m
L3 = 0; %m

theta1 = 45*pi/180; %45 degrees in rad
theta2 = 45*pi/180;
theta3 = 0*pi/180;

DH_params = [pi/2, L1,  0,  theta1;
             0,    L2, 0,  theta2;
             0,    L3, 0,  theta3];
         
for i = 1:3
    if i==1
        transform = genTransform(DH_params(1,1), DH_params(1,2), DH_params(1,3), DH_params(1,4));
    else
        transform = transform * genTransform(DH_params(i,1), DH_params(i,2), DH_params(i,3), DH_params(i,4));
    end
end

pos_example = getEndEffectorPos(transform)



% PLOTTING ENTIRE WORKSPACE

xVals = [];
yVals = [];
zVals = [];

for i=0:3:90
    for j=0:3:90
        for k=-45:3:45
    
            theta1 = i*pi/180; %45 degrees in rad
            theta2 = j*pi/180;
            theta3 = k*pi/180;

            DH_params = [pi/2, L1,  0,  theta1;
                         0,    L2, 0,  theta2;
                         0,    L3, 0,  theta3];
            for n = 1:3
                if n==1
                    transform = genTransform(DH_params(n,1), DH_params(n,2), DH_params(n,3), DH_params(n,4));
                else
                    transform = transform * genTransform(DH_params(n,1), DH_params(n,2), DH_params(n,3), DH_params(n,4));
                end
            end
            pos = getEndEffectorPos(transform);

            xVals = [xVals, pos(1)];
            yVals = [yVals, pos(2)];
            zVals = [zVals, pos(3)];
        end
    end
end

figure(1);
hold on;
scatter3(xVals, yVals, zVals, 'filled');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Manipulator Workspace');

%Plotting Links in specific configuration
DH_params(:,4) = [45*pi/180;
                  30*pi/180;
                  -30*pi/180];
              
pos_log = [0, 0, 0];

for n = 1:3
    if n==1
        transform = genTransform(DH_params(n,1), DH_params(n,2), DH_params(n,3), DH_params(n,4));
        temp_pos = getEndEffectorPos(transform);
        pos_log = [pos_log; temp_pos(1), temp_pos(2), temp_pos(3)];
    else
        transform = transform * genTransform(DH_params(n,1), DH_params(n,2), DH_params(n,3), DH_params(n,4));
        temp_pos = getEndEffectorPos(transform);
        pos_log = [pos_log; temp_pos(1), temp_pos(2), temp_pos(3)];
    end
end

figure(2);
%hold on;
plot3(pos_log(:,1), pos_log(:,2), pos_log(:,3),'Linewidth',5);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Plotting Links');