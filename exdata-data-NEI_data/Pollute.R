## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)

TotE<-tapply(NEI$Emissions,NEI$Year, sum)

png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
plot(names(TotE), TotE, col="blue", type='l', xaxt="n", xlab="Year", ylab="Total Emissions (tons)", main=expression(paste("PM"[2.5], " Emissions in USA")))
axis(1, at=names(TotE), labels=names(TotE))
points(names(TotE), TotE, col="dark red", pch=19, cex=1.5)
#text(names(TotE), TotE, names(TotE), cex=0.8, pos=3, col="red") 
dev.off()


MD<-NEI[NEI$fips=="24510",]
MDE<-tapply(MD$Emissions, MD$Year, sum)

png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
plot(names(MDE), MDE, col="blue", type='l', xaxt="n", xlab="Year", ylab="Total Emissions (tons)", main=expression(paste("PM"[2.5], " Emissions in Baltimore City, Maryland")))
axis(1, at=names(MDE), labels=names(MDE))
points(names(MDE), MDE, col="dark red", pch=19, cex=1.5)
dev.off()


BCE<-aggregate(Emissions ~ Type + Year, data=MD, sum)
require("ggplot2")

png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
myTitle <- expression(paste("PM"[2.5], " Emissions in Baltimore City, Maryland"))
ggplot(data=BCE, aes(x=Year, y=Emissions, group = Type, colour = Type)) + geom_line() + geom_point( size=4, shape=21, fill="white") + labs(title=myTitle)
dev.off()


CE0<-SCC[grep("Comb", SCC$Short.Name),]
CE1<-CE0[grep("Coal", CE0$Short.Name),]

CE<- merge(NEI, CE1, by="SCC", all=FALSE)

CoalE<-aggregate(Emissions ~ Year, data=CE, sum)

png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
plot(CoalE$Year, CoalE$Emissions, col="blue", type='l', xlab="Year", xaxt="n", ylab="Total Emissions from Coal Combustion  (tons)", main=expression(paste("PM"[2.5], " Emissions from Coal Combustion in USA")))
axis(1, at=CoalE$Year, labels=CoalE$Year)
points(CoalE$Year, CoalE$Emissions, col="dark red", pch=19, cex=1.5)
dev.off()

MV<-SCC[grep("Veh", SCC$Short.Name),]
BCMV<- merge(MD,MV,by="SCC", all=FALSE)
BCMVE<-aggregate(Emissions ~ Year, data=BCMV, sum)

png(filename = "plot5.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
plot(BCMVE$Year, BCMVE$Emissions, col="blue", type='l', xlab="Year", xaxt="n", ylab="Total Emissions from Motor Vehicles (tons)", main=expression(paste("PM"[2.5], " Emissions from Motor Vehicles in Baltimore City, Maryland")))
axis(1, at=BCMVE$Year, labels=BCMVE$Year)
points(BCMVE$Year, BCMVE$Emissions, col="dark red", pch=19, cex=1.5)
dev.off()

LA<-NEI[NEI$fips=="06037",]
LAMV<- merge(LA,MV,by="SCC", all=FALSE)
LAMVE<-aggregate(Emissions ~ Year, data=LAMV, sum)

png(filename = "plot6.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
plot(LAMVE$Year, LAMVE$Emissions, col="blue", type='l', xlab="Year", xaxt="n", ylab="Total Emissions from Motor Vehicles (tons)", main=expression(paste("PM"[2.5], " Emissions from Motor Vehicles in Los Angeles County")))
axis(1, at=LAMVE$Year, labels=LAMVE$Year)
points(LAMVE$Year, LAMVE$Emissions, col="dark red", pch=19, cex=1.5)
dev.off()

BCMVE$City<-"Baltimore City, Maryland"
LAMVE$City<-"Los Angeles County"

MVE<-rbind(BCMVE,LAMVE)

png(filename = "plot7.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "windows"))
myTitle <- expression(paste("PM"[2.5], " Emissions from Motor Vehicles"))
ggplot(data=MVE, aes(x=Year, y=Emissions, group = City, colour = City)) + geom_line() + geom_point( size=4, shape=21, fill="white") + labs(title=myTitle)
dev.off()


