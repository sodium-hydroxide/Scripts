#   packageLoad
#   Purpose:
#       The purpose of this function is to load in 
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ~~~~~~~~~~  ~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       YYYY/MM/DD  N. J. Blair     Original code
#
function packageLoad(x)
    using Pkg
    for i in 1:size(x)[1]
        Pkg.add(x[i])
        using 
    end
end