public class Drum{
    string directory;
    string sampleArray[];
    int pattern[];
    SndBuf buffer => Gain gain => dac;

    fun int GetTheNumberOfSamplesInTheDocument(FileIO document){
        document.open(directory + "!fileList.txt", FileIO.READ);
        int samplesCount;
        for(0 => int i; !document.eof(); i++){
            document => string dump;
            i => samplesCount;
        }
        return samplesCount;
    }

    fun string[] LoadFilenamesIntoSampleArray(FileIO document, int samplesCount)
    {
        string allSamples[samplesCount];
        document.open(directory + "!fileList.txt", FileIO.READ);
        for(0 => int i; i != samplesCount; i++){
            document => allSamples[i];
        }
        return allSamples;
    }

    fun void LoadSamples()
    {
        FileIO totalSamplesDocument;
        GetTheNumberOfSamplesInTheDocument(totalSamplesDocument) => int samplesCount;
        LoadFilenamesIntoSampleArray(totalSamplesDocument, samplesCount) @=> sampleArray;
    }

    fun void LoadRandomSample(int minimumSample, int maximumSample)
    {
        int sampleNum;

        if(minimumSample > maximumSample)
        {
            Math.random2(minimumSample, sampleArray.cap()-1) => sampleNum;
        }
        else
        {
            Math.random2(minimumSample, maximumSample) => sampleNum;
        }

        directory + sampleArray[sampleNum] => buffer.read;
        buffer.samples() => buffer.pos;
    }
}