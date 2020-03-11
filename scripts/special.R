Month <- "Feb"
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
        arrange(desc(n)) %>%
        filter((year == 2020 & month == "Feb"))
Effort

Work$date <- as.Date(paste("1",
                           Work$month,
                           Work$year,
                           sep = "-"),
                     format = "%d-%b-%Y")
Work <- Work %>%
        filter(date <= as.Date("29-Feb-2020",
                               format = "%d-%b-%Y"))

holdplot <- ggplot(data = Work, aes(x= date, y=n))


holdplot+geom_line(aes(group = sqa, color = sqa))

Docs <- hold %>%
        group_by(year, month, Site, deliverable) %>%
        count() %>%
        arrange(Site, desc(n)) %>%
        filter((year == 2020 & month == "Feb"))
Docs

sites <- hold %>%
        group_by(year, month, Site) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == 2020 & month == "Feb"))
sites
deliver <- hold %>%
        group_by(year, month, deliverable) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == 2020 & month == "Feb"))
deliver

status <- hold %>%
        group_by(year, month, status) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == 2020 & month == "Feb"))
status



write_csv(Effort, path = "./Monthly/Individuals.csv")
write_csv(Docs, path = "./Monthly/Documents.csv")
write_csv(sites, path = "./Monthly/sites.csv")
write_csv(deliver, path = "./Monthly/deliverable.csv")


Effort <- hold %>%
        group_by(year, month, sqa) %>%
        count() %>%
        arrange(n) %>%
        filter((year == 2020 & month == "Feb"))

