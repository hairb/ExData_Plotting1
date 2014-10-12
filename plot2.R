library(sqldf)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
tempFile <- tempfile()
download.file(fileURL, tempFile)
unzip(tempFile)

data <- read.csv.sql("household_power_consumption.txt", 
                     sql="select * from file where Date in ('2/2/2007','1/2/2007')",
                     header=TRUE, sep=";")

data$DateTime <- strptime(paste(data$Date, data$Time,sep=" "), format="%d/%m/%Y %H:%M:%S")
data$DayOfWeek <- strftime(data$DateTime,'%A')
png("plot2.png")
plot(data$DateTime, data$Global_active_power,
     ylab="Global Active Power (kilowatts)", xlab="", type="l")
dev.off()
unlink(tempFile)
