#   rungaKutta4
#   Purpose:
#       The purpose of this function is to implement an RK4 algorithm
#       given the phase velocity and intitial conditions.
#       This function assumes that the system is autonomous. If the solutions
#       to a non-autonomous system are desired, convert to one order higher.
#
#       By default, the system does not output the time intervals, but can
#       if returnTimeVals is set to true
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ~~~~~~~~~~  ~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       2022/12/22  N. J. Blair     Original code
#
function rungaKutta4(
    phaseVelocity,          # Function describing the phase space
    initialValues,          # Initial condition of the system
    timeStep,               # Time step used for RK analysis
    finalTime,              # How long the solution should run
    returnTimeVals = false) # Optional parameter to return the time

    # Save the system order and number of steps

    systemOrder = size(initialValues)[1]
    numberSteps = Int64(ceil(finalTime / timeStep))


    # Initialize array of solutions
    solution = zeros(numberSteps,systemOrder)

    solution[1,:] = initialValues

    for j in 2:numberSteps
        # Save current value
        current = solution[j-1,:]
        # Calculate the four RK4 coefficients
        RK4_k1 = phaseVelocity(current)
        RK4_k2 = phaseVelocity(.+(
            current,
            0.5 * timeStep * RK4_k1
        ))
        RK4_k3 = phaseVelocity(.+(
            current,
            0.5 * timeStep * RK4_k2
        ))
        RK4_k4 = phaseVelocity(.+(
            current,
            timeStep * RK4_k3
        ))

        # Calculate next step
        solution[j,:] = +(current , .*(timeStep / 6. , .+(
            RK4_k1, .*(2.e0,RK4_k2), .*(2.e0,RK4_k3), RK4_k4
        )))
    end

    # Return the solution and possibly the time values
    if returnTimeVals
        return (LinRange(0,finalTime,numberSteps),solution)
    else
        return solution
    end
end