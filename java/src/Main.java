import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

/**
 * Created by shanxS on 11/11/2014.
 */
public class Main {

    static final private String warningHeader = "% this is a computer generated file\n"+
            "% any changes to this file will we overwritten\n";

    public static void main(String args[]){
        Integer frequencyBinCount = null;
        Integer timebinCount = null;

        try{
            timebinCount = Integer.parseInt(args[0]);
            frequencyBinCount = Integer.parseInt(args[1]);

            System.out.println("frequencyBinCount: " + frequencyBinCount + " timebinCount: " + timebinCount);

            generatePredictors(frequencyBinCount, timebinCount);
            generatePredictorExecutor(frequencyBinCount, timebinCount);
        }catch(Exception e){
            System.out.print("Main::main exception: " + e.getMessage());
        }


    }

    private static void generatePredictorExecutor(Integer frequencyBinCount, Integer timebinCount) {
        String octaveScript = "";

        final String line = ";\n";
        final String quotes = "\"";
        final String header = "function predictorExecutor\n" +
                "    \n" +
                "    currentDir = pwd;\n" +
                "    pathOption = strcat(\"--norc --exec-path \\t\", currentDir);\n" +
                "    options = strcat(\"octave \\t\", pathOption, \"\\t --silent --no-window-system --eval\");\n";

        //final String pathValueVariable = "    pathValue = ";
        final String frequencyBinCoutnVariable = "    frequencyBinCount = ";
        final String timeBinCountVaruiable = "    timebinCount = ";

        final String body = "    for timeBinNumber = 1:timebinCount\n" +
                "        for frequencyBinNumber = 1:frequencyBinCount\n" +
                "            \n" +
                "            % run for frequency\n" +
                "            predictorFilename = strcat(\"predictfreqt\",   \\\n" +
                "                               num2str(timeBinNumber),   \\\n" +
                "                               \"f\",                      \\\n" +
                "                           num2str(frequencyBinNumber),  \\\n" +
                "                           \".m\");\n" +
                "                           \n" +
                "            arg = strcat (options, \"\\t\", predictorFilename)\n" +
                "            proc1 = system(arg, false, \"async\");\n" +
                "            \n" +
                "            % run for phase\n" +
                "            predictorFilename = strcat(\"predictphaset\",  \\\n" +
                "                               num2str(timeBinNumber),   \\\n" +
                "                               \"f\",                      \\\n" +
                "                           num2str(frequencyBinNumber),  \\\n" +
                "                           \".m\");\n" +
                "            arg = strcat (options, \"\\t\", predictorFilename);\n" +
                "            proc2 = system(arg, false, \"async\");\n" +
                "            \n" +
                "            if procCount >= maxProc\n" +
                "                killProc(pid);\n" +
                "                procCount = 1;\n" +
                "            else\n" +
                "            \n" +
                "                pid(procCount) = proc1;\n" +
                "                pid(procCount+1) = proc2;\n" +
                "                procCount += 2;\n" +
                "            end\n" +
                "            \n" +
                "            \n" +
                "            if pauseCounter >= maxPauseCount\n" +
                "                sleep(15);\n" +
                "                pauseCounter = 0;\n" +
                "            else\n" +
                "                pauseCounter += 1;\n" +
                "        end\n" +
                "    end\n" +
                "    end\n" +
                "end\n" +
                "\n" +
                "function killProc(pid)\n" +
                "    str = \"\";\n" +
                "    for i=1:length(pid)\n" +
                "        str = strcat(str, \"\\t /PID \\t\", num2str(pid(i)));\n" +
                "    end\n" +
                "    \n" +
                "    sleep(1);\n" +
                "    cmd = strcat(\"taskkill \\t\", str);\n" +
                "    system(cmd, false, \"async\");\n" +
                "end";

        try {
            FileOutputStream out = new FileOutputStream("..\\predictors\\predictorExecutor" + ".m");

            final File f = new File(Main.class.getProtectionDomain().getCodeSource().getLocation().getPath());

            String frequencyBin = frequencyBinCoutnVariable + frequencyBinCount.toString() + line;
            String timeBin = timeBinCountVaruiable + timebinCount.toString() + line;

            octaveScript = warningHeader + header + frequencyBin + timeBin + body;

            out.write(octaveScript.getBytes());
            out.close();

        }catch(Exception e){
            System.out.print("Main::generatePredictors exception: " + e.getMessage());
        }
    }

    private static void generatePredictors(Integer frequencyBinCount, Integer timebinCount){

        String octaveScript = "";

        try {
            for (int timeBinNumber=1; timeBinNumber < timebinCount; ++timeBinNumber) {
                for (int frequencyBinNumber=1; frequencyBinNumber < frequencyBinCount; ++frequencyBinNumber) {
                    FileOutputStream out = new FileOutputStream("..\\predictors\\predictfreqt" + timeBinNumber +
                            "f" + frequencyBinNumber + ".m");
                    octaveScript = getPredictorOctaveScript("freq", timeBinNumber, frequencyBinNumber);
                    out.write(octaveScript.getBytes());
                    out.close();

                    out = new FileOutputStream("..\\predictors\\predictphaset" + timeBinNumber +
                            "f" + frequencyBinNumber + ".m");
                    octaveScript = getPredictorOctaveScript("phase", timeBinNumber, frequencyBinNumber);
                    out.write(octaveScript.getBytes());
                    out.close();
                }
            }
        }catch(Exception e){
            System.out.print("Main::generatePredictors exception: " + e.getMessage());
        }
    }

    private static String getPredictorOctaveScript(String type, int timeBinNumber, int frequencyBinNumber) {

        final String octavePredictorHeader  = "function predict" + type + "t" + timeBinNumber + "f" + frequencyBinNumber+ "\n" +
                "    load ";
        final String octavePredictorBody  = "\n" +
                "    predictedValue = 0;\n" +
                "\n" +
                "    [m n] = size(X);\n" +
                "    X = [ones(m, 1) X];\n" +
                "    initial_theta = zeros(n + 1, 1);\n" +
                "    \n" +
                "    options = optimset('GradObj', 'on', 'MaxIter', 400);\n" +
                "    [theta, cost] = ...\n" +
                "        fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);\n" +
                "        \n" +
                "    predictedValue = [1 in] * theta;\n";

        final String octavePredictorFooter ="    \n" +
                "    save (\"-text\", savePath, \"predictedValue\");\n" +
                "    \n" +
                "    quit;\n" +
                "    \n" +
                "end";

        String script = warningHeader;
        final String folderEscapseSequence = "\\\\";
        String featureFileName;
        String predictedValeFilename;

        script += octavePredictorHeader;

        featureFileName = "\".." +
                folderEscapseSequence + "features" +
                folderEscapseSequence + type +
                "t" + timeBinNumber +
                "f" + frequencyBinNumber +
                "\"";

        script += featureFileName;
        script += octavePredictorBody;

        predictedValeFilename = "    savePath = \".." +
                folderEscapseSequence + "predictedValues" +
                folderEscapseSequence + "out" + type +
                "t" + timeBinNumber +
                "f" + frequencyBinNumber +
                "\"";
        script += predictedValeFilename;

        script += octavePredictorFooter;

        return script;
    }


}
