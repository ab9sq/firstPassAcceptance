buildTrending <- function(Month = NULL,
                          Year = NULL,
                          file = "./data/First Pass Acceptance.csv",
                          previous = "./data/FPA.RData"){
     # checking inputs
     if(is.null(Month) | is.na(Month)){stop("Month value must be specified")}
     if(is.null(Year) | is.na(Year)){stop("Year value must be specified")}
     if(is.null(file) | is.na(file)){stop("file value must be specified")}
     if(anyNA(previous)){stop("previous value must be specified or NULL")}
     if(!is.null(previous)){
          load(file = previous)
     } else{
          FPA <- NULL
          previous <- "./data/FPA.RData"
     }

     # Load required  functions
     source(file = "./scripts/Monthly_Stats.R")
     # Get months data
     output <- getResults(Month = Month,
                          Year  = Year,
                          file  = file)
     FPA <- rbind(FPA, output)

     save(FPA, file = previous)
     # rm(getResults) need to figure out
     return(FPA)
}