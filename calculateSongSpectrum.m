% songSpectrum[] is 1D array of values of freq. bin
% length is equal to total number of frequencyBin possible

function songSpectrum = calculateSongSpectrum ( 
                                       timeBinNumber    \
                                     , timeBinLengthMs  \
                                     , dSong)

    fs = dSong.fs;
    signal = dSong.pcm;
    
    signalWindow = getSignalWindow (timeBinNumber   \
                                  , timeBinLengthMs \
                                  , fs              \
                                  , signal);
    completeSpectrum = fft(signalWindow);
    requiredSpectrum = completeSpectrum(1:end/2, :);
    
    songSpectrum = requiredSpectrum;
end                                            

function signalWindow = getSignalWindow (timeBinNumber   \
                                       , timeBinLengthMs \
                                       , fs              \
                                       , signal)
    msInSecond = 1000;
    samplesInOneMs = floor(fs/msInSecond);
    
    samplesInBin = timeBinLengthMs * samplesInOneMs;
    startingSample = timeBinNumber * samplesInBin;
    endingSample = startingSample + samplesInBin;
    signalLength = length(signal);
    
    if endingSample <= signalLength
        signalWindow = signal(startingSample:             \
                                        endingSample, :);
        signalWindow = signalWindow .* (hanning (length(  \
                                           signalWindow)));
    else
        % if signal is not long enough then treat it as 0
        signalWindow = zeros(samplesInBin, 1);
    end
end                                  