household_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = "character")
# We change the name of the non-descriptive variables
names(household_consumption)[7:9] <- c("kitchen", "laundryRoom", "waterAndAir")

# Select our important dates
ourDates1 <- household_consumption$Date == "1/2/2007"
ourDates2 <- household_consumption$Date == "2/2/2007"
ourDates <- c(ourDates1 | ourDates2)
household_consumption <- household_consumption[ourDates, ]

# Plot 2
# We join date and time and set them to the time column
library(lubridate)
newTime <- paste(household_consumption$Date, household_consumption$Time)
newTime <- dmy_hms(newTime,tz=Sys.timezone())
household_consumption$Time <- newTime

# We plot
par(mfrow = c(2,2))

plot(household_consumption$Time, household_consumption$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(household_consumption$Time, household_consumption$Global_active_power)

plot(household_consumption$Time, household_consumption$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(household_consumption$Time, household_consumption$Voltage)

plot(household_consumption$Time, household_consumption$kitchen, xlab = "", ylab = "Energy sub metering", type = "n")
lines(household_consumption$Time, household_consumption$kitchen)
points(household_consumption$laundryRoom)
lines(household_consumption$Time, household_consumption$laundryRoom, col = "red")
points(household_consumption$waterAndAir)
lines(household_consumption$Time, household_consumption$waterAndAir, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 0.75)

plot(household_consumption$Time, household_consumption$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(household_consumption$Time, household_consumption$Global_reactive_power)

dev.copy(png, file = "plot4.png")
dev.off()