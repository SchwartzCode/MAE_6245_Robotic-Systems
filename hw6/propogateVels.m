function [v, w] = propogateVels(v_last, w_last, R_mat, rot_axis, theta_dot, P, d_dot)
w = R_mat*w_last + theta_dot*rot_axis;

v = R_mat* (v_last + cross(w_last, P) + d_dot*rot_axis);

end