function generatePredictors(frequencyBinCount, timeBinCount)

    %TODO: this is crappy - make this better
    
    cd java;
    currentDir = pwd;
    classPath = strcat(pwd, ...
            "\\out\\production\\PredictorGenerator");
            
    execcmd = strcat("java -classpath \t", classPath, ...
            "\t Main",                                ...
            "\t", num2str(timeBinCount),              ...
            "\t", num2str(frequencyBinCount));
            
    system(execcmd, false, "async");

    cd ..
end