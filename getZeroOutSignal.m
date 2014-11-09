function newSignal = getZeroOutSignal(timeBinData)
    numTimeBin = length(timeBinData);
    
    signal = timeBinData(1, 1);
    numFrequencyBin = length(signal.(getFieldName()));
    
    for timeBinNumber = 1:numTimeBin
        newSignal(timeBinNumber).(getFieldName()) = zeros(1, numFrequencyBin);
    end
    
end