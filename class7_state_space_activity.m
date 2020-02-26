clear all;
close all;

k=0.1; %[N/m]
m=1;  %[kg]
f = 10; %[N]

F = [0,     1;
     -k/m,  0];
 
G = [0;
     1/m];

Hx = [1,    0;
      0,    1];
  
Hu = [0;
      0];
  
  sys = ss(F, G, Hx, Hu);
  t = 0:1:100;
  u = f*ones(size(t));
  u(20:end) = 0;
  
  %lsim(sys,u,t);
  
  tStep = 1;
  sysd = c2d(sys,tStep);
  F_d = sysd.a;
  G_d = sysd.b;
  Hx_d = sysd.c;
  Hu_d = sysd.d;
  
  xOld = [0;0];
  f=10;
  y1Arr = [];
  y2Arr = [];
  tArr = [];
  
  for i=0:1:100
     xNew = F_d * xOld + G_d * f;
     yNew = Hx_d * xOld + Hu_d * f;
     
     y1Arr = [y1Arr; yNew(1)];
     y2Arr = [y2Arr; yNew(2)];
     tArr = [tArr; i];
     
     xOld = xNew;
  end
  
  figure(1);
  hold on;
  plot(tArr, y1Arr);
  plot(tArr, y2Arr);
  legend('Position [m]', 'Velocity [m/s]');