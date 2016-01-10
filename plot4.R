## Exploratory Data Analysis - Week 1 - Course project
## R code that creates: plot4.png
## Author: Moisés Egües

## Read the data from the .txt file
data_source <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                          stringsAsFactors = FALSE, na.strings = "?")

## Add a column which contains the Date and Time together and change the classes.
data_source$TimeFull <- with(data_source, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
data_source$Date <- as.Date(data_source$Date, format="%d/%m/%Y")

## Filter the data for the required dates 
data_subset <- data_source[which(data_source[, "Date"] == as.Date("2007-02-01", "%Y-%m-%d") | data_source[, "Date"] == as.Date("2007-02-02", "%Y-%m-%d")),]

## Configure the screen to support 4 grapfics, 2 by row and 2 by column.
par(mfrow=c(2,2))

## Reduce the text size
par("cex" = 0.6)

## Generate the graphic No 1
## =========================

## Create the graphic with not x labels
with(data_subset, plot(TimeFull, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt='n'))

## Configure the x labels
xTicks <- as.POSIXct(c("1/2/2007 00:01:00","2/2/2007 00:01:00","2/2/2007 23:59:00"), format="%d/%m/%Y %H:%M:%S")
axis(1, at = xTicks, labels = c("Thu", "Fri", "Sat"))


## Generate the graphic No 2
## =========================

## Create the graphic with not x labels
with(data_subset, plot(TimeFull, Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt='n'))

## Configure the x labels
xTicks <- as.POSIXct(c("1/2/2007 00:01:00","2/2/2007 00:01:00","2/2/2007 23:59:00"), format="%d/%m/%Y %H:%M:%S")
axis(1, at = xTicks, labels = c("Thu", "Fri", "Sat"))


## Generate the graphic No 3
## =========================

## Create the graphic with not x labels
with(data_subset, plot(TimeFull, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", 
                       xaxt='n', col = "black"))

## Adding the Sub_metering_2 and Sub_metering_3 lines graph
with(data_subset, lines(TimeFull, Sub_metering_2, type = "l", col = "red"))
with(data_subset, lines(TimeFull, Sub_metering_3, type = "l", col = "blue"))

## Configure the x labels of the graphic
xTicks <- as.POSIXct(c("1/2/2007 00:01:00","2/2/2007 00:01:00","2/2/2007 23:59:00"), format="%d/%m/%Y %H:%M:%S")
axis(1, at = xTicks, labels = c("Thu", "Fri", "Sat"))

## Create the legend zone
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, cex = 0.85, bty = "n")


## Generate the graphic No 4
## =========================

## Create the graphic with not x labels
with(data_subset, plot(TimeFull, Global_reactive_power, type = "l", xlab = "datetime", xaxt='n'))

## Configure the x labels
xTicks <- as.POSIXct(c("1/2/2007 00:01:00","2/2/2007 00:01:00","2/2/2007 23:59:00"), format="%d/%m/%Y %H:%M:%S")
axis(1, at = xTicks, labels = c("Thu", "Fri", "Sat"))


## Create the PNG image file.
dev.copy(png, file = "plot4.png")
dev.off()
