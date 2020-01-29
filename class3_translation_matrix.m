xOld = [1;1;0];
%plotv(xOld);
theta = pi / 6; %30 degrees
q = [0; 0; 0]; %translation vector

T = [cos(theta), -sin(theta),   0,  q(1);
     sin(theta), cos(theta),    0,  q(2);
     0,          0,             1,  q(3);
     0,          0,             0,  1];
 
xOldAug = [xOld; 1];

xNewAug = T*xOldAug;
xNew = xNewAug(1:3);
        
figure(1);
hold on;
plotv(xOld);
plotv(xNew);

%============ INVERTING THE GENERAL TRANSFORM MATRIX =========
T_inv = [T(1:3,1:3)', -T(1:3,1:3)*q;
         0,     0,        0,      1]
