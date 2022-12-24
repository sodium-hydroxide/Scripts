#   topasParse
#   Purpose:
#       The purpose of this function is to read a topas csv file for one of the
#       tallies and reformat in a more readable fasion. The statistics for each
#       energy bin are stored consecutively leading to difficulties with parsing
#       the information. This will output the corresponding csv. The inputs
#       include the tally name, the location of the datafile, an array
#       containing the measured statistics, and the energy range. There is the
#       option to provide an aditional title including the name of the run
#       and date information if desired. By default, the program assumes that
#       only the mean and standard deviation are being measured.
#
#   Record of revisions:
#       Date        Programmer      Description of change
#       ~~~~~~~~~~  ~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#       2022/12/23  N. J. Blair     Original code
#
using DataFrames
using CSV
using DelimitedFiles
function topasParse(inputName::String,
    energyMin_MeV::Float64,
    energyMax_MeV::Float64;
    measuredStatistics::Vector{String} = ["Mean","StDev"],
    saveDataFrame = false,
    outputName::String = "tally.csv")

    # Read in the csv as an array
    allData = transpose(readdlm(inputName,','))
    # Save the number of statistics being measured
    numberOfStatistics = size(measuredStatistics)[1]

    # Topas includes an underflow and overflow bin for the energy binning.
    # This will test if the Correct number of bins are in place and will save
    # the bin number
    if mod(size(allData)[1],numberOfStatistics) != 0
        println("FATAL ERROR: Incorrect statistics given!")
        exit()
    else
        numBins = div(size(allData)[1],numberOfStatistics)
    end#if

    # Create array with the upper bound of energy for each of the bins. This
    # will also create a bin ID system. The underflow bin is the first element
    # and has a max energy at 
    binLowerEnergy_MeV = zeros(numBins)
    binUpperEnergy_MeV = zeros(numBins)
    binLowerEnergy_MeV[1] = -Inf64
    binUpperEnergy_MeV[1] = energyMin_MeV
    binWidth = /(energyMax_MeV - energyMin_MeV, numBins - 2)

    for j in 2:(numBins-1)
        binUpperEnergy_MeV[j] = (
            binUpperEnergy_MeV[j-1] + binWidth
        )
        binLowerEnergy_MeV[j] = binUpperEnergy_MeV[j-1]
    end#for
    binUpperEnergy_MeV[lastindex(binUpperEnergy_MeV)] = Inf64
    binLowerEnergy_MeV[lastindex(binLowerEnergy_MeV)] = energyMax_MeV

    # This will reshape the data so each satistic is on its own row
    # Then it will transpose the data so that each statistics is its own
    # column and convert to an Array type. Finally it will create a dataframe
    # whose column names are the statistics.
    df = DataFrame(Array(transpose(reshape(
        allData,(numberOfStatistics,numBins)
        ))),measuredStatistics)

    # Prepend the lower and upper energy and bin id to the dataframe
    insertcols!(df,1,:binUpperEnergy_MeV => binUpperEnergy_MeV)
    insertcols!(df,1,:binLowerEnergy_MeV => binLowerEnergy_MeV)

    if saveDataFrame
        CSV.write(outputName,df)
        println("DataFrame has been saved!")
    else
        return df
    end#if
end#function
