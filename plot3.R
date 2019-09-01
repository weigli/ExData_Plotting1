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

# Define the file handler
hpc_file <- file("../household_power_consumption.txt")

# Specify the file format
attr(hpc_file, "file.format") <- list(sep = ";", header = TRUE, na.strings = "?")

# Only read the data between start date and end date
hpc_df <- sqldf("select * from hpc_file where substr(Date, -4) || '-' || substr('0' || replace(substr(Date, instr(Date, '/') + 1, 2), '/', ''), -2) || '-' || substr('0' || replace(substr(Date, 1, 2), '/', ''), -2) between '2007-02-01' and '2007-02-02' ")

# Create a new df with Weekdays and Sub_metering_x
hpc_df_new <- as.data.frame(cbind(weekdays(as.Date(hpc_df$Date, "%d/%m/%Y"), abbreviate = TRUE),paste(as.character(hpc_df$Date),as.character(hpc_df$Time)), hpc_df$Sub_metering_1, hpc_df$Sub_metering_2, hpc_df$Sub_metering_3))

# Assign names to the new df
names(hpc_df_new) <- c("wday", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Conver Time Colume to POSIXlt
hpc_df_new$Time <- strptime(hpc_df_new$Time, "%d/%m/%Y %H:%M:%S")

# Convert Sub_metering_x to numeric
hpc_df_new$Sub_metering_1 <- as.numeric(as.character(hpc_df_new$Sub_metering_1))
hpc_df_new$Sub_metering_2 <- as.numeric(as.character(hpc_df_new$Sub_metering_2))
hpc_df_new$Sub_metering_3 <- as.numeric(as.character(hpc_df_new$Sub_metering_3))

print(str(hpc_df_new))

# Draw a plot with Sub_metering_x on screen
plot(hpc_df_new$Time, hpc_df_new$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", )
points(hpc_df_new$Time, hpc_df_new$Sub_metering_2, type = "l", col = "red")
points(hpc_df_new$Time, hpc_df_new$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), col= c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Copy the plot to a PNG file
dev.copy(png, "plot3.png")
dev.off()

