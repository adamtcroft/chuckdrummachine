// ------------------------------//
// CUSTOM FUNCTIONS
fun Drum CreateDrum(string directory, int minimumSample)
{
    Drum drum;
    directory => drum.directory;
    drum.LoadSamples();
    drum.LoadRandomSample(minimumSample, 0);
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
me.dir() + "samples/SMDrums Multi-Mic (Samples)/" => string drumSamplesDirectory;
me.dir() + "samples/SMD Cymbals Stereo (Samples)/" => string cymbalSamplesDirectory;

// Create Drums
12 => int minimumSample;
CreateDrum(drumSamplesDirectory + "Kik 8-RR/Inside/RR1/", minimumSample*2) @=> Drum insideKick;
CreateDrum(drumSamplesDirectory + "Snare67 NoRing (Samples) 1/1_Top/RR1/", minimumSample*2) @=> Drum topSnare;
CreateDrum(drumSamplesDirectory + "Toms (Samples)/Tom_1 (Samples)/RR1/Top/", minimumSample*2) @=> Drum tom1;
CreateDrum(drumSamplesDirectory + "Toms (Samples)/Tom_2 (Samples)/RR1/Top/", minimumSample*2) @=> Drum tom2;
CreateDrum(drumSamplesDirectory + "Toms (Samples)/Tom_3 (Samples)/RR1/Top/", minimumSample*2) @=> Drum tom3;
CreateDrum(cymbalSamplesDirectory + "Crash (Samples)/Crash 13 (Samples)/RR1/", minimumSample) @=> Drum crashCymbal;
CreateDrum(cymbalSamplesDirectory + "Hi-Hat (Samples)/01 Hat Tight 1/RR1/", 12) @=> Drum hiHat;
CreateDrum(cymbalSamplesDirectory + "Ride (Samples)/Ride 20 (Samples)/RR1/", 12) @=> Drum ride;

// Set the song BPM
tempo.setBPM(100);

// Define the meter
tempo.quarter => groove.baseCountTime;
4.0 => groove.meterLength;
0.0 => groove.meterCount;
groove.LoadPatterns();
groove.LoadRandomPattern(insideKick);

0.5 => topSnare.gain.gain;
0.5 => tom1.gain.gain;

while(true){
    groove.Play(insideKick);
    groove.baseCountTime => now;
    
    groove.meterCount + 1 => groove.meterCount;

    if(groove.meterCount == groove.meterLength)
    {
        4 => groove.meterLength;
        0 => groove.meterCount;
        groove.LoadRandomPattern(insideKick);
    }
}