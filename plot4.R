# Code for reading in the data 
# Manually downloaded .txt file from course website into working directory 
# Had to remove large .txt file from working directory, becuase it exceeded GitHub size limit

# Read in data
power_data <- read.table("./household_power_consumption.txt", 
                         sep = ";", 
                         header = TRUE, 
                         colClasses = c("character", "character", rep("numeric", 7)),
                         na.strings = "?")
head(power_data)

# Subset dates of interest: 2/1/2007:2/2/2007
power_data_subset <- subset(power_data, power_data$Date == "1/2/2007" | power_data$Date == "2/2/2007")
power_data_subset

# Convert Data variable to Date class 
power_data_subset$Date <- as.Date(power_data_subset$Date, "%d/%m/%Y")
power_data_subset$DateTime <- as.POSIXct(paste(power_data_subset$Date, power_data_subset$Time))
Sys.setlocale("LC_TIME")

# Code that creates the PNG file
# width of 480 pixels 
# height of 480 pixels
# name of plot4.png
# 4 plots 
# Plot 1: x-axis: DateTime, y-axis: "Global Active Power"
# Plot 2: x-axis: DateTime, y-axis: "Energy sub meteringr" (legand)
# Plot 3: x-axis: DateTime, "datetime", y-axis: "Voltage"
# Plot 4: x-axis: DateTime, "datetime", y-axis: "Global_reactive_power"

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))
plot(power_data_subset$DateTime, power_data_subset$Global_active_power, 
     type = "l",
     xlab = "", 
     ylab = "Global Active Power")
plot(power_data_subset$DateTime, power_data_subset$Sub_metering_1, 
     "n", 
     xlab = "",
     ylab = "Energy sub metering")
points(power_data_subset$DateTime, power_data_subset$Sub_metering_1, type = "l")
points(power_data_subset$DateTime, power_data_subset$Sub_metering_2, type = "l", col = "red")
points(power_data_subset$DateTime, power_data_subset$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = c(1, 1, 1), 
       bty = "n")
plot(power_data_subset$DateTime, power_data_subset$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")
plot(power_data_subset$DateTime, power_data_subset$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()
