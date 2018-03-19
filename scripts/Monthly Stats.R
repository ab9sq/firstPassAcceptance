source("./scripts/FirstPassAcceptance.R")

getResults <- function(Month = NULL,
                       Year = NULL,
                       file = "./data/First Pass Acceptance.csv"){
if(is.null(Month) | is.na(Month)) {
     stop("Must supply a valid month")
}
     if(is.null(Year) | is.na(Year)) {
          stop("Must supply a valid year")
     }
got <- get.FPA()
cleaned <- clean.FPA(got)
processed <- process(cleaned, Month = Month, Year = Year)


#Projects started SCR
number_started <-
     length(unique(subset(
          processed, subset = (((status == "A" | status == "A-FP")
                          &
                               version == 1
          )
          &
               deliverable == "Software Change Request")
     )$project)) +
     length(unique(subset(
          processed,
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
          subset(processed,
                 subset = (((status == "A" | status == "A-FP")
                            & version == 1))),
          subset = deliverable == "System Certification Summary")$project)) +
     length(unique(
          subset(
               subset(processed,
                      subset = (((status == "A" | status == "A-FP")
                                 & version == 1))),
               subset = deliverable == "Move to Production")$project))

#No.of reviews
reviews <- nrow(processed)

# No of Rejections
rejections<- nrow(subset(processed,
                              subset = status == "D"))


# % Approved First pass
FPA <- nrow(unique(subset(processed,
                              subset = status == "A-FP"))) /
     nrow(processed) * 100

results <- data.frame(Month = Month,
                      Year = Year,
                      Projects_Started = number_started,
                      Projects_Completed = system_certs,
                      Reviews_Completed = reviews,
                      Items_Rejected = rejections,
                      First_Pass_Acceptance = FPA)
return(results)
}