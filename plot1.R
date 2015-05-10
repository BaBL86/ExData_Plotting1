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

# Create histogram with red color and fixed title and axes names.
hist(hpcinterested$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency"
     )

# Copy histogram to PNG file
dev.copy(png, file="plot1.png", height=480, width=480)
# Close graphic device
dev.off()