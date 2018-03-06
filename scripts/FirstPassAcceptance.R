get.FPA <- function(file = "./data/First Pass Acceptance.csv") {
     FPA <- read.csv(
          file = file,
          stringsAsFactors = FALSE,
          col.names = c(
               "sqa",
               "project",
               "application",
               "deliverable",
               "version",
               "docID",
               "status",
               "date",
               "reason",
               "comments"
          )
     )
}


clean.FPA <- function(FPA) {
     #require(lubridate)
     FPA$sqa <- as.factor(FPA$sqa)
     FPA$application <- as.factor(FPA$application)
     FPA$deliverable <- as.factor(FPA$deliverable)
     FPA$status <- as.factor(FPA$status)
     FPA$reason <- as.factor(FPA$reason)
     levels(FPA$reason)[1] <- NA
     FPA$date <- as.Date(FPA$date, format = "%d-%B-%Y")
     return(FPA)
}


process <- function(FPA, Month = NULL, Year = NULL) {
     #require(lubridate)
     FPA$month <- lubridate::month(FPA$date, label = TRUE)
     FPA$year <- lubridate::year(FPA$date)
     FPA$UID <- paste(FPA$project,
                      FPA$deliverable,
                      FPA$docID,
                      FPA$version,
                      sep = "-")
     if (!(is.null(Year))) {
          FPA <- subset(FPA,
                        subset = year == Year)
     }
     if (!(is.null(Month))) {
          # print("Process for not NULL")
          if (Month %in% levels(FPA$month)) {
               FPA <- subset(FPA,
                             subset =  month == Month)
          } else{
               #print("Process for invlad month")
               stop(
                    paste(
                         "Invalid month. Month must be one of the following: NULL,",
                         "Jan,",
                         "Feb,",
                         "Mar,",
                         "Apr,",
                         "May,",
                         "Jun,",
                         "Jul,",
                         "Aug,",
                         "Sep,",
                         "Oct,",
                         "Nov or",
                         "Dec."
                    )
               )
          }
     }
     return(FPA)
}



