# Load the data
powerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Convert the Date and Time variables to a single Date_Time variable
powerData$Date_Time <- as.POSIXct(paste(powerData$Date, powerData$Time), format = "%d/%m/%Y %H:%M:%S")

# Subset the data to the specified date range
startDateTime <- as.POSIXct("2007-02-01 00:00:00")
endDateTime <- as.POSIXct("2007-02-02 23:59:59")
subsetData <- powerData[powerData$Date_Time >= startDateTime & powerData$Date_Time <= endDateTime, ]

# Replace infinite values with NA and remove them
subsetData$Global_active_power[is.infinite(subsetData$Global_active_power)] <- NA
subsetData <- na.omit(subsetData)

# Create the plot
png("plot2.png", width = 480, height = 480)
plot(subsetData$Date_Time, subsetData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power Over a 2-Day Period in February 2007", xlim = c(startDateTime, endDateTime), ylim = c(0, max(subsetData$Global_active_power)))
# Check if the plot is empty
if(length(subsetData$Global_active_power[!is.na(subsetData$Global_active_power)]) == 0) {
  # If the plot is empty, print a message
  message("Plot is empty")
} else {
  # If the plot is not empty, save it to a PNG file and close the device
  dev.off()
}

