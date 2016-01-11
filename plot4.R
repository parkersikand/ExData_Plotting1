require(ggplot2)
require(grid)
require(gridExtra)

dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
feb1 <- strptime("2/1/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
feb3 <- strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
dat$ptime <- strptime(paste(dat$Date, dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
feb1_2 <- dat[dat$ptime >= feb1 & dat$ptime < feb3, ]


png(filename="Plot4.png", width=480, height=480, units="px")


df1 <- data.frame(feb1_2[, c(10,3)][!is.na(feb1_2$Global_active_power), ])
df1 <- transform(df1, Global_active_power = as.numeric(Global_active_power))

p1 <- ggplot(data=df1, aes(ptime, Global_active_power)) + geom_line()


df2 <- data.frame(feb1_2[, c(10,5)][!is.na(feb1_2$Voltage), ])
df2 <- transform(df2, Voltage = as.numeric(Voltage))

p2 <- ggplot(data=df2, aes(ptime, Voltage)) + geom_line()


df3 <- data.frame(feb1_2[, c(7,8,9,10)])
df3 <- transform(df3, Sub_metering_1 = as.numeric(Sub_metering_1))
df3 <- transform(df3, Sub_metering_2 = as.numeric(Sub_metering_2))

p3 <- ggplot(data = df3, aes(ptime)) + 
  geom_line(aes(y=Sub_metering_1, color="Sub Metering 1")) +
  geom_line(aes(y=Sub_metering_2, color="Sub Metering 2")) +
  geom_line(aes(y=Sub_metering_3, color="Sub Metering 3")) +
  labs(y = "Sub Metering") +
  theme() + scale_color_discrete(name="Legend")


df4 <- data.frame(feb1_2[, c(10,4)][!is.na(feb1_2$Global_reactive_power), ])
df4 <- transform(df4, Global_reactive_power = as.numeric(Global_reactive_power))

p4 <- ggplot(data=df4, aes(ptime, Global_reactive_power)) + geom_line()


grid.arrange(p1, p2, p3, p4, ncol=2, nrow=2)

dev.off()
