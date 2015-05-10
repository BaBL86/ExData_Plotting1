# Set your working directory with the data base file
setwd("/home/babl/coursera/Exploratory_Data_Analysis/cp_1/")

# Include libraries
library('data.table')
library('dplyr')

# File with data
# hpcfile <- 'household_power_consumption.txt'
hpcfile <- 'hpc.txt'

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

# Create plot with type = line.
plot(hpcinterested$datetime, hpcinterested$Global_active_power,
     col="black", bg="black",
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     )

# Copy histogram to PNG file
dev.copy(png, file="plot2.png", height=480, width=480)
# Close graphic device
dev.off()