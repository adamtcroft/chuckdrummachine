// This defines the "groove" class

public class Groove{
    dur baseCountTime;
    float meterCount;
    float meterLength;
    int listOfPatterns[][];
    int pattern[];

    fun int NumberOfPatterns()
    {
        0 => int count;
        FileIO patternDocument;
        patternDocument.open(me.dir() + "grooves/4/4.txt", FileIO.READ);
        while(!patternDocument.eof())
        {
            patternDocument.readLine() => string dumpLine;
            count++;
        }

        return count;
    }

    fun void LoadPatterns()
    {
        NumberOfPatterns() => int patternCount;
        int arraySizer[patternCount][Std.ftoi(meterLength)] @=> listOfPatterns;

        FileIO patternDocument;
        patternDocument.open(me.dir() + "grooves/4/4.txt", FileIO.READ);
        for(0 => int i; i < patternCount; i++)
        {
            int patternDefinition[Std.ftoi(meterLength)];
            for(0 => int i; i < meterLength; i++)
            {
                patternDocument => patternDefinition[i];
            }
            patternDefinition @=> listOfPatterns[i];
        }
    }

    fun void LoadRandomPattern(Drum drum)
    {
        Math.random2(0, listOfPatterns.cap()-1) => int chosenPattern;
        listOfPatterns[chosenPattern] @=> drum.pattern;
    }

    fun void LoadSpecificPattern(Drum drum, int patternNumber)
    {
        if(patternNumber > listOfPatterns.cap()-1)
        {
            LoadRandomPattern(drum);
        }
        else
        {
            listOfPatterns[patternNumber] @=> drum.pattern;
        }
    }
    
    fun void Play(Drum drum)
    {
        if(drum.pattern[Std.ftoi(meterCount)] == 1)
        {
            drum.LoadRandomSample(20, 0);
            0 => drum.buffer.pos;
            <<< "PLAY " + meterCount >>>;
        }

        if(drum.pattern[Std.ftoi(meterCount)] == 0)
        {
            Math.random2(0,8) => int play;
            if(play > 6)
            {
                drum.LoadRandomSample(0, 10);
                0 => drum.buffer.pos;
                <<< "PLAY " + meterCount >>>;
            }
        }
    }
}