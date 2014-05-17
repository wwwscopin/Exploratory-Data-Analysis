## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)

MD<-NEI[NEI$fips=="24510",]


BCE<-aggregate(Emissions ~ Type + Year, data=MD, sum)
require("ggplot2")

png(filename = "Q3.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "cairo"))
myTitle <- expression(paste("PM"[2.5], " Emissions in Baltimore City, Maryland"))
ggplot(data=BCE, aes(x=Year, y=Emissions, group = Type, colour = Type)) + 
ylab(expression(paste("PM"[2.5], " Emissions (tons)"))) +
geom_line() + geom_point( size=4, shape=21, fill="white") + labs(title=myTitle)
dev.off()



