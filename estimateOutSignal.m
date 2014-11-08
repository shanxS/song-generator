function outSignal = estimateOutSignal (timeBinData)
    outSignal = getZeroOutSignal (timeBinData);
    
    % get number of time bins we have
    numTimeBin = length(timeBinData);
    
    % get number of freq. bins we have
    numFrequencyBin = length(timeBinData(1, 1).(        \
                                        getFieldName()));
    
    % get number of training data
    numTrainingData = size(timeBinData, 1);
    
    % loop for time
    for timeBinNumber = 1:numTimeBin
    
        % loop for freq
        for frequencyBinNumber = 1:numFrequencyBin
            
            % 2d array for external features. Rows hold instances, columns hold features
            externalFeatures = getExternalFeatures(     \
                                     numTrainingData    \
                                   , timeBinNumber      \
                                   , frequencyBinNumber);
           
            % Xp is feature matrix for phase
            % yp is output matrix for phase
            [Xp yp outXp] = getPhaseDataMatrices (
                                     timeBinData        \
                                   , outSignal          \
                                   , timeBinNumber      \
                                   , frequencyBinNumber \
                                   , externalFeatures);            
            outPhase = predict(Xp, yp, outXp);
            
            
            % XMag is feature matrix for magnitude
            % yMag is output matrix for magnitude
            [XMag yMag outXMag] =                       \
                               getMagnitudeDataMatrices (
                                     timeBinData        \
                                   , outSignal          \
                                   , timeBinNumber      \
                                   , frequencyBinNumber \
                                   , externalFeatures);
            outMag = predict(XMag, yMag, outXMag);
            
            outSingal = consolidatePrediction (outSignal\
                                   , timeBinNumber      \
                                   , frequencyBinNumber \
                                   , outPhase, outMag);
        end
    end
    

end