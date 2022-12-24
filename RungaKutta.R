# RungaKutta.R
#   Purpose:
#       The purpose of this script is to contain an implementation of the 
#       Runga-Kutta algorithm for first order non-autonomous differential
#       equations.
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ~~~~~~~~~~  ~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       2022/08/09  N. J. Blair     Original code
#
# need to use the pracma and tidyverse libraries
library('pracma')
library('tidyverse')

# Initial Definitions ----
# This is the forcing function. It is currently only a function of
    # the current position and time. All other parameters must be 
    # explicitly defined within the function
phaseVelocity <- 
    function(pos,time) {
        return(
            sin(pos[1]*pos[2] - (time ** 2))               
        )
    }

# Define the initial value of the position
initialPosition <- 
    c(0.0,1.0) # this defines dimension of phase space

# Final time to evaluate function
finalTime <- 
    20.0

# integration time step
timeStep <- 
    1.

# Actual computations begin here

# Compute the number of steps to be used 
numSteps <- 
    ceiling(finalTime / timeStep)

# Initialize time and position vectors
timeVec <- pracma::linspace(0,
                            finalTime,
                            n = numSteps)
# redefine timestep due to the rounding used in the cieling term
timeStep <- timeVec[2] - timeVec[1]

posVec <- 
    array(
        data = NA,
        dim = c(
            length(initialPosition),
            numSteps
        )
    )
# Set initial value to the initial value as specified by the problem
posVec[,1] <- initialPosition


# Begin the integration steps
for (
    i in 1:(numSteps - 1) # don't need to evolve after final computation is done
){
    # define the first runga kutta step
    rk1 <- 
        phaseVelocity(pos = 
                          posVec[,i],
                      time = 
                          timeVec[i])
    
    # define the second runga kutta step
    rk2 <- 
        phaseVelocity(pos = 
                          posVec[,i] + ((rk1 / 2.) * timeStep),
                      time = 
                          timeVec[i] + (timeStep / 2.))
    
    # define the third runga kutta step
    rk3 <- 
        phaseVelocity(pos = 
                          posVec[,i] + ((rk2 / 2.) * timeStep),
                      time = 
                          timeVec[i] + (timeStep / 2.))
    
    # define the fourth (and final) runga kutta step
    rk4 <- 
        phaseVelocity(pos = 
                          posVec[,i] + (rk3 * timeStep),
                      time = 
                          timeVec[i] + timeStep)
    
    # after calculating all of these terms, calculate the next term
    
    posVec[,i + 1] <- 
        posVec[,i] + (
            (timeStep / 6.) * (
                rk1 + rk4 + (2. * (rk2 + rk3))
            )
        )
    
}
# Remove intermediate variables
#rm(rk1, rk2, rk3, rk4, numSteps, i, )

plot(timeVec,posVec[1,],
     xlab = 'Time',
     ylab = 'Position',
     main = 'Numerical Solution',
     pch = '.'
     )
