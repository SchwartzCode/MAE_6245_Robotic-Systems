clear all;
close all;

a1 = 10;
a2 = 5;
t1 = 0;
t2 = 90;

%fwdKin3Link(t1, t2);
xOut = [];
yOut = [];

[xOut, yOut] = getConfigSpace(0, 90, -90, 90);
[xOut2, yOut2] = getConfigSpace(-90, 90, 0, 90);

figure(1);
hold on;
scatter(xOut, yOut,'filled');
scatter(xOut2, yOut2,'r');
xlabel('X');
ylabel('Y');
legend('case1', 'case2');
title('Manipulator Workspace');