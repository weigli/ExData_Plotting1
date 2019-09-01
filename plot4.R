# This R script uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. 
# In particular, we will be using the "Individual household electric power consumption Data Set"

# Dataset:     Electric power consumption [20Mb] 
# Link:        https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
#              Different electrical quantities and some sub-metering values are available.
#
#
# This script produces a histogram using "Frequency" and "Gloabl Active Power (killowatts)" and export as PNG file

# Import library
library(sqldf)

# Define the canvas as 2x2
par(mfrow = c(2,2))

# Define the file handler
hpc_file <- file("../household_power_consumption.txt")

# Specify the file format
attr(hpc_file, "file.format") <- list(sep = ";", header = TRUE, na.strings = "?")

# Only read the data between start date and end date
hpc_df <- sqldf("select * from hpc_file where substr(Date, -4) || '-' || substr('0' || replace(substr(Date, instr(Date, '/') + 1, 2), '/', ''), -2) || '-' || substr('0' || replace(substr(Date, 1, 2), '/', ''), -2) between '2007-02-01' and '2007-02-02' ")

# Panel 1
# Create a new df with Weekdays and Global Active Power"
hpc_df_gap <- as.data.frame(cbind(weekdays(as.Date(hpc_df$Date, "%d/%m/%Y"), abbreviate = TRUE),paste(as.character(hpc_df$Date),as.character(hpc_df$Time)), hpc_df$Global_active_power))

# Assign names to the new df with "Global_active_power"
names(hpc_df_gap) <- c("wday", "Time", "Global_active_power")

# Conver Time Colume to POSIXlt
hpc_df_gap$Time <- strptime(hpc_df_gap$Time, "%d/%m/%Y %H:%M:%S")

# Convert Global_active_power to numeric
hpc_df_gap$Global_active_power <- as.numeric(as.character(hpc_df_gap$Global_active_power))

# Draw a plot with "Global Active Power" on screen
plot(hpc_df_gap$Time, hpc_df_gap$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")


# Panel 2
# Create a new df with Weekdays and Voltage
hpc_df_v <- as.data.frame(cbind(weekdays(as.Date(hpc_df$Date, "%d/%m/%Y"), abbreviate = TRUE),paste(as.character(hpc_df$Date),as.character(hpc_df$Time)), hpc_df$Voltage))

# Assign names to the new df with Voltage
names(hpc_df_v) <- c("wday", "Time", "Voltage")

# Conver Time Colume to POSIXlt
hpc_df_v$Time <- strptime(hpc_df_v$Time, "%d/%m/%Y %H:%M:%S")

# Convert Voltage to numeric
hpc_df_v$Voltage <- as.numeric(as.character(hpc_df_v$Voltage))

# Draw a plot with Voltage on screen
plot(hpc_df_v$Time, hpc_df_v$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# Panel 3
# Create a new df with Weekdays and Sub_metering_x
hpc_df_smx <- as.data.frame(cbind(weekdays(as.Date(hpc_df$Date, "%d/%m/%Y"), abbreviate = TRUE),paste(as.character(hpc_df$Date),as.character(hpc_df$Time)), hpc_df$Sub_metering_1, hpc_df$Sub_metering_2, hpc_df$Sub_metering_3))

# Assign names to the new df
names(hpc_df_smx) <- c("wday", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Conver Time Colume to POSIXlt
hpc_df_smx$Time <- strptime(hpc_df_smx$Time, "%d/%m/%Y %H:%M:%S")

# Convert Sub_metering_x to numeric
hpc_df_smx$Sub_metering_1 <- as.numeric(as.character(hpc_df_smx$Sub_metering_1))
hpc_df_smx$Sub_metering_2 <- as.numeric(as.character(hpc_df_smx$Sub_metering_2))
hpc_df_smx$Sub_metering_3 <- as.numeric(as.character(hpc_df_smx$Sub_metering_3))

# Draw a plot with Sub_metering_x on screen
plot(hpc_df_smx$Time, hpc_df_smx$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", )
points(hpc_df_smx$Time, hpc_df_smx$Sub_metering_2, type = "l", col = "red")
points(hpc_df_smx$Time, hpc_df_smx$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), col= c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Panel 4
# Create a new df with Weekdays and Global_reactive_power
hpc_df_grp <- as.data.frame(cbind(weekdays(as.Date(hpc_df$Date, "%d/%m/%Y"), abbreviate = TRUE),paste(as.character(hpc_df$Date),as.character(hpc_df$Time)), hpc_df$Global_reactive_power))

# Assign names to the new df with "Global_reactive_power"
names(hpc_df_grp) <- c("wday", "Time", "Global_reactive_power")

# Conver Time Colume to POSIXlt
hpc_df_grp$Time <- strptime(hpc_df_grp$Time, "%d/%m/%Y %H:%M:%S")

# Convert Global_reactive_power to numeric
hpc_df_grp$Global_reactive_power <- as.numeric(as.character(hpc_df_grp$Global_reactive_power))

# Draw a plot with Global_reactive_power on screen
plot(hpc_df_grp$Time, hpc_df_grp$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")


#Copy the plot to a PNG file
dev.copy(png, "plot4.png")
dev.off()

