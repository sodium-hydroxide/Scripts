#   linearRegresssion
#   Purpose:
#       The purpose of this program is to perform linear regression on a
#       dataset given by two arrays in julia. The function will output a tuple
#       with the slope, intercept, and their uncertainities, along with the
#       coefficient of determination, the sum squared of residuals, and the 
#       slope of the residuals with respect to the independent variable.
#
#       This function requires the following packages to be installed:
#           - 
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ~~~~~~~~~~  ~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       2022/12/22  N. J. Blair     Original code
#       2022/12/25  N. J. Blair     Made the function more strongly typed
#       2023/01/06  N. J. Blair     Removed calculation of y^2 and cleaned up
#                                   some calculations to be more readable.
#
#using Base
function LinearRegression(
    independent::Vector{Float64},
    dependent::Vector{Float64};
    residualCalc::Bool = false
    )::NamedTuple{
        (:slope, :slopeUncertainty, :intercept, :interceptUncertainty,
        :score, :residualSlope), NTuple{6, Float64}
    }
    # Define several important variables which will be used later on
    xSum = independent |> sum
    xSqr = independent .|> (x -> x^2) |> sum
    ySum = dependent |> sum
    xyProd = .*(independent, dependent) |> sum
    numObs = size(independent)[1]

    # Calculate the common denominator and the slope with the intercept
    delta = (numObs * xSqr) - (xSum ^ 2)

    intercept = ((xSqr * ySum) - (xSum * xyProd)) / delta

    slope = ((numObs * xyProd) - (xSum * ySum)) / delta

    # Compute the ssRes, ssTot, score, uncertainities
    if !residualCalc
        # Calculate ssRes, ssTot, and the score
        predictedOutput = .+(intercept, .*(slope, independent))
        residuals = .-(dependent, predictedOutput)

        ssRes = residuals .|> (x -> x^2)  |> sum
        ssTot = xSqr - (xSum ^ 2)

        score = 1. - /(ssRes,ssTot)
        
        # Calculate the error in the slope and intercept
        slopeUncertainty = sqrt(/(
            numObs * ssRes,
            delta * (numObs - 2)
        ))
        interceptUncertainty = sqrt(/(
            xSqr * ssRes,
            delta * (numObs - 2)
        ))

        # Calculate the slope of the residual
        residualSlope = linearRegression(
            independent,residuals;residualCalc = true
            ).slope

        # Save the data to a tuple called model
        model = (
            slope = slope,
            slopeUncertainty = slopeUncertainty,
            intercept = intercept,
            interceptUncertainty = interceptUncertainty,
            score = score,
            residualSlope = residualSlope
        )
        return model

    # Just save the slope and intercept
    else
        model = (
            slope=slope,
            slopeUncertainty = 0.,
            intercept=intercept,
            interceptUncertainty = 0.,
            score = 0.,
            residualSlope = 0.
        )
        return model
    end

end