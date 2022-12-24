# packageLoad.R
#   Purpose:
#       The purpose of this script is to contain the packageLoad function.
#       This checks if a package is installed, then installs it if needed,
#       and then loads it into the project.
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ==========  ============    ==============================
#       2022/08/02  N. J. Blair     Original code
#

# define the packageLoad function
packageLoad <- 
    function(x) {
        for (i in 1:length(x)) {# loop over elements of list
            if (!x[i] %in% installed.packages()) {
                install.packages(x[i])
            }
            library(x[i], character.only = TRUE)
        }
    }
