source("./scripts/FirstPassAcceptance.R")
require(lubridate)
require(tidyverse)

Month <- "Sep"
Year <- 2021

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

Effort <- hold %>%
        group_by(year, month, sqa) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == Year & month == Month))

#Effort

# Work$date <- as.Date(paste("1",
#                            Work$month,
#                            Work$year,
#                            sep = "-"),
#                      format = "%d-%b-%Y")

Docs <- hold %>%
        group_by(year, month, Site, deliverable) %>%
        count() %>%
        arrange(Site, desc(n)) %>%
        filter((year == Year & month == Month))

#Docs

sites <- hold %>%
        group_by(year, month, Site) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == Year & month == Month))

#sites

deliver <- hold %>%
        group_by(year, month, deliverable) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == Year & month == Month))

#deliver

status <- hold %>%
        group_by(year, month, status) %>%
        count() %>%
        arrange(desc(n)) %>%
        filter((year == Year & month == Month))

#status

Path <- paste("./Monthly/New",
              "/",
              sep = "")

dir.create(Path)

write_csv(Effort, file = paste0(Path,
                               "Individuals ",
                               Month,
                               " ",
                               Year,
                               ".csv"))

write_csv(Docs, file = paste0(Path,
                             "Documents ",
                             Month,
                             " ",
                             Year,
                             ".csv"))

write_csv(sites, file = paste0(Path,
                               "sites ",
                               Month,
                               " ",
                               Year,
                               ".csv"))

write_csv(deliver, file = paste0(Path,
                                 "deliverable ",
                                 Month,
                                 " ",
                                 Year,
                                 ".csv"))
