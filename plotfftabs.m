function requiredfft = plotfftabs(fs, timeLength, signal)
% fs in Hz
% timeLength in milisecond and less than 1000
% signal at that fs and of timeLength duration


timeScaleFactor = 1000/timeLength; % (ms in a second)/(duration of time in ms)

duration = 1:fs/timeScaleFactor; % for timeLength milisecond

completefft = fft(signal);
requiredfft = completefft(:, 1:end/2);


figure; hold on;
plot(1:timeScaleFactor:fs/2, abs(requiredfft));
hold off;

end
