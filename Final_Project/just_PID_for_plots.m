clear all;
close all;
clc;

g = 9.81; %[m/s^2]
Ix = 0.004856; %kg*m^2
Iy = 0.004856; %kg*m^2
Iz = 0.008801; %kg*m^2
m = 0.468; % mass [kg]

A = zeros(12,12);
A(1,4) = 1;
A(2,5) = 1;
A(3,6) = 1;
A(8,1) = g;
A(7,2) = -g;
A(10,7) = 1;
A(11,8) = 1;
A(12,9) = 1;

B = zeros(12,4);
B(4,2) = 1/Ix;
B(5,3) = 1/Iy;
B(6,4) = 1/Iz;
B(9,1) = 1/m;

dt = 1/100;
nt = 1500; %kind of a formality since program ends automatically after reaching
            % all waypoints, just make sure it is adequately large

QdiagVals = [1, 1, 1, 0.1, 0.1, 10, 5e3, 5e3, 5e3, 1000, 1000, 1000];
Q = diag(QdiagVals);
RdiagVals = 0.001*[1e-2, 10, 10, 1000];
R = diag(RdiagVals);

LQRgains = lqrd(A,B,Q,R,dt*5);
finalStateDesired = [0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 2; 3];
wayPoints = [1 2 3; 4 4 4; 3 2 1];

state = zeros(12,1);
input = zeros(4,1);
windDisturbance = zeros(6,1);


Kp_Z = 8;
Kd_Z = 0.5;

state(1) = 0.5;
Kp = -0.05;
Kd = -0.08;


C = zeros(6,12);
C(1,1) = 1;
C(2,2) = 1;
C(3,3) = 1;
C(4,10) = 1;
C(5,11) = 1;
C(6,12) = 1;
Plant = ss(A,[B B],C,0,-1);
Q = 2.5; 
R = 1;
[kalmf,L,P,M] = kalman(Plant,Q,R);
M;

stateHist = state;

newState = state;
newMeasuredState = zeros(6,1);
measuredStateHist = newMeasuredState;

inputHist = input;


wayPointError = 0.1; %largest difference in state desired versus current state
                      % that is acceptable
posCounter = 1;

for i=0:nt 
           % PD controller to keep robot relatively stable
           %inner control loop


           diffs = finalStateDesired - state;
           
           %input(1) = Kp_Z*diffs(12) + Kd_Z*diffs(9);
           input(2) = Kd*state(4) + Kp*state(1);
           input(3) = Kd*state(5) + Kp*state(2);

           [newState, newMeasuredState] = updateState(state, input, dt);
           stateHist = [stateHist newState];
           newMeasuredState = 0.9*C*(A*stateHist(:,end) + B*inputHist(:,end)) + 0.1*(C*stateHist(:,end));
           measuredStateHist = [measuredStateHist newMeasuredState];
           inputHist = [inputHist input];

           state = newState;
        
  
end

t = linspace(0,(nt+2)*dt,nt+2);

%length(t)
%length(stateHist(10,:))



plot(t, stateHist(10,:)); %plotting x vals versus time
hold on;
plot(t, stateHist(11,:)); %plotting y vals versus time
hold on;
plot(t, stateHist(12,:)); %plotting z vals versus time
legend({'x','y','z'}, 'Location','northwest');
xlabel("Time [sec]");
ylabel("Position [m]");

figure();
plot(t, stateHist(1,:)); %plotting phi vals versus time
hold on;
plot(t, stateHist(2,:)); %plotting theta vals versus time
hold on;
plot(t, stateHist(3,:)); %plotting trident vals versus time
legend({'phi', 'theta', 'psi'});
xlabel("Time [sec]");
ylabel("Position [rad]");

% figure();
% scatter3(0,0,0, 'filled');
% hold on;
% plot3(stateHist(10,:), stateHist(11,:), stateHist(12,:));
% hold on;
% scatter3(wayPoints(:,1), wayPoints(:,2), wayPoints(:,3), 'filled');    
% xlabel("X [m]");
% ylabel("Y [m]");
% zlabel("Z [m]");
% legend({'Initial Position', 'Flight Path', 'Waypoints'});