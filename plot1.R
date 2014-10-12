library(sqldf)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
tempFile <- tempfile()
download.file(fileURL, tempFile)
unzip(tempFile)

data <- read.csv.sql("household_power_consumption.txt", 
                     sql="select * from file where Date in ('2/2/2007','1/2/2007')",
                     header=TRUE, sep=";")

png("plot1.png")
hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()
unlink(tempFile)
