function [x,y] = fwdKin3Link(theta1, theta2)
a1 = 10;
a2 = 5;

theta1 = theta1*pi/180;
theta2 = theta2*pi/180;

x = a1*cos(theta1) + a2*cos(theta1+theta2);
y = a1*sin(theta1) + a2*sin(theta1+theta2);

end

