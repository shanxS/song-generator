function [Xp yp outXp] = getPhaseDataMatrices (timeBinData\
                                   , outSignal            \
                                   , timeBinNumber        \
                                   , frequencyBinNumber   \
                                   , externalFeatures)

    numTrainingData = size(timeBinData, 1);
                                   
    % rows are instance numbers
    
    % For feature matrix, columns are features
    % external features are not yet in corporated
    % features are: 
    % 1. phase of current (song, dt, df)
    % 2. avg phase for this (song, dt)
    numFeatures = 2;
    
    % features for signal which has to be evaluated
    outXp = zeros(1, numFeatures);
    outSpectrum = (outSignal(timeBinNumber)).(getFieldName());
    outXp(1, 1) = arg(outSpectrum(frequencyBinNumber));
    outXp(1, 2) = arg(mean(outSpectrum));
    
    % training features
    Xp = zeros(numTrainingData, numFeatures);
    for trainingDataNumber = 1:numTrainingData
        signal = timeBinData(trainingDataNumber, :);
        spectrum = (signal(timeBinNumber)).(getFieldName());
        
        Xp(trainingDataNumber, 1) = arg(spectrum(         \
                                     frequencyBinNumber));
        Xp(trainingDataNumber, 2) = arg(mean(spectrum));
    end
    
    yp = zeros(numTrainingData, 1);
    for trainingDataNumber = 1:numTrainingData
        signal = timeBinData(trainingDataNumber, :);
        spectrum = signal(timeBinNumber + 1).             \
                                         (getFieldName());
        yp(trainingDataNumber) = arg(spectrum(            \
                                     frequencyBinNumber));
    end
end