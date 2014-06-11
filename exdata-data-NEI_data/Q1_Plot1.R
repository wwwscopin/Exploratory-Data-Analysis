## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)

TotE<-tapply(NEI$Emissions,NEI$Year, sum)

png(filename = "Q1.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "cairo"))
plot(names(TotE), TotE, col="blue", type='l', xaxt="n", xlab="Year", ylab="Total Emissions (tons)", main=expression(paste("PM"[2.5], " Emissions in USA")))
axis(1, at=names(TotE), labels=names(TotE))
points(names(TotE), TotE, col="dark red", pch=19, cex=1.5)
#text(names(TotE), TotE, names(TotE), cex=0.8, pos=3, col="red") 
dev.off()
