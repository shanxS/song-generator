import java.io.FileInputStream;
import java.io.FileOutputStream;

/**
 * Created by shanxS on 11/11/2014.
 */
public class Main {
    public static void main(String args[]){
        Integer frequencyBinCount = null;
        Integer timebinCount = null;

        try{
            timebinCount = Integer.parseInt(args[0]);
            frequencyBinCount = Integer.parseInt(args[1]);

            System.out.println("frequencyBinCount: " + frequencyBinCount + " timebinCount: " + timebinCount);

            generatePredictors(frequencyBinCount, timebinCount);
        }catch(Exception e){
            System.out.print("Main::main exception: " + e.getMessage());
        }


    }

    private static void generatePredictors(Integer frequencyBinCount, Integer timebinCount){

        String octaveScript = "";

        try {
            for (int timeBinNumber=1; timeBinNumber < timebinCount; ++timeBinNumber) {
                for (int frequencyBinNumber=1; frequencyBinNumber < frequencyBinCount; ++frequencyBinNumber) {
                    FileOutputStream out = new FileOutputStream("..\\predictors\\predictfreqt" + timeBinNumber +
                                          "f" + frequencyBinNumber + ".m");
                    octaveScript = getOctaveScript("freq", timeBinNumber, frequencyBinNumber);
                    out.write(octaveScript.getBytes());
                    out.close();

                    out = new FileOutputStream("..\\predictors\\predictphaset" + timeBinNumber +
                            "f" + frequencyBinNumber + ".m");
                    octaveScript = getOctaveScript("phase", timeBinNumber, frequencyBinNumber);
                    out.write(octaveScript.getBytes());
                    out.close();
                }
            }
        }catch(Exception e){
            System.out.print("Main::generatePredictors exception: " + e.getMessage());
        }
    }

    private static String getOctaveScript(String type, int timeBinNumber, int frequencyBinNumber) {

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
        final String octavePredictorFooter = "    \n" +
                "    save (\"-text\", savePath, \"predictedValue\");\n" +
                "    \n" +
                "end";

        String script = "";
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
