a = 4;
x = [1,2,3];
y = [4, 5, 6 ,7];

%Inner Product (dot)
dot(x,y(1:3))

%Outer Product
x'*y

%Checking if this matrix is singuler (det=0 if so)
inv(x'*y(1:3))