# Load the data
powerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Convert the Date and Time columns to a POSIXct date-time object
powerData$DateTime <- as.POSIXct(paste(powerData$Date, powerData$Time), format = "%d/%m/%Y %H:%M:%S")

# Subset the data to the specified date range
startDateTime <- as.POSIXct("2007-02-01")
endDateTime <- as.POSIXct("2007-02-02")
subsetData <- powerData[powerData$DateTime >= startDateTime & powerData$DateTime <= endDateTime, ]

# Replace infinite values with NA and remove them
subsetData <- data.frame(subsetData)
subsetData[] <- lapply(subsetData, function(x) ifelse(is.infinite(x), NA, x))

# Set the plot size and create a 2 by 2 grid of plots
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Create the top left plot of the grid and add a title
plot(subsetData$DateTime, subsetData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Create the top right plot of the grid and add a title
plot(subsetData$DateTime, subsetData$Voltage, type = "l", xlab = "", ylab = "Voltage (volts)", main = "Voltage")

# Create the bottom left plot of the grid and add a title
plot(subsetData$DateTime, subsetData$Sub_metering_1, type = "l", xlab = "datetime", ylab = "Energy sub metering", main = "Energy Sub Metering")

# Create the bottom right plot of the grid and add a title
plot(subsetData$DateTime, subsetData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power (kilowatts)", main = "Global Reactive Power")
dev.off()
