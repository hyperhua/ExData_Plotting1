
#### read data (we already known the data was stored by rows in a monotone date order). we will grep 1/2/2007 with an estimated 3000 rows (just have to try), then subset the data to 2007-02-01 and 2007-02-02.
### skip the rows until it finds the line "1/2/2007" and then counts 3000 rows down
dat <- read.table("./household_power_consumption.txt", header=T, sep=";",
                  skip=grep("1/2/2007", readLines("household_power_consumption.txt")),nrows=3000,
                  na.strings = "?")

names(dat) <- names(read.table("./household_power_consumption.txt", header=T, sep=";", nrows=1))
table(dat$Date) ### to make sure that it capture at least some 2007-02-03 data
dat <- dat[as.character(dat$Date)%in%c("1/2/2007","2/2/2007"),]

library(lubridate)
library(dplyr)
dat <- dat %>% 
  mutate(date_time = dmy_hms(paste(Date, Time, sep = " "), locale = "US"))


#### Plot 2 ####
### Time series for global active power plot ###
png("plot2.png")

par(mar=c(4,4,2,1))
plot(dat$date_time, dat$Global_active_power, type = "l", xlab=" ", 
     ylab="Global Active Power (kilowatts)")

dev.off()

