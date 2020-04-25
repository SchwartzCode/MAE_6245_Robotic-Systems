clear all;
close all;
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
nt = 1500;

QdiagVals = [1, 1, 1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 1000, 1000, 1000];
Q = diag(QdiagVals);
RdiagVals = 10*[1e-2, 1000, 1000, 1000];
R = diag(RdiagVals);

LQRgains = lqrd(A,B,Q,R,dt*10);
finalStateDesired = [0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 2; 3];

state = zeros(12,1);
input = zeros(4,1);
windDisturbance = zeros(6,1);

stateHist = state;
%state(1) = 1;
%state(5) = 0.1;
%state(6) = 2.5;

Kp_Z = 45;%-0.05;
Kd_Z = 10;%-0.00988;
Kp = 1.4;%0.001;

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
M

for i=0:nt 
    if mod(i,3)==0
      %outer control loop
      stateDot = (A - (B * LQRgains)) * state + B * LQRgains * finalStateDesired;
      goalState = stateDot*dt + state;
      
    end
       % PD controller to keep robot relatively stable
       %inner control loop
       
       
       diffs = goalState - state;
       
       input(1) = Kp_Z*diffs(12) + Kd_Z*diffs(9);
       input(2) = Kp*diffs(4);
       input(3) = Kp*diffs(5);

       newState = updateState(state, input, windDisturbance, dt);
       stateHist = [stateHist newState];
       state = newState;
  
end

t = linspace(0,(nt+2)*dt,nt+2);
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