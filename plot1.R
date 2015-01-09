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
png(filename="plot1.png", height=480, width=480)
par(mar=c(6,4,4,2))
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
