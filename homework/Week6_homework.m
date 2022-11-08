% HW Week 6
% Will Nuckoles
% Matlab for ES
% 11/3/2022

clear all
close all
clc

% Copy in data
data= [.073 57.12; .44 75.78; .81 83.77; 1.19 89.58; 1.56 94.16; 1.93 97.99; 2.3 100.81; 2.67 102.13; 3.04 102.62];
y=data(:,1);
u=data(:,2);
k=.4; %Von karmen constant
v=.01; %Kinematic viscosity of water
Usz=[0:.1:10]; %Specifies range to analyze over

% Create smooth log function where Up is shear velocity
smooth_log= @(Up,y) (Up/k)*(((1/.4)*log((y*Up)/.01)));
u1=nlinfit(y,u,smooth_log,3); % returns best shear velocity, u1 starting with shear velocity of 3.  Tried a few other values and it didn't seem to make much difference

figure('name','Smooth_log');
plot(u,y,'x');
hold on
plot(smooth_log(u1,Usz),Usz);



% Part 2

rough_wall=@(stars,y) stars(1)*((1/k)*log(y/stars(2))+8.5);
u2=nlinfit(y,u,rough_wall,[3,.012]); % Calls rough wall function and starts shear velocity at 3 and roughness height at .012 which is average for a concrete pipe

% Add rough wall and format plot
plot(rough_wall(u2,Usz),Usz)
legend('real data','smooth fit','rough wall fit','location','northwest');
title('Comparison of log fits');
xlabel('flow velocity (cm/s)');
ylabel('Water height (cm)');
ylim([0 3.5]);

% Display answers to command window
smooth_ans=['Smooth wall shear velocity= ',num2str(u1),' cm/s'];
rough_ans= ['Rough wall shear velocity= ', num2str(u2(1)),' cm/s'];
rough_height=['Roughness height= ', num2str(u2(2)),' cm'];
disp(smooth_ans)
disp(rough_ans)
disp(rough_height)








