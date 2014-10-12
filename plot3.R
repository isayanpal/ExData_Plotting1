library(dlpyr)

temp <- tempfile()

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "temp.zip")
data <- read.table(unz("temp.zip", "household_power_consumption.txt"), sep=";", header=TRUE, as.is = TRUE)
unlink(temp)

data <- data %>% filter(dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02"))
data <- data %>% mutate(Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))

datetime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png")

plot(as.POSIXlt(datetime), data$Sub_metering_1, type = "n", xlab = "", ylab = "Enery sub metering")
lines(as.POSIXlt(datetime), data$Sub_metering_1)
lines(as.POSIXlt(datetime), data$Sub_metering_2, col = "red")
lines(as.POSIXlt(datetime), data$Sub_metering_3, col = "blue")
legend("topright", lty = c(1, 1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()