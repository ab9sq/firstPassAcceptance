source("./scripts/Monthly_Stats.R")
require(lubridate)
results <- getResults(Month = "Jan",
                      Year = 2018)
temp <- getResults(Month = "Feb",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Mar",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Apr",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "May",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Jun",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Jul",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Aug",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Sep",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Oct",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Nov",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Dec",
                   Year = 2018)
results <- rbind(results,
                 temp)
temp <- getResults(Month = "Jan",
                   Year = 2019)
results <- rbind(results,
                 temp)

results$date <- paste("1",
                    results$Month,
                    results$Year,
                    sep = "-")
results$date <- as.Date(results$date,
                        format = "%d-%b-%Y")


rm(temp)

# results$MD <- paste("1",
#                     results$Month,
#                     results$Year,
#                     sep = "-")
# results$date <- as.Date(results$MD,
#                         format = "%d-%b-%Y")
# results$date <- as.Date(paste(format(results$date,
#                                      format = "%Y-%m"),
#                               days_in_month(results$date),
#                               sep="-"))
# results$MD <- NULL
MonthlyResults <- results
rm(results)
save(MonthlyResults, file = "./data/monthly_stats.RData")
#rm(MonthlyResults)
#load(file = "./data/monthly_stats.RData")
#str(MonthlyResults)
#tail(MonthlyResults,
 #    n=2)
ggplot(data = MonthlyResults) +
     geom_line(mapping = aes(x=date,
                             y=Projects_Started))
ggplot(data = MonthlyResults) +
     geom_line(mapping = aes(x=date,
                             y=Projects_Completed))
ggplot(data = MonthlyResults) +
     geom_line(mapping = aes(x=date,
                             y=Reviews_Completed))
ggplot(data = MonthlyResults) +
     geom_line(mapping = aes(x=date,
                             y=First_Pass_Acceptance))

ggplot(data = MonthlyResults) +
     geom_line(mapping = aes(x=date,
                             y=Projects_Started),
               color = "blue")+
     geom_line(mapping = aes(x=date,
                             y=Projects_Completed),
               color = "red")

plot(x=MonthlyResults$date,
     y=MonthlyResults$Projects_Started,
     col = "blue",
     type = "b",
     main = "Projects Started and Completed",
     xlab = "Since January 2018",
     ylab = "projects",
     pch = 3)
lines(x=MonthlyResults$date,
      y=MonthlyResults$Projects_Completed,
      col = "red",
      type = "b",
      pch = 4)
legend("topleft",
       legend = c("Started",
                  "Completed"),
       col = c("blue",
               "red"),
       lty = 1,
       pch = c(3,
               4))
plot(x=MonthlyResults$date,
     y=MonthlyResults$Reviews_Completed,
     col = "blue",
     type = "b",
     main = "Reviews Completed",
     xlab = "Since January 2018",
     ylab = "reviews",
     pch = 3)
legend("topleft",
       legend = "reviews",
       col = "blue",
       lty = 1,
       pch = c(3))

plot(x=MonthlyResults$date,
     y=MonthlyResults$Reviews_Completed,
     col = "blue",
     type = "b",
     main = "Reviews Completed",
     xlab = "Since January 2018",
     ylab = "reviews",
     pch = 3)
abline(h=mean(MonthlyResults$Reviews_Completed),
       lty = "dotted",
       col = "red")
abline(h=mean(MonthlyResults$Reviews_Completed) -
            sd(MonthlyResults$Reviews_Completed),
       lty = "dashed",
       col = "red")
abline(h=mean(MonthlyResults$Reviews_Completed) +
            sd(MonthlyResults$Reviews_Completed),
       lty = "dashed",
       col = "red")

legend("topleft",
       legend = c("reviews",
                  "Mean",
                  " +/- 1 SD"),
       col = c("blue",
               "red",
               "red"),
       lty = c("solid",
               "dotted",
               "dashed"),
       pch = c(3,
               NA,
               NA))

plot(x=MonthlyResults$date,
     y=MonthlyResults$First_Pass_Acceptance,
     col = "blue",
     type = "b",
     main = "First Pass Acceptance (FPA)",
     xlab = "Since January 2018",
     ylab = "FPA (%)",
     pch = 3,
     lty = "solid")

plot(x=MonthlyResults$date,
     y=MonthlyResults$First_Pass_Acceptance,
     col = "blue",
     type = "b",
     main = "First Pass Acceptance (FPA)",
     xlab = "Since January 2018",
     ylab = "FPA (%)",
     pch = 3,
     lty = "solid")
abline(h=mean(MonthlyResults$First_Pass_Acceptance),
       lty = "dotted",
       col = "red")
abline(h=mean(MonthlyResults$First_Pass_Acceptance) -
            sd(MonthlyResults$First_Pass_Acceptance),
       lty = "dashed",
       col = "red")
abline(h=mean(MonthlyResults$First_Pass_Acceptance) +
            sd(MonthlyResults$First_Pass_Acceptance),
       lty = "dashed",
       col = "red")
legend("topright",
       legend = c("FPA",
                  "Mean",
                  " +/- 1 SD"),
       col = c("blue",
               "red",
               "red"),
       lty = c("solid",
               "dotted",
               "dashed"),
       pch = c(3, NA, NA))
