## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)

MV<-SCC[grep("Veh", SCC$Short.Name),]
BCMV<- merge(MD,MV,by="SCC", all=FALSE)
BCMVE<-aggregate(Emissions ~ Year, data=BCMV, sum)

png(filename = "Q5.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "cairo"))
plot(BCMVE$Year, BCMVE$Emissions, col="blue", type='l', xlab="Year", xaxt="n", ylab="Total Emissions from Motor Vehicles (tons)", main=expression(paste("PM"[2.5], " Emissions from Motor Vehicles in Baltimore City, Maryland")))
axis(1, at=BCMVE$Year, labels=BCMVE$Year)
points(BCMVE$Year, BCMVE$Emissions, col="dark red", pch=19, cex=1.5)
dev.off()

