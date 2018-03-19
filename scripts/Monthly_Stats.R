getResults <- function(Month = NULL,
                       Year = NULL,
                       file = "./data/First Pass Acceptance.csv"){
# load required functins
     source("./scripts/FirstPassAcceptance.R")
     source("./scripts/Monthly_Calculation.R")

# Test for inputed values
     if(is.null(Month) | is.na(Month)) {
          stop("Must supply a valid month")
     }

     if(is.null(Year) | is.na(Year)) {
          stop("Must supply a valid year")
     }

# obtain and clean data
     got <- getFPA()
     cleaned <- cleanFPA(got)
     processed <- process(cleaned, Month = Month, Year = Year)

# Get statistics
     results <- monthStats(input = processed)

# create and output results
     series <- data.frame(Month = Month,
                          Year = Year)
     results <- cbind(series, results)
     return(results)
}