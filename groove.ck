// This defines the "groove" class

public class Groove{
    dur baseCountTime;
    float meterCount;
    float meterLength;
    4 => int kick;

    fun void PlayKick(Drum drum)
    {
        <<< "meterLength / 2: " + meterLength/2 >>>;
        if(meterCount % (meterLength/2) == 0){
            0 => drum.buffer.pos;
        }
    }

    fun void PlaySnare(Drum drum)
    {
        if(meterCount % (meterCount/2) == 0){
            <<< "Snare!" >>>;
            0 => drum.buffer.pos;
        }
    }
    
    fun void PlayHat(Drum drum)
    {
        0 => drum.buffer.pos;
    }
}