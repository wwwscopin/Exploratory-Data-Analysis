power0<-read.csv("C:\\Users\\XGG8\\WBH\\R Stat\\Plot\\household_power_consumption.txt", header=TRUE, sep=";" )

power0$Time<-strptime(paste(power0$Date, power0$Time), "%d/%m/%Y %H:%M:%S")
power0$Date<-as.Date(power0$Date, format="%d/%m/%Y")
power<-power0[power0$Date %in% as.Date(c('01/02/2007', '02/02/2007'), format="%d/%m/%Y"),]
power$day<-weekdays(power$Date)

head(power)
str(power)

png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
hist(as.numeric(levels(power$Global_active_power))[power$Global_active_power],col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
