##Download and unzip dataset
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip")
unzip("power.zip")

##Read raw data into R and extract observations for relevant dates

power_raw <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, 
                        colClasses = c("character", "character", rep("numeric", times = 7)), na.strings="?")
power <- power_raw[power_raw$Date=="1/2/2007" | power_raw$Date == "2/2/2007", ]

##Combine date and time variables for use in x-axis
power$DateTime <- paste(power$Date, power$Time)
library(lubridate)
power$DateTime <- dmy_hms(power$DateTime)

##Call PDF device and plot graph

png("plot4.png", width=480, height = 480)
par(mfrow = c(2,2))

#Plot chart 1, 1
plot(power$DateTime, power$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = "" )

#Plot Chart 1, 2
plot(power$DateTime, power$Voltage, type="l", ylab="Voltage", xlab = "datetime")

#Plot Chart 2, 1
plot(power$DateTime, power$Sub_metering_1, type="l", col = "darkgrey", ylab="Energy sub metering", xlab = "")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("darkgrey", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot Chart 2, 2
plot(power$DateTime, power$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab = "datetime")

dev.off()