fs = 44100;
timeLength = 100; % in ms
timeScaleFactor = 1000/timeLength; % (ms in a second)/(duration of time in ms)

duration = 1:fs/timeScaleFactor; % for timeLength milisecond

% frequencies set
frequencySet = [1000 5000 10000 18000];

signal = sin (duration * 2*pi * frequencySet(1)/fs) + sin (duration * 2*pi * frequencySet(2)/fs) + sin (duration * 2*pi * frequencySet(3)/fs) + sin (duration * 2*pi * frequencySet(4)/fs); 

completefft = abs(fft(signal));

figure; hold on;
plot(1:timeScaleFactor:fs/2, completefft(:, 1:end/2));
hold off;