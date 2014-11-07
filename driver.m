% time in seconds, if not obvious
% feq. in Hz, if not obvious
% all indicies start form 1, no exception
%
%
% datastructres have 1st letter d
%
% songs[] is a 1D array containing following struct
%   struct ("fs", <int value>, "pcm", <1D array of float>) === dSong
function timeBinData = driver 
    
    % mili second
    timeBinLengthMs = 40;
    
    [song1Pcm fs1] = loadSongTrimToOneChannel( \
                                 'fixyou.wav');
    songs(1) = convertSongDataToStruct (song1Pcm, fs1);
    
    [song2Pcm fs2] = loadSongTrimToOneChannel( \
                                 'magic.wav');
    songs(2) = convertSongDataToStruct (song2Pcm, fs2);
    
    timeBinData = calculateTimeBinData (timeBinLengthMs \
                                   , songs);
    
end

function dSongData = convertSongDataToStruct (songPcm, \
                                              fs)
    dSongData = struct ("fs", fs, "pcm", songPcm);
end

function [song fs] = loadSongTrimToOneChannel(name)
    [song fs bps] = wavread(name);
    song = song(:, 1);
end