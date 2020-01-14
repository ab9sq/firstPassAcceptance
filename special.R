Month <- "Dec"
Year <- 2019
DivFile <- "./data/Div First Pass Acceptance.csv"

source("./scripts/FirstPassAcceptance.R")
require(lubridate)
require(tidyverse)
hold <- getFPA(file = DivFile)
hold <- cleanFPA(hold)
hold <- process(hold)

temp <- hold %>%
     group_by(year, month, sqa) %>%
     count()



temp$date <- as.Date(paste("1",
                           temp$month,
                           temp$year,
                           sep = "-"),
                     format = "%d-%b-%Y")


holdplot <- ggplot(data = temp, aes(x= date, y=n))
holdplot+geom_line(aes(group = sqa, color = sqa))
ggsave(filename = "interesting.jpg",
       width = 6,
       height = 6,
       units = "in",
       dpi = 600)
