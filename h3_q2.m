clear all;
close all;

L1 = 10; %m
L2 = 10; %m
L3 = 0; %m

theta1 = 45*pi/180; %45 degrees in rad
theta2 = 0*pi/180;
theta3 = 0*pi/180;

DH_params = [0, L1,  0,  theta1;
             0, L2, 0,  theta2;
             0, L3, 0,  theta3];
         
DH_params(1,:)

for i = 1:3
   if i==1
       transform = genTransform(DH_params(i,1), DH_params(i,2), DH_params(i,3), DH_params(i,4), 1);
   else
      transform = transform* genTransform(DH_params(i,1), DH_params(i,2), DH_params(i,3), DH_params(i,4), 2);
   end
       
end

transform
pos = getEndEffectorPos(transform);
