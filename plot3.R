require(ggplot2)

dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
feb1 <- strptime("2/1/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
feb3 <- strptime("2/3/2007 00:00:00", "%m/%d/%Y %H:%M:%S")
dat$ptime <- strptime(paste(dat$Date, dat$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
feb1_2 <- dat[dat$ptime >= feb1 & dat$ptime < feb3, ]

png(filename="Plot3.png", width=480, height=480, units="px")

df <- data.frame(feb1_2[, c(7,8,9,10)])
df <- transform(df, Sub_metering_1 = as.numeric(Sub_metering_1))
df <- transform(df, Sub_metering_2 = as.numeric(Sub_metering_2))

ggplot(data = df, aes(ptime)) + 
  geom_line(aes(y=Sub_metering_1, color="Sub Metering 1")) +
  geom_line(aes(y=Sub_metering_2, color="Sub Metering 2")) +
  geom_line(aes(y=Sub_metering_3, color="Sub Metering 3")) +
  labs(y = "Sub Metering") +
  theme() + scale_color_discrete(name="Legend")

dev.off()
