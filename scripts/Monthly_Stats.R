getResults <- function(Month = NULL,
                       Year = NULL,
                       file = "./data/First Pass Acceptance.csv"){
# load required functins
     #source(file = "./scripts/FirstPassAcceptance.R")
     getFPA <- function(file = "./data/First Pass Acceptance.csv") {
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
          return(FPA)
     }


     #source(file= "./scripts/Monthly_calculation.R")

     monthStats <- function(input = FPA){
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
                                  | application == "Metrics Library")
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
                                           & version == 1))),
                         subset = deliverable == "Move to Production")$project)) +
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

          # create and outpu results
          results <- data.frame(Projects_Started = number_started,
                                Projects_Completed = system_certs,
                                Reviews_Completed = reviews,
                                Items_Rejected = rejections,
                                First_Pass_Acceptance = FPA)
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