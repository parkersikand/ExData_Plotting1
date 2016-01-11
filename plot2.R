require(ggplot2)

dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
feb1 <- strptime("2/1/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
feb3 <- strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
dat$ptime <- strptime(paste(dat$Date, dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
feb1_2 <- dat[dat$ptime >= feb1 & dat$ptime < feb3, ]

png(filename="Plot2.png", width=480, height=480, units="px")

df <- data.frame(feb1_2[, c(10,3)][!is.na(feb1_2$Global_active_power), ])
df <- transform(df, Global_active_power = as.numeric(Global_active_power))


ggplot(data=df, aes(ptime, Global_active_power)) + geom_line()

dev.off()
