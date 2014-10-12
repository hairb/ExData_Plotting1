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
png("plot4.png")
par(mfrow=c(2,2))
plot(data$DateTime,data$Global_active_power, type="l",
     ylab="Global Active Power",xlab="")
plot(data$DateTime,data$Voltage,type="l",
     ylab="Voltage",xlab="datetime")
plot(data$DateTime,data$Sub_metering_1,type="l",
     ylab="Energy sub metering", xlab="")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1),col=c("black","red","blue"),bty="n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(data$DateTime,data$Global_reactive_power,type="l",
     xlab="datetime",ylab="Global_reactive_power")
dev.off()
unlink(tempFile)
