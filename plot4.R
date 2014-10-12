library(dplyr)

temp <- tempfile()

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "temp.zip", method = "curl")
data <- read.table(unz("temp.zip", "household_power_consumption.txt"), sep=";", header=TRUE, as.is = TRUE)
unlink(temp)

data <- data %>% filter(dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02"))
data <- data %>% mutate(Voltage = as.numeric(Voltage), Global_reactive_power = as.numeric(Global_reactive_power), Global_active_power = as.numeric(Global_active_power), Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))

datetime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png")

par(mfcol = c(2, 2))
par(mar = c(4, 4, 1, 2))

plot(as.POSIXlt(datetime), tmp$Global_active_power, type = "l", ylab = "Global Active Pwer (kilowatts)", xlab = "")

plot(as.POSIXlt(datetime), data$Sub_metering_1, type = "n", xlab = "", ylab = "Enery sub metering")
lines(as.POSIXlt(datetime), data$Sub_metering_1)
lines(as.POSIXlt(datetime), data$Sub_metering_2, col = "red")
lines(as.POSIXlt(datetime), data$Sub_metering_3, col = "blue")
legend("topright", lty = c(1, 1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)

plot(as.POSIXlt(datetime), data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(as.POSIXlt(datetime), data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
