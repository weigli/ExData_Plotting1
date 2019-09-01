# This R script uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. 
# In particular, we will be using the "Individual household electric power consumption Data Set"
  
# Dataset:     Electric power consumption [20Mb] 
# Link:        https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
#              Different electrical quantities and some sub-metering values are available.
#
#
# This script produces a histogram using "Gloabl Active Power" and export as PNG file

# Import library
library(sqldf)

# Define the file handler
hpc_file <- file("../household_power_consumption.txt")

# Specify the file format
attr(hpc_file, "file.format") <- list(sep = ";", header = TRUE, na.strings = "?")

# Only read the data between start date and end date
hpc_df <- sqldf("select * from hpc_file where substr(Date, -4) || '-' || substr('0' || replace(substr(Date, instr(Date, '/') + 1, 2), '/', ''), -2) || '-' || substr('0' || replace(substr(Date, 1, 2), '/', ''), -2) between '2007-02-01' and '2007-02-02' ")

# Draw a histogram with "Global Active Power" on screen
hist(hpc_df$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

# Copy the plot to a PNG file
dev.copy(png, "plot1.png")
dev.off()

