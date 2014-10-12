library(lubridate)
library(dlpyr)

temp <- tempfile()

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "temp.zip")
data <- read.table(unz("temp.zip", "household_power_consumption.txt"), sep=";", header=TRUE, as.is = TRUE)
unlink(temp)

data <- data %>% filter(dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02"))
data <- data %>% mutate(Global_active_power = as.numeric(Global_active_power))

png(filename = "plot1.png")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()