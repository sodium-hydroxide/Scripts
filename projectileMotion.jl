#   projectileMotion
#   Purpose:
#       The purpose of this program is to contain a function which will use
#       Euler's method to solve for the range, maximum height, and flight time 
#       for a projectile subjected to linear and quadratic drag forces.
#       This is a rewrite of a previous MATLAB function using julia
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ~~~~~~~~~~  ~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       2022/12/24  N. J. Blair     Original code
#
# Use Linear algebra package
import LinearAlgebra: norm
function ProjectileInfo(
    launchVelocity::Float64,            # Launch speed, m*s^-1
    launchAngle::Float64,               # Angle of launch, degrees
    launchHeight::Float64,              # Initial height, m
    projectileLinearDimension::Float64, # Linear dimension characterizing
                                        # projectile, m
    projectileMass::Float64;            # Mass of projectile, kg
    gravityStrength::Float64 = -9.8,    # Local gravitational acceleration. Set
                                        # to 9.8 m*s^-2 by default
    linearDragBeta::Float64 = 1.6e-4,   # Constant characterizing linear drag at
                                        # STP. Set to 1.6e-4 N*s*m^2
    quadDragGamma::Float64 = 0.25,      # Constant characterizing quadratic drag
                                        # at STP. Set to 0.25 N*s^2*m^2
    integrationTimeStep::Float64=1.e-1  # Timestep used for RK4
    )::NamedTuple{
        (:range, :maxHeight, :flightTime), 
        Tuple{Float64, Float64, Float64}
    }

    # Initialize with current range, height, and time
    range::Float64 = 0.
    currentHeight::Float64 = launchHeight
    maxHeight::Float64 = launchHeight
    flightTime::Float64 = 0.

    # Initialize the velocity
    velocity = launchVelocity .* [cosd(launchAngle), sind(launchAngle)]

    # Calculate the quadratic drag coefficient and linear drag coefficient
    linearCoeff = *(linearDragBeta,projectileLinearDimension)
    quadCoeff = *(quadDragGamma,^(projectileLinearDimension,2))

    # Perform euler's method and update the range, flight time, and height
    while currentHeight > 0.0

        # Update with the range, height, and time
        currentHeight += *(integrationTimeStep, velocity[2])
        range += *(integrationTimeStep, velocity[1])
        flightTime += integrationTimeStep

        # Check if current height is above maximum height, update if needed
        if currentHeight > maxHeight
            currentHeight = maxHeight
        end#if

        # Calculate the acceleration of the object
        acceleration = ObjectForce(linearCoeff,quadCoeff,velocity,
                projectileMass,gravityStrength = gravityStrength) ./ projectileMass
        # Update the velocity
        velocity += .*(acceleration,integrationTimeStep)

    end#while

    output = (
        range = range,
        maxHeight = maxHeight,
        flightTime = flightTime
    )
end#function

function ObjectForce(linearCoeff::Float64,
    quadCoeff::Float64,
    velocity::Vector{Float64},
    projectileMass::Float64;
    gravityStrength::Float64 = -9.8)::Vector{Float64}

    # Calculate the coefficient of the velocity terms in the force
    velocityCoefficient = +(
        linearCoeff,
        quadCoeff * norm(velocity)
    )

    forceX = *(-velocityCoefficient, velocity[1])
    forceY = -(
        *(-velocityCoefficient, velocity[2]),
        gravityStrength * projectileMass
    )

    force = [forceX,forceY]

end#function