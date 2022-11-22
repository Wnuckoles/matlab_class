% HW Week 8
% Will Nuckoles
% 11/21/2022
% Dr. David Hill
% Matlab Class

clear all
close all
clc

% Create ocean frequencies
period=[10 200 45000];
amp=[.5 .25 1.5];
tstep= 0:.5:604800;

% Create sin waves
waves=amp(1)*sin(((2*pi)/period(1))*tstep);
infgravity=amp(2)*sin((2*pi/period(2))*tstep);
tides=amp(3)*sin(((2*pi)/period(3))*tstep);


combsin=waves + infgravity + tides;
noisy=(.1*sin(randn(size(combsin))))+combsin; % Add some normally distributed noise to the data with amp of .1 m

figure(1);
subplot(4,1,1);
plot(tstep,noisy)
title('Raw Noisy Data');
xlabel('Time (s)');
ylabel('Height (m)')

% Determine frequencies (Hz = 1/period)
Hz1=1/period(1); % Wave frequency (0.1 Hz)
Hz2=1/period(2); % Infragravity frequency (0.005 Hz)
Hz3=1/period(3); % Tides frequency (0.000022 Hz)

% Create cutoff frequencies
Wn1= .001/(Hz1/2);
Wn2= [.0015 .006];
Wn3= 1e-08/(Hz3/2);

% Isolate wave signal

[B,A]=butter(3,Wn1,'high');
yfilt1=filtfilt(B,A,noisy); % Use filtfilt to avoid phase shift during filtering

% Plot results agaisnt unfiltered data
subplot(4,1,2)
plot(tstep, noisy)
hold on
plot(tstep,yfilt1)
xlim([0 40])
ylim([-1 1])
xlabel('Time (s)');
ylabel('Height (m)')
legend('Raw','Wave Filtered')
title('Waves Isolated')
grid on % Filtered results are much closer to a sin wave between -.5 and .5 in amplitude!

% Isolate Infragravity waves
[B,A]=butter(3,Wn2,"bandpass");
yfilt2=filtfilt(B,A,noisy);

% Plot agaisnt raw data
subplot(4,1,3);
plot(tstep, noisy);
hold on
plot(tstep, yfilt2);
xlim([200 800]);
ylim([-.5 .5])
xlabel('Time (s)');
ylabel('Height (m)');
legend('Raw', 'Infragravity Filtered');
title('Infragravity Isolated');
yticks([-.5 -.25 0 .25 .5])
grid on % Again, the filtered results show a sin wave in phase and close to our expected amp of .25

% Isolate tides
[B,A]= butter(3, Wn3, 'low');
yfilt3=filtfilt(B,A,noisy);

% Plot against raw data
subplot(4,1,4);
plot(tstep,noisy);
title('Tides Filtered')
xlim([0 100000])
xlabel('Time (s)');
ylabel('Height (m)');
hold on 
plot(tstep,yfilt3);
legend('Raw', 'Tides Filtered')
yticks([-2 -1.5 -1 -.5 0 .5 1 1.5 2])
grid on % Now we can see (kind of) the tides changing with an amplitude of 1.5 m


set(gcf, 'Position', get(0, 'Screensize'));











