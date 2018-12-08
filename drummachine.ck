// ------------------------------//
// CUSTOM CLASS DEFINITIONS
// Tempo
class Tempo{
    dur whole,
    half,
    quarter,
    eighth,
    sixteenth,
    thirtysecond,
    sixtyfourth;
    
    float bpm;
    
    fun void setBPM(float tempo)
    {
        tempo => bpm;
        60.0/(tempo) => float secondsPerBeat;
        secondsPerBeat :: second => quarter;
        quarter*4 => whole;
        whole/2 => half;
        quarter/2 => eighth;
        eighth/2 => sixteenth;
        sixteenth/2 => thirtysecond;
        thirtysecond/2 => sixtyfourth;
    }
}

// Meter
class Meter{
    int length;
    dur note;
}

//Drum
class Drum{
    string directory;
    string sampleArray[];
    SndBuf buffer => Gain gain => dac;
}
// ------------------------------//


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

// Ease of use variables
me.dir()+"samples/SMDrums Multi-Mic (Samples)/" => string drumSamplesDirectory;
me.dir() + "samples/SMD Cymbals Stereo (Samples)/Crash (Samples)/" => string cymbalSamplesDirectory;

// Create Drums
12 => int minimumSample;
CreateDrum(drumSamplesDirectory + "Kik 8-RR/Inside/RR1/", minimumSample*2) @=> Drum insideKick;
CreateDrum(drumSamplesDirectory + "Snare67 NoRing (Samples) 1/1_Top/RR1/", minimumSample*2) @=> Drum topSnare;
CreateDrum(cymbalSamplesDirectory + "Crash 13 (Samples)/RR1/", minimumSample) @=> Drum crashCymbal;

// Set the song BPM
tempo.setBPM(100);

// Define the meter
tempo.quarter => meter.note;
4 => meter.length;

meter.length => int crashCount;

while(meter.length != 0){
    if(meter.length % 2 == 0){
        LoadRandomSample(insideKick, minimumSample*2);
        0 => insideKick.buffer.pos;
    }
    else{
        0 => topSnare.buffer.pos;
    }

    if(meter.length % crashCount == 0){
    <<< "Meter Length: " + meter.length >>>;
        0 => crashCymbal.buffer.pos;
    }
    
    meter.note => now;
    meter.length--;

    if(meter.length == 0){
        Math.random2(1, 7) => meter.length;
        meter.length => crashCount;
    }
}