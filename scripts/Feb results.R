source("./scripts/FirstPassAcceptance.R")
got <- get.FPA()
cleaned <- clean.FPA(got)
jan <- process(cleaned, Month = "Jan")
feb <- process(cleaned, Month = "Feb")

#Projects started SCR
number_started_jan <-
     length(unique(subset(
          jan, subset = (((status == "A" | status == "A-FP")
                          &
                               version == 1
          )
          &
               deliverable == "Software Change Request")
     )$project)) +
     length(unique(subset(
          jan,
          subset = ((((status == "A" | status == "A-FP")
                      & version == 1)
                     & (application == "GS Reports"
                        | application == "Metrics Library")
          )
          & deliverable == "Project Plan")
     )$project))

number_started_feb <-
     length(unique(subset(
          feb, subset = (((status == "A" | status == "A-FP")
                          &
                               version == 1
          )
          &
               deliverable == "Software Change Request")
     )$project)) +
     length(unique(subset(
          feb,
          subset = ((((status == "A" | status == "A-FP")
                      & version == 1)
                     & (application == "GS Reports"
                        | application == "Metrics Library")
          )
          & deliverable == "Project Plan")
     )$project))

#Certificates approved
system_certs_jan <- length(unique(
     subset(
          subset(jan,
                 subset = (((status == "A" | status == "A-FP")
                            & version == 1))),
          subset = deliverable == "System Certification Summary")$project)) +
     length(unique(
          subset(
               subset(jan,
                      subset = (((status == "A" | status == "A-FP")
                                 & version == 1))),
               subset = deliverable == "Move to Production")$project))

system_certs_feb <- length(unique(
     subset(
          subset(feb,
                 subset = (((status == "A" | status == "A-FP")
                            & version == 1))),
          subset = deliverable == "System Certification Summary")$project)) +
     length(unique(
          subset(
               subset(feb,
                      subset = (((status == "A" | status == "A-FP")
                                 & version == 1))),
               subset = deliverable == "Move to Production")$project))

#No.of reviews
reviews_jan <- nrow(jan)
reviews_feb <- nrow(feb)

# No of Rejections
rejections_jan <- nrow(subset(jan,
                              subset = status == "D"))

rejections_feb <- nrow(subset(feb,
                              subset = status == "D"))

# % Approved First pass
FPA_jan <- nrow(unique(subset(jan,
                              subset = status == "A-FP"))) /
     nrow(jan) * 100

FPA_feb <- nrow(unique(subset(feb,
                              subset = status == "A-FP"))) /
     nrow(jan) * 100
