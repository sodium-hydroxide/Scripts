#   regression
#   Purpose:
#       The purpose of this program is to write a class which performs linear 
#       regression on a dataset. This will take in two arrays containing the 
#       independent and dependent variables and compute the slope and intercept.
#       It will also return the model score, slope of the residuals, and 
#       uncertainties in the coefficients.
#
#       There is an additional method to use the model for other inputs.
#
#       This requires the numpy module.
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ~~~~~~~~~~  ~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       2022/12/21  N. J. Blair     Original code
#
from numpy import sum as np_sum
from numpy import dot as np_dot
from numpy import sqrt as np_sqrt
class regression(object):
    def __init__(self,
                 dependentVariable,
                 independentVariable):
        # Perform the regression
        regOutPut = self.performRegression(
            independentVariable,
            dependentVariable,
            furtherStatistics = True
        )
        # Save the parameters of interest
        self.slope = regOutPut["slope"]
        self.intercept = regOutPut["intercept"]
        self.slopeUncertainty = regOutPut["slopeUncertainty"]
        self.interceptUncertainty = regOutPut["interceptUncertainty"]
        self.score = regOutPut["score"]
        
        # Save the slope of the residuals
        self.residualSlope = self.performRegression(
            independentVariable,
            model["residuals"]
        )["slope"]
        
    
    # This method actually performs the regression calculations. It has the
    # option to only compute the slope and intercept, or compute further values
    # such as r squared.
    def performRegression(self,independent,dependent,furtherStatistics = False):
        # Perform calculations of important components
        xSum = np_sum(independent)
        xSqr = np_dot(independent,independent)
        ySum = np_sum(dependent)
        ySqr = np_dot(dependent,dependent)
        xyProd = np_dot(dependent,independent)
        numObs = independent.shape[0]
        
        # Perform the regression
        delta = (
            numObs * xSqr - (xSum ** 2)
        )
        
        intercept = (
            (xSqr * ySum) -
            (xSum * xyProd)
        ) / delta

        slope = (
            (numObs * xyProd) -
            (xSum * ySum)
        ) / delta
        
        model = {
            "intercept":intercept,
            "slope":slope
        }
        
        # Compute the residuals and score along with uncertainties if desired
        if furtherStatistics:
            residuals = (
                dependent - intercept -
                (slope * independent)
            )
            ssRes = np_dot(residuals,residuals)

            ssTot = xSqr - (xSum ** 2)

            score = (
                1. - (ssRes / ssTot)
            )

            # Calculate uncertainty in slope and intercept
            slopeUncertainty = np_sqrt(
                (numObs * ssRes) / 
                (delta * (numObs - 2))
            )
            interceptUncertainty = np_sqrt(
                (xSqr * ssRes) / 
                (delta * (numObs - 2))
            )
            
            # Save these data to the dictionary
            model["ssRes"] = ssRes
            model["score"] = score
            model["slopeUncertainty"] = slopeUncertainty
            model["interceptUncertainty"] = interceptUncertainty
            model["delta"] = delta
            model["residuals"] = residuals
            
            # Return to user and clean up data
            return model

            del (
                xSum, xSqr, ySqr, ySum, xyProd, delta, slope, model, residuals,
                ssRes, ssTot, score, slopeUncertainty, interceptUncertainty
            )
            
            
        else:
            # Return to user and clean up data
            return model

            del (
                xSum, xSqr, ySqr, ySum, xyProd, delta, slope, model
            )

        
    def model(self,independentVar):
        modelOutput = (
            self.intercept - (self.slope * independentVar)
        )
        
        modelUncertianty = np_sqrt(
            ((independentVar * self.slopeUncertainty) ** 2 ) +
            (self.interceptUncertainty ** 2)
        )
        
        return modelOutput, modelUncertianty
    
    def summary(self):
        return {
            "slope":self.slope,
            "slope_u":self.slopeUncertainty,
            "intercept":self.intercept,
            "intercept_u":self.interceptUncertainty,
            "score":self.score,
            "resSlope":self.residualSlope
        }
