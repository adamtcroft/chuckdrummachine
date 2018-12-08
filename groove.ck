// This defines the "groove" class

public class Groove{
    4 => int kick;

    fun int PlayKick(int currentBeat)
    {
        if(currentBeat % kick == 0){
            return 1;
        }
        else{
            return 0;
        }
    }
}