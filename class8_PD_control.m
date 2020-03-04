clear all;
close all;

k=0.1; %[N/m]
m=1;  %[kg]
f = 10; %[N]
b = 0.1;

F = [0,     1;
     -k/m,  -b/m];
 
G = [0;
     1/m];

Hx = [1,    0;
      0,    1];
  
Hu = [0;
      0];
  
  sys = ss(F, G, Hx, Hu);
  t = 0:0.01:100;
  u = f*ones(size(t));
  u(20:end) = 0;
  
  
  tStep = 0.01;
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
  
  %Parameters
  simTime = 100; %[sec]
  xd = [10; 0];
  kp = 0.5;
  kv = 0.1;
  K = [kp, kv];
  
  xOld = [0; 0];
  
  
  
  for i=0:0.01:simTime
      
     u = K*(xd - xOld);
     xNew = F_d * xOld + G_d * u;
     yNew = Hx_d * xOld + Hu_d * u;
     
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