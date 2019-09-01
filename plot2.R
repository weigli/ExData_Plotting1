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

# Create a new df with Weekdays and Global Active Power
hpc_df_new <- as.data.frame(cbind(weekdays(as.Date(hpc_df$Date, "%d/%m/%Y"), abbreviate = TRUE),paste(as.character(hpc_df$Date),as.character(hpc_df$Time)), hpc_df$Global_active_power))

# Assign names to the new df
names(hpc_df_new) <- c("wday", "Time", "Global_active_power")

# Conver Time Colume to POSIXlt
hpc_df_new$Time <- strptime(hpc_df_new$Time, "%d/%m/%Y %H:%M:%S")

# Convert Global_active_power to numeric
hpc_df_new$Global_active_power <- as.numeric(as.character(hpc_df_new$Global_active_power))

# Draw a plot with "Global Active Power" on screen
plot(hpc_df_new$Time, hpc_df_new$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Copy the plot to a PNG file
dev.copy(png, "plot2.png")
dev.off()

