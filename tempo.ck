public class Tempo{
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