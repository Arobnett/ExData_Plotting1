library(tidyverse)

# Load the data
powerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Convert the Date and Time columns to a POSIXct date-time object
powerData$DateTime <- as.POSIXct(paste(powerData$Date, powerData$Time), format = "%d/%m/%Y %H:%M:%S")

# Subset the data to the specified date range
startDateTime <- as.POSIXct("2007-02-01")
endDateTime <- as.POSIXct("2007-02-02")
subsetData <- powerData[powerData$DateTime >= startDateTime & powerData$DateTime <= endDateTime, ]

# Replace infinite values with NA and remove them
subsetData$Global_active_power[is.infinite(subsetData$Global_active_power)] <- NA
subsetData <- na.omit(subsetData)

# Create the sub-metering plot
subsetData %>%
  pivot_longer(cols = starts_with("Sub_metering"), names_to = "Sub_metering", values_to = "Value") %>%
  ggplot(aes(x = DateTime, y = Value, color = Sub_metering)) +
  geom_line() +
  labs(x = "Datetime", y = "Energy sub metering", title = "Energy sub metering") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(values = c("red", "blue", "green"))
