// ------------------------------//
// CUSTOM FUNCTIONS
fun int GetTheNumberOfSamplesInTheDocument(FileIO document, string directory){
    document.open(directory + "!fileList.txt", FileIO.READ);
    int samplesCount;
    for(0 => int i; !document.eof(); i++){
        document => string dump;
        i => samplesCount;
    }
    return samplesCount;
}

fun string[] LoadFilenamesIntoSampleArray(FileIO document, string directory, string samples[])
{
    document.open(directory + "!fileList.txt", FileIO.READ);
    for(0 => int i; i != samples.cap(); i++){
        document => samples[i];
    }
    return samples;
}

fun string[] LoadSamples(string directory)
{
    FileIO totalSamplesDocument;
    GetTheNumberOfSamplesInTheDocument(totalSamplesDocument, directory) => int samplesCount;
    string samples[samplesCount];
    LoadFilenamesIntoSampleArray(totalSamplesDocument, directory, samples) @=> samples;
    return samples;
}

fun void LoadRandomSample(Drum drum, int minimumSample)
{
    Math.random2(minimumSample, drum.sampleArray.cap()-1) => int sampleNum;
    drum.directory + drum.sampleArray[sampleNum] => drum.buffer.read;
    drum.buffer.samples() => drum.buffer.pos;
}

fun Drum CreateDrum(string directory, int minimumSample)
{
    Drum drum;
    directory => drum.directory;
    LoadSamples(drum.directory) @=> drum.sampleArray;
    LoadRandomSample(drum, minimumSample);
    return drum;
}
// ------------------------------//


// ------------------------------//
// BEGIN DRUM MACHINE
8000 => Math.RANDOM_MAX;
Math.srandom(Math.random());

// Create tempo and meter objects
Tempo tempo;
Meter meter;
Groove groove;

// Ease of use variables
me.dir()+"samples/SMDrums Multi-Mic (Samples)/" => string drumSamplesDirectory;
me.dir() + "samples/SMD Cymbals Stereo (Samples)/" => string cymbalSamplesDirectory;

// Create Drums
12 => int minimumSample;
CreateDrum(drumSamplesDirectory + "Kik 8-RR/Inside/RR1/", minimumSample*2) @=> Drum insideKick;
CreateDrum(drumSamplesDirectory + "Snare67 NoRing (Samples) 1/1_Top/RR1/", minimumSample*2) @=> Drum topSnare;
CreateDrum(cymbalSamplesDirectory + "Crash (Samples)/Crash 13 (Samples)/RR1/", minimumSample) @=> Drum crashCymbal;
CreateDrum(cymbalSamplesDirectory + "Hi-Hat (Samples)/01 Hat Tight 1/RR1/", 12) @=> Drum hiHat; 

// Set the song BPM
tempo.setBPM(100);

// Define the meter
tempo.eighth => groove.baseCountTime;
4.0 => groove.meterLength => groove.meterCount;

0.5 => topSnare.gain.gain;

while(groove.meterCount >= 0){
    if(groove.meterCount % 1 == 0){
        <<< "Beat: " + groove.meterCount >>>;
    }
    groove.PlayKick(insideKick);
    groove.PlaySnare(topSnare);
    groove.PlayHat(hiHat);
    
    groove.baseCountTime => now;
    groove.meterCount - .5 => groove.meterCount;

    if(groove.meterCount == 0){
        //4 => groove.meterLength => groove.meterCount;
        Math.random2(1, 9) => groove.meterLength => groove.meterCount;
        <<< "Meter Length: " + groove.meterLength >>>;
    }
}