
setwd("/home/babl/coursera/Exploratory_Data_Analysis/cp_1/")

library('data.table')
library('dplyr')

hpcfile <- 'household_power_consumption.txt'

hpcdata<-data.table(read.csv(file=hpcfile, 
                             header=TRUE, 
                             sep = ';', 
                             na.strings="?", 
                             nrows=2075259
                             ))

hpcdata$Date <- as.Date(hpcdata$Date, format='%d/%m/%Y')

hpcinterested <- filter(hpcdata, 
                        Date>=as.Date('2007-02-01') 
                        & Date<=as.Date('2007-02-02')
                        )

hist(hpcinterested$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency"
     )

# Copy histogram to PNG file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()