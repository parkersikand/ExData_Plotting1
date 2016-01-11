dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
feb1 <- strptime("2/1/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
feb3 <- strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
dat$ptime <- strptime(paste(dat$Date, dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
feb1_2 <- dat[dat$ptime >= feb1 & dat$ptime < feb3, ]

gap <- as.numeric(feb1_2$Global_active_power)

png(filename="Plot1.png", width=480, height=480, units="px")

hist(gap, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

dev.off()
