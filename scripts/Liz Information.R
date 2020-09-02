source("./scripts/FirstPassAcceptance.R")
require(lubridate)
require(tidyverse)

Month <- "Aug"
Year <- 2020
 EndOfPeriod <- as.Date("31-Jul-2020",
                       format = "%d-%b-%Y")

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
        filter((year == Year & month == Month))
Effort

Work$date <- as.Date(paste("1",
                           Work$month,
                           Work$year,
                           sep = "-"),
                     format = "%d-%b-%Y")
Work <- Work %>%
        filter(date <= EndOfPeriod)

holdplot <- ggplot(data = Work, aes(x= date, y=n))


holdplot+geom_line(aes(group = sqa, color = sqa))

Docs <- hold %>%
        group_by(year, month, Site, deliverable) %>%
        count() %>%
        arrange(Site, desc(n)) %>%
        filter((year == Year & month == Month))
Docs

sites <- hold %>%
        group_by(year, month, Site) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == Year & month == Month))
sites
deliver <- hold %>%
        group_by(year, month, deliverable) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == Year & month == Month))
deliver

status <- hold %>%
        group_by(year, month, status) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == Year & month == Month))
status

Path <- paste("./Monthly/",
              Month,
              " ",
              Year,
              "/",
              sep = "")
dir.create(Path)
write_csv(Effort, path = paste0(Path,
                               "Individuals.csv"))
write_csv(Docs, path = paste0(Path,
                             "Documents.csv"))
write_csv(sites, path = paste0(Path,
                               "sites.csv"))
write_csv(deliver, path = paste0(Path,
                                 "deliverable.csv"))


# Effort <- hold %>%
#         group_by(year, month, sqa) %>%
#         count() %>%
#         arrange(n) %>%
#         filter((year == Year & month == Month))


