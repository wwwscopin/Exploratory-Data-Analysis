## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
str(NEI)
names(NEI)[5:6]<-c("Type", "Year")
head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
str(SCC)
head(SCC)

MD<-NEI[NEI$fips=="24510",]

require("ggplot2")

MV<-SCC[grep("Veh", SCC$Short.Name),]
BCMV<- merge(MD,MV,by="SCC", all=FALSE)
BCMVE<-aggregate(Emissions ~ Year, data=BCMV, sum)

LA<-NEI[NEI$fips=="06037",]
LAMV<- merge(LA,MV,by="SCC", all=FALSE)
LAMVE<-aggregate(Emissions ~ Year, data=LAMV, sum)

BCMVE$City<-"Baltimore City, Maryland"
LAMVE$City<-"Los Angeles County"

MVE<-rbind(BCMVE,LAMVE)

png(filename = "Q56.png", width = 480, height = 480, units = "px", pointsize = 12,  bg = "white",  res = NA, type = c( "cairo"))
myTitle <- expression(paste("PM"[2.5], " Emissions from Motor Vehicles"))
ggplot(data=MVE, aes(x=Year, y=Emissions, group = City, colour = City)) + 
  ylab(expression(paste("PM"[2.5], " Emissions (tons)"))) +
geom_line() + geom_point( size=4, shape=21, fill="white") + labs(title=myTitle)
dev.off()


