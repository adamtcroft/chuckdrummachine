// CLASS DEFINITIONS
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

fun int GetTheNumberOfSamplesInTheDocument(FileIO document){
    int samplesCount;
    for(0 => int i; !document.eof(); i++){
        document => string dump;
        i => samplesCount;
    }
    return samplesCount;
}

// BEGIN DRUM MACHINE

8000 => Math.RANDOM_MAX;
Math.srandom(Math.random());

// Create tempo and meter objects
Tempo tempo;
Meter meter;

// Ease of use variables
me.dir()+"samples/SMDrums Multi-Mic (Samples)/" => string drumSamplesDirectory;
drumSamplesDirectory + "Kik 8-RR/Inside/RR1/" => string insideKickDirectory;
drumSamplesDirectory + "Snare67 NoRing (Samples) 1/1_Top/RR1/" => string topSnareDirectory;

me.dir() + "samples/SMD Cymbals Stereo (Samples)/Crash (Samples)/" => string cymbalSamplesDirectory;
cymbalSamplesDirectory + "Crash 13 (Samples)/RR1/" => string crashCymbalDirectory;

// Set the song BPM
tempo.setBPM(100);

// Define the meter
tempo.quarter => meter.note;
4 => meter.length;

// Setup the samples
FileIO kickSamplesDocument;
kickSamplesDocument.open(insideKickDirectory + "!fileList.txt", FileIO.READ);
GetTheNumberOfSamplesInTheDocument(kickSamplesDocument) => int samplesCount;

string kickSamples[samplesCount];


kickSamplesDocument.open(insideKickDirectory + "!fileList.txt", FileIO.READ);
for(0 => int i; i != samplesCount; i++){
    kickSamplesDocument => kickSamples[i];
}

SndBuf kick => dac;
fun void loadKick(int sampleNum){
    insideKickDirectory + kickSamples[sampleNum] => kick.read;
    kick.samples() => kick.pos;
    <<< "Loaded kick sample: " + sampleNum >>>;
}
loadKick(Math.random2(24, kickSamples.cap()-1));

SndBuf snare => dac;
topSnareDirectory + "32_Snr67_NR_Top_RR1.wav" => snare.read;
snare.samples() => snare.pos;

SndBuf crash => dac;
crashCymbalDirectory + "22_Crash_13in_R_edge_RR1.wav" => crash.read;
crash.samples() => crash.pos;
meter.length => int crashCount;


while(meter.length != 0){
    Math.random2(24, kickSamples.cap()-1) => int randomKick;
    <<< "Kick Sample: " + randomKick >>>;
    if(meter.length % 2 == 0){
        loadKick(randomKick);
        0 => kick.pos;
    }
    else{
        0 => snare.pos;
    }

    if(meter.length % crashCount == 0){
    <<< "Meter Length: " + meter.length >>>;
        0 => crash.pos;
    }
    
    meter.note => now;
    meter.length--;

    if(meter.length == 0){
        Math.random2(1, 7) => meter.length;
        meter.length => crashCount;
    }
}