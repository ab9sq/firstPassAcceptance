get.csv <- function(file = "./data/First Pass Acceptance.csv", month = NULL){
     FPA <- read.csv( file = file,
                      stringsAsFactors = FALSE,
                      col.names = c("sqa",
                                    "project",
                                    "application",
                                    "deliverable",
                                    "version",
                                    "docID",
                                    "status",
                                    "date",
                                    "reason",
                                    "comments"))
     FPA$sqa <- as.factor(FPA$sqa)
     FPA$application <- as.factor(FPA$application)
     FPA$deliverable <- as.factor(FPA$deliverable)
     FPA$status <- as.factor(FPA$status)
     FPA$reason <- as.factor(FPA$reason)
     levels(FPA$reason)[1] <- NA
     FPA$date <- as.Date(FPA$date, format = "%d-%B-%y")
     return(FPA)
}

