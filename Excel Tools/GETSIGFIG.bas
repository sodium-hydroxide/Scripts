Attribute VB_Name = "BLAIR_GETSIGFIG"
' The purpose of this function is to return the number of
' significant digits in a cell.
'
'   Parameters:
'       float:number, number whose number of sigfigs
'           is of interest
'
Function GETSIGFIG(number)

    EXPONENT = Int(Log(Abs(number)) / Log(10))
    mantissa = number / 10 ^ EXPONENT
    
    GETSIGFIG = Len(mantissa) - 1
    
    
End Function
