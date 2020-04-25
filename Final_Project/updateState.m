function [newState] = updateState(state, input, windDisturbance, dt)
    
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

    D = zeros(12,6);
    D(7,1) = 1/m;
    D(8,2) = 1/m;
    D(9,3) = 1/m;
    D(4,4) = 1/Ix;
    D(5,5) = 1/Iy;
    D(6,6) = 1/Iz;
    
    stateDot = A*state + B*input + D*windDisturbance;
    newState = stateDot*dt + state;
end