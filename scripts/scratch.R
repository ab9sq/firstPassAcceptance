load(file = "./data/FPA.RData")
rm(FPA)
buildTrending(Month = "Nov", Year = 2018)


ggplot(data = FPA, aes(x = date, y = Reviews_Completed))+
     goem_plot()

plot(x=FPA$date, y=FPA$Reviews_Completed,
     type = "b",
     main = "Trend for First Pass Acceptance",
     xlab = "Month",
     ylab = "First Pass Acceptance (%)",
     col = "blue",
     pch = 8)
abline(h=mean(FPA$Reviews_Completed),
       lty = 3)
abline(h=(mean(FPA$Reviews_Completed) +
               sd(FPA$Reviews_Completed)),
       lty = 2,
       col = "green")
abline(h=(mean(FPA$Reviews_Completed) -
               sd(FPA$Reviews_Completed)),
       lty = 2,
       col = "green")
linear<- lm(FPA$Reviews_Completed ~ FPA$date)
summary(linear)
abline(a = linear$coefficients[1],
       b = linear$coefficients[2],
       lty = 4,
       col = "red")
legend("bottomleft",
       c("documents reviewed",
         "one standard dev",
         "linear regression"),
       col = c("blue",
               "green",
               "red"),
       lty = c(3, 2, 4),
       pch = c(8,NA,NA),
       cex = 0.5)













junk <- data.frame(Month = "Jan",
                   Year = 2018,
                   stringsAsFactors = FALSE)
junk$MD <- paste("1",junk$Month, junk$Year, sep = "-")
junk
junk$date <- as.Date(junk$MD, format = "%d-%b-%Y")
junk
junk$end <- paste(format(junk$date, format = "%Y-%m"), "-", days_in_month(junk$date), sep="")
junk
str(junk)
junk
