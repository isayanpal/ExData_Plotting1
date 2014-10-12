library(dplyr)

temp <- tempfile()

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "temp.zip", method = "curl")
data <- read.table(unz("temp.zip", "household_power_consumption.txt"), sep=";", header=TRUE, as.is = TRUE)
unlink(temp)

data <- data %>% filter(dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02"))
data <- data %>% mutate(Global_active_power = as.numeric(Global_active_power))

datetime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png")
plot(as.POSIXlt(datetime), tmp$Global_active_power, type = "l", ylab = "Global Active Pwer (kilowatts)", xlab = "")
dev.off()