# Set your working directory with the data base file
setwd("/home/babl/coursera/Exploratory_Data_Analysis/cp_1/")

# Include libraries
library('data.table')
library('dplyr')

# File with data
hpcfile <- 'household_power_consumption.txt'

# Load data from CSV file with settings
hpcdata<-data.table(read.csv(file=hpcfile, 
                             header=TRUE, 
                             sep = ';', 
                             na.strings="?", 
                             nrows=2075259
))

# Reorganize Date column to futere filter
hpcdata$Date <- as.Date(hpcdata$Date, format='%d/%m/%Y')

# Filter data to select interested period
hpcinterested <- filter(hpcdata, 
                        Date>=as.Date('2007-02-01') 
                        & Date<=as.Date('2007-02-02')
)

# Free memory from unused data
rm(hpcdata)

# Create datetime column for plot and parse date to correct objects
hpcinterested<-mutate(hpcinterested, datetime = paste(Date, Time, sep = ' '))
hpcinterested$datetime<-as.POSIXct(hpcinterested$datetime, "%Y-%m-%d %H:%M:%s", tc='UTC')

# Creating plot layout 2x2 with mfcol (because we already have 2 plots from first column)
par(mfcol = c(2, 2))

# Plot 1
## Create plot with type = line.
plot(hpcinterested$datetime, hpcinterested$Global_active_power,
     col="black",
     type="l",
     xlab="",
     ylab="Global Active Power",
)

# Plot 2
## Create empty plot
plot(hpcinterested$datetime, hpcinterested$Sub_metering_1, 
     type="n",
     ylab="Enegry sub metering",
     xlab=""
)
## Fill plot with subsets with type = line and different colors
points(hpcinterested$datetime, hpcinterested$Sub_metering_1, col="black", type="l")
points(hpcinterested$datetime, hpcinterested$Sub_metering_2, col="red", type="l")
points(hpcinterested$datetime, hpcinterested$Sub_metering_3, col="blue", type="l")

## Legend to the plot
## inset used to fix text, doesn't fit to the plot
legend("topright",
       lty=1, lwd=1,
       cex=0.8,
       bty="n",
       inset = c(0.1, 0),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# Plot 3
## Create plot with type = line.
plot(hpcinterested$datetime, hpcinterested$Voltage,
     ylab="Voltage",
     xlab="datetime",
     col="black",
     type="l",
)

# Plot 4
## Create plot with type = line.
plot(hpcinterested$datetime, hpcinterested$Global_reactive_power,
     ylab="Global_reactive_power",
     xlab="datetime",
     col="black",
     type="l",
)


# Copy histogram to PNG file
dev.copy(png, file="plot4.png", height=480, width=480)
# Close graphic device
dev.off()