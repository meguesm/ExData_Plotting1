## Exploratory Data Analysis - Week 1 - Course project
## R code that creates: plot1.png
## Author: Moisés Egües

## Create the myDate and myTime classes to formatting the date and times variables
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

setClass("myTime")
setAs("character","myTime", function(from) strptime(from, format = "%X") )

## Read the data from the .txt file
data_source <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", 
                          stringsAsFactors = FALSE, na.strings = "?",
                          colClasses = c("myDate", "myTime","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## Filter the data for the required dates 
data_subset <- data_source[which(data_source[, "Date"] == as.Date("2007-02-01", "%Y-%m-%d") | data_source[, "Date"] == as.Date("2007-02-02", "%Y-%m-%d")),]

## Reduce the text size
par("cex" = 0.7)

## Create the graphic 
hist(data_subset$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frecuency")

## Create the PNG image file.
dev.copy(png, file = "plot1.png")
dev.off()