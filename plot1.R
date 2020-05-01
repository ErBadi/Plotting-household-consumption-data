household_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = "character")
# We change the name of the non-descriptive variables
names(household_consumption)[7:9] <- c("kitchen", "laundryRoom", "waterAndAir")

# Select our important dates
ourDates1 <- household_consumption$Date == "1/2/2007"
ourDates2 <- household_consumption$Date == "2/2/2007"
ourDates <- c(ourDates1 | ourDates2)
household_consumption <- household_consumption[ourDates, ]
# Here we plot
hist(as.numeric(household_consumption$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# Now we convert to png
dev.copy(png, file = "plot1.png")
dev.off()