## Exploratory Data Analysis - Week 1 - Course project
## R code that creates: plot3.png
## Author: Moisés Egües

## Read the data from the .txt file
data_source <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                          stringsAsFactors = FALSE, na.strings = "?")

## Add a column which contains the Date and Time together and change the classes.
data_source$TimeFull <- with(data_source, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
data_source$Date <- as.Date(data_source$Date, format="%d/%m/%Y")

## Filter the data for the required dates 
data_subset <- data_source[which(data_source[, "Date"] == as.Date("2007-02-01", "%Y-%m-%d") | data_source[, "Date"] == as.Date("2007-02-02", "%Y-%m-%d")),]

## Create the graphic with not x labels
with(data_subset, plot(TimeFull, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", 
                       xaxt='n', col = "black"))

## Adding the Sub_metering_2 and Sub_metering_3 lines graph
with(data_subset, lines(TimeFull, Sub_metering_2, type = "l", col = "red"))
with(data_subset, lines(TimeFull, Sub_metering_3, type = "l", col = "blue"))

## Reduce the text size
par("cex" = 0.7)

## Configure the x labels of the graphic
xTicks <- as.POSIXct(c("1/2/2007 00:01:00","2/2/2007 00:01:00","2/2/2007 23:59:00"), format="%d/%m/%Y %H:%M:%S")
axis(1, at = xTicks, labels = c("Thu", "Fri", "Sat"))

## Create the legend zone
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)

## Create the PNG image file.
dev.copy(png, file = "plot3.png")
dev.off()