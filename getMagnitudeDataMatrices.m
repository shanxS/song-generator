function [XMag yMag outXMag] = getMagnitudeDataMatrices (
                                     timeBinData        \
                                   , outSignal          \
                                   , timeBinNumber      \
                                   , frequencyBinNumber \
                                   , externalFeatures);

    numTrainingData = size(timeBinData, 1);
    
    % rows are instance numbers
    
    % For feature matrix, columns are features
    % features are: 
    % 1. magnitude of current (song, dt, df)
    % 2. average of magnitude for this (song, dt)
    numFeatures = 2;
    
    % features for signal which has to be evaluated
    outXMag = zeros(1, numFeatures);
    outSpectrum = (outSignal(timeBinNumber)).(getFieldName());
    outXMag(1, 1) = abs(outSpectrum(frequencyBinNumber));
    outXMag(1, 2) = abs(mean(outSpectrum));
    
    % training features
    XMag = zeros(numTrainingData, numFeatures);
    for trainingDataNumber = 1:numTrainingData
        signal = timeBinData(trainingDataNumber, :);
        spectrum = (signal(timeBinNumber)).(getFieldName());
        
        XMag(trainingDataNumber, 1) = abs(spectrum(       \
                                     frequencyBinNumber));
        XMag(trainingDataNumber, 2) = abs(mean(spectrum));
    end
    
    yMag = zeros(numTrainingData, 1);
    for trainingDataNumber = 1:numTrainingData
        signal = timeBinData(trainingDataNumber, :);
        spectrum = signal(timeBinNumber + 1).             \
                                         (getFieldName());
        yMag(trainingDataNumber) = abs(spectrum(          \
                                     frequencyBinNumber));
    end
end