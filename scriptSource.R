# scriptSource.R
#   Purpose:
#       The purpose of this script is to contain the script source function
#       that sources all scripts used.
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ==========  ============    ==============================
#       2022/08/09  N. J. Blair     Original code
#

# define the scriptSource function
scriptSource <- 
    function(x) {
        for (i in 1:length(x)) {# loop over elements of list
            source(x[i])
        }
    }