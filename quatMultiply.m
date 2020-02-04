function product = quatMultiply(q1, q2)

    product = [q1(4)*q2(1:3) + q2(4)*q1(1:3) + cross(q1(1:3),q2(1:3));
                q1(4)*q2(4) - dot(q1(1:3),q2(1:3))];
                
end