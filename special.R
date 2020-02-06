Month <- "Jan"
Year <- 2020

source("./scripts/FirstPassAcceptance.R")
require(lubridate)
require(tidyverse)
Div <- getFPA(file = "./data/Div First Pass Acceptance.csv")
Div <- cleanFPA(Div)
Div <- process(Div)
Div$Site <- "LC/Div"

Dallas <- getFPA(file = "./data/Dallas First Pass Acceptance.csv")
Dallas <- cleanFPA(Dallas)
Dallas <- process(Dallas)
Dallas$Site <- "Dallas"

Wiesbaden <- getFPA(file = "./data/Wiesbaden First Pass Acceptance.csv")
Wiesbaden <- cleanFPA(Wiesbaden)
Wiesbaden <- process(Wiesbaden)
Wiesbaden$Site <- "Wiesbaden"

hold <- rbind(Div,
              Dallas,
              Wiesbaden)

Work <- hold %>%
     group_by(year, month, sqa) %>%
     count()

Effort <- hold %>%
        group_by(year, month, sqa) %>%
        count() %>%
        filter((year == 2020 & month == "Jan"))
Effort

Work$date <- as.Date(paste("1",
                           Work$month,
                           Work$year,
                           sep = "-"),
                     format = "%d-%b-%Y")
Work <- Work %>%
        filter(date <= as.Date("31-Jan-2020",
                               format = "%d-%b-%Y"))

holdplot <- ggplot(data = Work, aes(x= date, y=n))


holdplot+geom_line(aes(group = sqa, color = sqa))
ggsave(filename = "interesting.jpg",
       width = 6,
       height = 6,
       units = "in",
       dpi = 600)
