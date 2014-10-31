% timeBinData[timeBinNumber][songNumber] is 2D rows contain songSpectrum for given time bin and columns contain time bins
%   songSpectrum[] is 1D array of values of freq. bin
%
% length of timeBinData is max number of time bins possible

function timeBinData = calculateTimeBinData (           \
                                     timeBinLengthMs    \
                                   , frequencyBinLength \
                                   , songs);

    % stores max number of bins for all songs
    numTimeBin = zeros(1, length(songs));
    for i=1:length(numTimeBin)
        numTimeBin(i) = calculateNumTimeBin(            \
                                        timeBinLengthMs \
                                        , songs(i));
    end
    
    numSongs = length(songs);
    for timeBinNumber = 1:max(numTimeBin)
        for songNumber = 1:numSongs
            
            if (timeBinNumber > numTimeBin(songNumber)) \
                && songNumber == 2
                %keyboard
            end
        
            songSpectrum = calculateSongSpectrum (      \
                                  frequencyBinLength    \
                                 , timeBinNumber        \
                                 , timeBinLengthMs      \
                                 , songs(songNumber));
        
            timeBinData(songNumber, timeBinNumber) =    \
                                    struct ("spectrum"  \
                                         , songSpectrum);
                             
        end
    end

end

function numTimeBin = calculateNumTimeBin(timeBinLengthMs\
                                        , dSong)
    msInSecond = 1000;
    durationInSeconds = length(dSong.pcm)/dSong.fs;
    numTimeBin = msInSecond*durationInSeconds     \
                 / timeBinLengthMs;
    numTimeBin = floor(numTimeBin);
end