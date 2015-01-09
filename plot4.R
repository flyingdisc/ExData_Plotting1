# file name of the data
dataFile <- "household_power_consumption.txt"
# read header
header <- read.table(dataFile, header=TRUE, sep=";", na.strings="?",
                     nrows=1, stringsAsFactors=FALSE)
# we only need to read subset of file starting from around line:60000 to 70000
#   containing date of only 1/2/2007 and 2/2/2007 
data <- read.table(dataFile, header=TRUE, sep=";", na.strings="?",
                   skip=60000, nrows=10000, stringsAsFactors=FALSE)
# set column names
names(data) <- names(header)

# filter, pass only rows with date of 1/2/2007 and 2/2/2007
data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]

# change row names started from 1, because subset doesn't started from 1
rownames(data) <- 1:nrow(data)

# test
# head(data)
# tail(data)

# merge date+time
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# plot to png file
png(filename="plot4.png", height=480, width=480)
par(mar=c(6,4,4,2))
par(mfrow=c(2, 2))
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1)
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab=colnames(data)[4])
dev.off()
