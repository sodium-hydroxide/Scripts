Attribute VB_Name = "BLAIR_ROUNDSIGFIG"
' The purpose of this function is to round a number to the specified number
' of significant digits.
'   Parameters:
'       float:number, number which will be rounded
'       int:sigFigs
'
Function ROUNDSIGFIG(number, sigFigs)
    numExponent = Int(Log(Abs(number)) / Log(10))
    numMantissa = number / (10 ^ numExponent)
    roundedMantissa = Round(numMantissa, sigFigs - 1)
    USR_ROUNDSIGFIG = roundedMantissa * (10 ^ numExponent)
End Function
