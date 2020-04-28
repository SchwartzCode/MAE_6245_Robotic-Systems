function [newState, measuredState] = updateState(state, input, dt)
    
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
    
    D = zeros(12,6);
    D(7,1) = 1/m;
    D(8,2) = 1/m;
    D(9,3) = 1/m;
    D(4,4) = 1/Ix;
    D(5,5) = 1/Iy;
    D(6,6) = 1/Iz;
    
    %Tried to implement a Kalman filter with these signals as noise but
    % couldn't figure out the implementation
    %w = sqrt(0.01)*randn(6,1);
    %v = sqrt(0.2)*randn(6,1);
    
    
    stateDot = A*state + B*input;
    newState = stateDot*dt + state;
    measuredState = C*newState; 
end