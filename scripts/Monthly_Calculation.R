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
                    subset = deliverable == "Move to Production")$project))

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