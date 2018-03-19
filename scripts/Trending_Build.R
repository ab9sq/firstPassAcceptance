buildTrending <- function(Month = NULL,
                          Year = NULL,
                          file = "./data/First Pass Acceptance.csv",
                          previous = "./data/FPA.RData"){

     # Load functions
     source(file = "./scripts/Monthly_Stats.R")

     # Get months data
     output <- getResults(Month = Month,
                          Year  = Year,
                          file  = file)
     load(file = previous)
     FPA <- rbind(FPA, output)
     save(FPA, file = previous)
     return(FPA)
}