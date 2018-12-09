// This defines the "groove" class

public class Groove{
    dur baseCountTime;
    float meterCount;
    float meterLength;
    4 => int kick;

    fun void PlayKick(Drum drum)
    {
        if(meterCount % (meterLength/2) == 0){
            0 => drum.buffer.pos;
        }
    }

    fun void PlayCrash(Drum drum)
    {
        if(meterCount % meterLength == 0){
            0 => drum.buffer.pos;
        }
    }

    fun void PlaySnare(Drum drum)
    {
        if(meterCount == (meterLength/2)){
            0 => drum.buffer.pos;
        }
    }
    
    fun void PlayHat(Drum drum)
    {
        if(meterCount % 1 == 0){
            0 => drum.buffer.pos;
        }
    }

    fun void PlayTom1(Drum drum){
        if(meterCount % 1.5 == 0){
            0 => drum.buffer.pos;
        }
    }
}