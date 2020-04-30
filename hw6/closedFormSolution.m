function [v, w] = closedFormSolution(L1, L2, theta1, theta2, theta3, theta1_dot, theta2_dot, theta3_dot)
    Jv = [-L1*(sin(theta2)*cos(theta3)+sin(theta3)*cos(theta2)) -L2*sin(theta3);
          0                                                      L2;
          L1*(sin(theta2)*sin(theta3)-cos(theta3)*cos(theta2))  -L2*cos(theta3)];
    v = Jv*[theta1_dot; theta2_dot];
    
    Jw = [0 sin(theta3) 0;
          1 0 0;
          0 cos(theta3) 1];
     w = Jw*[theta1_dot; theta2_dot; theta3_dot];
end