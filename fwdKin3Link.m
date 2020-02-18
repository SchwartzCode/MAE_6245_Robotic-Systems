function [x,y] = fwdKin3Link(theta1, theta2, a1, a2)

x = a1*cos(theta1) + a2*cos(theta1+theta2)
y = a1*sin(theta1) + a2*sin(theta1+theta2)

end