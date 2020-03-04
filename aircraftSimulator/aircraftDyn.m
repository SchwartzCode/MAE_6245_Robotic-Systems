% Function to Propagate Equations of Motion for Aircraft

function newState = aircraftDyn(oldState, V, phi, tStep)
    
    g = 9.81;               % Gravity, m/s2
    
    newState(1) = oldState(1) + V*tStep*cos(oldState(3));       % X coordinate
    newState(2) = oldState(2) + V*tStep*sin(oldState(3));       % Y Coordinate
    newState(3) = oldState(3) + g*tStep*tan(phi)/V;             % Turn rate
    