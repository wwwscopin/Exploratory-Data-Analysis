## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)

LA<-NEI[NEI$fips=="06037",]
LAMV<- merge(LA,MV,by="SCC", all=FALSE)
LAMVE<-aggregate(Emissions ~ Year, data=LAMV, sum)

png(filename = "Q6.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "cairo"))
plot(LAMVE$Year, LAMVE$Emissions, col="blue", type='l', xlab="Year", xaxt="n", ylab="Total Emissions from Motor Vehicles (tons)", main=expression(paste("PM"[2.5], " Emissions from Motor Vehicles in Los Angeles County")))
axis(1, at=LAMVE$Year, labels=LAMVE$Year)
points(LAMVE$Year, LAMVE$Emissions, col="dark red", pch=19, cex=1.5)
dev.off()
