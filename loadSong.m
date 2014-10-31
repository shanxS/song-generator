% sampling frequency in Hz
fs = 44100;

% read song and get channel 1 only
song = wavread('fixyou.wav');
song = song(:, 1);

% duration of 100ms
timeLength = 100;
duration = fs/(1000/timeLength);

plotfftabs(fs, timeLength, song(1:duration, :)');
