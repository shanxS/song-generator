function updatedSignal = consolidatePrediction (outSignal\
                                   , timeBinNumber       \
                                   , frequencyBinNumber  \
                                   , outPhase, outMag)

    frequency = outMag * (cos(outPhase) + i*sin(outPhase));
    (outSignal(timeBinNumber).(getFieldName()))(frequencyBinNumber) = frequency;
    
    updatedSignal = outSignal;
end