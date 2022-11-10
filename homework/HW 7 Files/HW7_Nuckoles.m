% HW Week 7
% Will Nuckoles
% Dr. David Hill
% 11/10/22

clear all
close all
clc

% Set initial conditions
x0=0;
y0=0;
Vabs0=180;
theta0=40;
u0=Vabs0*cosd(theta0);
v0=Vabs0*sind(theta0);

Y0=[x0 y0 Vabs0 theta0 u0 v0]; % Vector of initial conditions

xspan=[0,10]; % Set domain range

p=[9.81 0 .05]; % Vector of constants


[x,y]=ode45(@trajectory,xspan,Y0,[],p)