## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)


MD<-NEI[NEI$fips=="24510",]
MDE<-tapply(MD$Emissions, MD$Year, sum)

png(filename = "Q2.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "cairo"))
plot(names(MDE), MDE, col="blue", type='l', xaxt="n", xlab="Year", ylab="Total Emissions (tons)", main=expression(paste("PM"[2.5], " Emissions in Baltimore City, Maryland")))
axis(1, at=names(MDE), labels=names(MDE))
points(names(MDE), MDE, col="dark red", pch=19, cex=1.5)
dev.off()

