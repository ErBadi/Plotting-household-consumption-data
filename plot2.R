household_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = "character")
# We change the name of the non-descriptive variables
names(household_consumption)[7:9] <- c("kitchen", "laundryRoom", "waterAndAir")

# Select our important dates
ourDates1 <- household_consumption$Date == "1/2/2007"
ourDates2 <- household_consumption$Date == "2/2/2007"
ourDates <- c(ourDates1 | ourDates2)
household_consumption <- household_consumption[ourDates, ]
# We join date and time and set them to the time column
library(lubridate)
newTime <- paste(household_consumption$Date, household_consumption$Time)
newTime <- dmy_hms(newTime,tz=Sys.timezone())
household_consumption$Time <- newTime
# We plot
plot(household_consumption$Time, household_consumption$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(household_consumption$Time, household_consumption$Global_active_power)
dev.copy(png, file = "plot2.png")
dev.off()