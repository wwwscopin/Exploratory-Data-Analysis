## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)

CE0<-SCC[grep("Comb", SCC$Short.Name),]
CE1<-CE0[grep("Coal", CE0$Short.Name),]

CE<- merge(NEI, CE1, by="SCC", all=FALSE)

CoalE<-aggregate(Emissions ~ Year, data=CE, sum)

png(filename = "Q4.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "cairo"))
plot(CoalE$Year, CoalE$Emissions, col="blue", type='l', xlab="Year", xaxt="n", ylab="Total Emissions from Coal Combustion  (tons)", main=expression(paste("PM"[2.5], " Emissions from Coal Combustion in USA")))
axis(1, at=CoalE$Year, labels=CoalE$Year)
points(CoalE$Year, CoalE$Emissions, col="dark red", pch=19, cex=1.5)
dev.off()
