%  Quadrotor Control Simulation
%   Authors:   Jonathan Schwartz & Rohan Daran
%   Course:    MAE 6245 - Robotic Systems
%===============================================
% This program simulates the dynamics of a quadrotor, and applies two
% controllers in series. The first controls the angular position of the
% quadrotor with a PD controller. The second (which operates at a tenth of 
% the frequency as the first controller), controls translational position 
% of the quadrotor with an LQR controller. 
% 
% The quadrotor is passed a series of waypoints, and it will navigate to
% them in order. It starts moving to the next waypoint when it's state is
% within a certain margin of error of the desired state (all zeros except
% for translational position, which is the waypoint the quadrotor is trying
% to reach).
%
% The script will end once the quadrotor reaches the last waypoint. At that
% point, state data from the simulation is plotted in 3 separate graphs
% (two are 2D and plot state data versus time, and one is 3D and plots the
% path the quadrotor took). 

clear all;
close all;
clc;

% DEFINING CONSTANTS AND STATE SPACE MATRICES
%=====================================================
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

C = zeros(6,12);
C(1,1) = 1;
C(2,2) = 1;
C(3,3) = 1;
C(4,10) = 1;
C(5,11) = 1;
C(6,12) = 1;

dt = 1/100;
nt = 15000; %kind of a formality since program ends automatically after reaching
            % all waypoints, just make sure it is adequately large
            
% LIST OF WAYPOINTS FOR QUADROTOR TO TRAVERSE
wayPoints = [1 2 3; 4 4 4; 3 2 1];

% INITIAL DEFINITIONS OF STATE AND INPUT VECTORS
finalStateDesired = [0; 0; 0; 0; 0; 0; 0; 0; 0; wayPoints(1,1); wayPoints(1,2); wayPoints(1,3)];
state = zeros(12,1);
input = zeros(4,1);
% INITIAL DEFINITIONS OF ARRAYS FOR LOGGING STATE DATA
stateHist = state;


% =========================================================================
%           !IMPOPRTANT!                  !IMPORTANT!
% =========================================================================
% Below are the things you'll want to change to adjust to change the
% performance of the controllers. Keep in mind that if you adjust one, you
% may have to adjust the other to accomodate the changes.

% DEFINING LQR CONTROLLER CONSTANTS
QdiagVals = [1, 1, 1, 0.1, 0.1, 10, 5e3, 5e3, 5e3, 1000, 1000, 1000];
Q = diag(QdiagVals);
RdiagVals = [1e-5, 1e3, 1e3, 1];
R = diag(RdiagVals);

% CALCULATING LQR GAINS FOR SYSTEM
%   note: increasing the coefficient dt is multiplied by will increase the
%         effect the LQR has over the quadrotor (also means angles will
%         diverge more from zero which increases risk of instability)
LQRgains = lqrd(A,B,Q,R,dt*5);

% GAINS FOR PD CONTROLLER
Kp = -0.4;
Kd = -0.15;

% Largest difference in state desired versus current state that is 
% acceptable. Look at the "finalStateDesired" variable above to get an idea
% of what the controller is aiming for. 
% ALSO -- The 'difference' is computed by finding the absolute value of
% each state variable and its desired value, and then adding all of these
% differences together.
wayPointError = 0.1; 

% This counts what wayPoint the quadrotor is currently navigating towards
wayPointCounter = 1;

% This controls how frequently the LQR controller is used in relation to
% the iterations of the PD controller. In other words, if LQRinterval is
% set to x, for every x iterations of the PD controller there will be 1
% iteration of the LQR controller.
LQRinterval = 10;

% This is the loop that iterates through time as the quadrotor navigates
% towards waypoints.
for i=0:nt 
    if mod(i,LQRinterval)==0 
      stateErr = sum( abs(finalStateDesired - state)); %calculating state error)
      if stateErr < wayPointError && wayPointCounter == length(wayPoints)
          nt = i-1; %adjusting length of nt if last wayPoint is reached before the last iteration
         break;
      elseif stateErr < wayPointError
          wayPointCounter = wayPointCounter + 1;
          finalStateDesired(10:12) = wayPoints(wayPointCounter,:)
      end
      
      % LQR Controller
      stateDot = (A - (B * LQRgains)) * state + B * LQRgains * finalStateDesired;
      newState = stateDot*dt + state;
      stateHist = [stateHist newState]; %logging state values
      state = newState;
      
    else
       % PD controller to keep robot relatively stable
       
       input(2) = Kd*state(4) + Kp*state(1);
       input(3) = Kd*state(5) + Kp*state(2);

       %PD controller passes current state, force/torque control inputs,
       %and time step to an iteration function to calculate next state
       [newState] = updateState(state, input, dt); 
       stateHist = [stateHist newState]; %logging state values
       state = newState;
     
    end
end

t = linspace(0,(nt+2)*dt,nt+2);

% PLOTTING STATE HISTORY %
% Plot 1: Translational Position versus Time
plot(t, stateHist(10,:)); %plotting x vals versus time
hold on;
plot(t, stateHist(11,:)); %plotting y vals versus time
hold on;
plot(t, stateHist(12,:)); %plotting z vals versus time
legend({'x','y','z'}, 'Location','northwest');
xlabel("Time [sec]");
ylabel("Position [m]");

% Plot 2: Rotational Position versus Time
figure();
plot(t, stateHist(1,:)); %plotting phi vals versus time
hold on;
plot(t, stateHist(2,:)); %plotting theta vals versus time
hold on;
plot(t, stateHist(3,:)); %plotting trident vals versus time
legend({'phi', 'theta', 'psi'});
xlabel("Time [sec]");
ylabel("Position [rad]");

% Plot 3: 3D Plot of Quadrotor Trajectory
figure();
scatter3(0,0,0, 'filled');
hold on;
plot3(stateHist(10,:), stateHist(11,:), stateHist(12,:));
hold on;
scatter3(wayPoints(:,1), wayPoints(:,2), wayPoints(:,3), 'filled');    
xlabel("X [m]");
ylabel("Y [m]");
zlabel("Z [m]");
legend({'Initial Position', 'Flight Path', 'Waypoints'});