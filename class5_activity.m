% Easy Way:
%x = [1:10]';
%y = x.*x;
%plot(x,y,'r','Linewidth',2)

% Fancy way:
x = [];
y = [];

for xElem=1:10
    yElem = xElem*xElem;
    x=[x;xElem];
    y=[y;yElem];
end

scatter(x,y,'filled')
xlabel("X Value");
ylabel("Y Value");
title("Scatter Plot Example");


