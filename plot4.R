##setWD for data location
setwd("/Users/benjaminbettin/datasciencecoursera/ExploratoryDataAnalysis")

##read in .txt file and set variable powerData
powerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                stringsAsFactors = FALSE, colClasses = c("character", "character", 
                "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

##add the DateTime variable
powerData$DateTime <- strptime(paste(powerData$Date, powerData$Time), format="%d/%m/%Y %H:%M:%S")

##subset on required dates
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
powerWork <- subset(powerData, powerData$Date == "2007-02-01" | powerData$Date == "2007-02-02")

##create the plot
par(mfrow = c(2, 2), ps = 12)
with(powerWork, {
        plot(powerWork$DateTime, powerWork$Global_active_power, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(powerWork$DateTime, powerWork$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        plot(powerWork$DateTime, powerWork$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
        lines(powerWork$DateTime, powerWork$Sub_metering_2, type = "l", col = "red")
        lines(powerWork$DateTime, powerWork$Sub_metering_3, type = "l", col = "blue")
        legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1,
               pt.cex = .5, cex = .5, box.lty = 1, box.lwd = 1, bty = "n")
        plot(powerWork$DateTime, powerWork$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

##save as .png file
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()