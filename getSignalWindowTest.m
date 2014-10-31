function signalWindow =                                  \
                     getSignalWindowTest(timeBinNumber   \
                                       , timeBinLengthMs \
                                       , fs              \
                                       , signal)
    msInSecond = 1000;
    samplesInOneMs = floor(fs/msInSecond);
    
    samplesInBin = timeBinLengthMs * samplesInOneMs;
    startingSample = timeBinNumber * samplesInBin;
    endingSample = startingSample + samplesInBin;
    signalLength = length(signal);
    keyboard
    if endingSample <= signalLength
        signalWindow = signal(startingSample:             \
                                        endingSample, :);
        signalWindow = signalWindow .* (hanning (length(  \
                                           signalWindow)));
    else
        % if signal is not long enough then treat it as 0
        keyboard
        signalWindow = zeros(samplesInBin, 1);
    end
end                                  