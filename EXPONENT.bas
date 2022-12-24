Attribute VB_Name = "BLAIR_EXPONENT"
' The purpose of this function is to return the exponent of a number if it
' is written in the form:
'   number = mantissa * base^exponent
'
'   Parameters:
'       float:number, number whose exponent is of interest
'       float:base, base of interest for the number
'           defualt value of 10
'
Function EXPONENT( _
    number, _
    Optional ByRef base As Double = 10)

    EXPONENT = Int(Log(Abs(number)) / Log(base))
End Function
