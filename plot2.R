# Code for reading in the data 
# Manually downloaded .txt file from course website into working directory 
# Had to delete .txt file from working directory, becuase it exceeded GitHub size limit

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
# name of plot2.png
# x-axis: DateTime
# y-axis: "Global Active Power (kilowatts)"

png(filename = "plot2.png", width = 480, height = 480)
plot(power_data_subset$DateTime, 
     as.numeric(power_data_subset$Global_active_power), 
     type = "l", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
