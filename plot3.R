power0<-read.csv("C:\\Users\\XGG8\\WBH\\R Stat\\Plot\\household_power_consumption.txt", header=TRUE, sep=";" )

power0$Time<-strptime(paste(power0$Date, power0$Time), "%d/%m/%Y %H:%M:%S")
power0$Date<-as.Date(power0$Date, format="%d/%m/%Y")
power<-power0[power0$Date %in% as.Date(c('01/02/2007', '02/02/2007'), format="%d/%m/%Y"),]
power$day<-weekdays(power$Date)

head(power)
str(power)


png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
plot(power$Time, as.numeric(levels(power$Sub_metering_1))[power$Sub_metering_1], type="l", main ="", xlab="", ylab="Energy sub metering")
lines(power$Time, as.numeric(levels(power$Sub_metering_2))[power$Sub_metering_2], col="red")
lines(power$Time, power$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
lty=c(1,1), # gives the legend appropriate symbols (lines),
col=c("black", "blue", "red")) # gives the legend lines the correct color and width
dev.off()
