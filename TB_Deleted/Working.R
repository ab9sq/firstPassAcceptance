length(
     unique(
          subset(
               subset(FPA, subset = (status == "A" | status == "A-FP")),
               subset = deliverable == "Software Change Request")$project))
