# Code for reading in the data 
# Manually downloaded .txt file from course website into working directory 
# Had to delete .txt file from working directory, becuase it exceeded GitHub size limit

# Read in data
power_data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
head(power_data)

# Convert Data variable to Date class 
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
class(power_data$Date)

# Convert Time variable to Time class
power_data$Time <- as.POSIXct(power_data$Time, tz = "", format = "%H:%M:%S", usetz = FALSE)
class(power_data$Time)
library(chron)
(power_data$Time <- times(format(power_data$Time, "%H:%M:%S")))
class(power_data$Time)

# Subset dates of interest: 2/1/2007:2/2/2007
power_data_subset <- subset(power_data, Date >= "2007-02-01" & Date <= "2007-02-02")
power_data_subset

# Convert class of "Global Active Power" from factor to numeric 
power_data_subset$Global_active_power <- as.numeric(as.character(power_data_subset$Global_active_power))
class(power_data_subset$Global_active_power)

# Code that creates the PNG file
# width of 480 pixels 
# height of 480 pixels
# name of plot1.png
# Title: "Global Active Power"
# Histogram 
# x-axis: "Global Active Power (kilowatts)"
# y-axis: "Frequency"
# col = "red"

png(filename = "plot1.png", width = 480, height = 480)
hist(power_data_subset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
