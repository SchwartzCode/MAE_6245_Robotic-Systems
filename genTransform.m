function [T] = genTransform(alpha, a, d, theta, about)

    R_alpha = [1,   0,          0,              0;
               0,   cos(alpha), -sin(alpha),    0;
               0,   sin(alpha), cos(alpha),     0;
               0,   0,          0,              1];

    D_a = [1,   0,  0,  a;
           0,   1,  0,  0;
           0,   0,  1,  0;
           0,   0,  0,  1];
   
    if about == 0
        R_theta = [1,   0,  0,  0;
                   0,   cos(theta), -sin(theta),    0;
                   0,   sin(theta), cos(theta),     0;
                   0,   0,          0,              1];
    elseif about == 1
        R_theta = [cos(theta),  0,  -sin(theta),    0;
                   0,           1,  0,              0;
                   sin(theta),  0,  cos(theta),     0;
                   0,           0,  0,              1];
    elseif about == 2
        R_theta = [cos(theta), -sin(theta),    0,  0;
                   sin(theta), cos(theta),     0,  0;
                   0,          0,              1,  0;
                   0,          0,              0,  1];
    else
        fprintf("ERROR!! 'ABOUT' variable must be either 0, 1, or 2!");
    end

    D_d = [1,   0,  0,  0;
           0,   1,  0,  0;
           0,   0,  1,  d;
           0,   0,  0,  1];
    
    T = R_alpha * D_a * R_theta * D_d;

end