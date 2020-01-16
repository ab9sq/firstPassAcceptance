getResultsCombined <- function(Month = NULL,
                       Year = NULL,
                       File1 = "./data/Div First Pass Acceptance.csv",
                       File2 = "./data/Dallas First Pass Acceptance.csv"
                       File3 = "./data/Wiesbaden First Pass Acceptance.csv"){
     # load required functins
     #source(file = "./scripts/FirstPassAcceptance.R")
     getFPA <- function(file = "./data/Div First Pass Acceptance.csv") {
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

     cleanFPA <- function(FPA) {
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
                    #print("Process for invalid month")
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
          FPA$application <- droplevels(FPA$application)
          FPA$sqa <- droplevels(FPA$sqa)
          FPA$deliverable <- droplevels(FPA$deliverable)
          FPA$status <- droplevels(FPA$status)
          FPA$reason <- droplevels(FPA$reason)
          return(FPA)
     }


     #source(file= "./scripts/Monthly_calculation.R")

     monthStats <- function(input){
          #Projects started SCR
          number_started <-
               length(unique(subset(
                    input, subset = (((status == "A" | status == "A-FP")
                                      &
                                           version == 1
                    )
                    &
                         deliverable == "Software Change Request")
               )$project)) +
               length(unique(subset(
                    input,
                    subset = ((((status == "A" | status == "A-FP")
                                & version == 1)
                               & (application == "GS Reports"
                                  | application == "Metrics Library"
                                  | application == "Poser BI")
                    )
                    & deliverable == "Project Plan")
               )$project))

          #Certificates approved
          system_certs <- length(unique(
               subset(
                    subset(input,
                           subset = (((status == "A" | status == "A-FP")
                                      & version == 1))),
                    subset = deliverable == "System Certification Summary")$project)) +

               length(unique(
                    subset(
                         subset(input,
                                subset = (((status == "A" | status == "A-FP")
                                           & version == 1
                                           &(application == "GS Reports"
                                             | application =="Metrics Library"
                                             | application =="Power BI")))),
                         subset = deliverable == "Move to Production")$project))+

               length(unique(
                    subset(
                         subset(input,
                                subset = (((status == "A" | status == "A-FP")
                                           & version == 1))),
                         subset = deliverable == "Decommissioning Report")$project))

          #No.of reviews
          reviews <- nrow(input)

          # No of Rejections
          rejections<- nrow(subset(input,
                                   subset = status == "D"))

          # % Approved First pass
          FPA <- nrow(unique(subset(input,
                                    subset = status == "A-FP"))) /
               nrow(input) * 100
          FPA <- round(FPA, 1)

          # rejection rate
          reject <- rejections/
                  nrow(input) * 100
          reject <- round(reject, 1)

          # create and outpu results
          results <- data.frame(Projects_Started = number_started,
                                Projects_Completed = system_certs,
                                Reviews_Completed = reviews,
                                Items_Rejected = rejections,
                                First_Pass_Acceptance = FPA,
                                Rejection_Rate = reject)
          return(results)
     }

     # Test for inputed values
     if(is.null(Month) | is.na(Month)) {
          stop("Must supply a valid month")
     }

     if(is.null(Year) | is.na(Year)) {
          stop("Must supply a valid year")
     }

     # obtain and clean data
     got1 <- getFPA(file = File1)
     got2 <- getFPA(file = File2)
     got3 <- getFPA(file = File3)
     got <- rbind(got1,got2)
     got <- rbind(got,got3)

     cleaned <- cleanFPA(got)
     processed <- process(cleaned, Month = Month, Year = Year)

     # Get statistics
     results <- monthStats(input = processed)

     # create and output results
     series <- data.frame(Month = Month,
                          Year = Year,
                          stringsAsFactors = FALSE)
     results <- cbind(series, results)
     return(results)
}