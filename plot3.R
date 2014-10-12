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
png("plot3.png")
plot(data$DateTime,data$Sub_metering_1,type="l",
     ylab="Energy sub metering", xlab="")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
unlink(tempFile)
