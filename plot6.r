How #how have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
setwd("/Users/ranjeetapegu/Documents/Coursera/exploratory-data-analysis/Coursera week2")

if(!file.exists("./NEIData")){dir.create("./NEIData")} # check if the file directory exists.
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile = "./NEIData/NEIData.zip", mode="wb") # download zip file
unzip(zipfile="./NEIData/NEIData.zip", exdir ="./NEIData") # unzippping the data
# Reading the data 
library(dplyr)
NEI <- readRDS("./NEIData/summarySCC_PM25.rds")
SCC <- readRDS("./NEIData/Source_Classification_Code.rds")
# coal combustion-related sources 
##filter(NEI,NEI$SCC=='10100235')
x <- select(SCC,SCC, EI.Sector)
x1 <- distinct(SCC,EI.Sector )
x2 <- x1$EI.Sector
x8 <- subset(x1,grepl("Mobile",x2)=="TRUE") ## filter on the coal
mobile <-as.character(x8$EI.Sector)
SCCmobile <- SCC[ SCC$EI.Sector %in% mobile,c(1,2,4)]
SCCm <- as.character(SCCmobile$SCC)
# filter from NEI data
NEImobile <- NEI[NEI$SCC %in% SCCm & NEI$fips %in% c("24510" ,"06037") ,]
# Total emission from mobile vehicle
Emission <- aggregate(NEImobile$Emissions, by=list(NEImobile$year, NEImobile$fips),FUN =sum, na.rm=TRUE)
names(Emission) <- c("year","fips","Emission")
Emission$fips[grepl("06037",Emission$fips)]<-"Los Angeles County"
Emission$fips[grepl("24510",Emission$fips)]<-"Baltimore city"
library(ggplot2)
#Exporting the graphs

png(file ="plot6.png",width=480,height = 480)
ggplot(data=Emission , aes(x=as.character(year), y= Emission, fill=fips)) + 
  geom_bar(stat="identity" , position = position_dodge()) + xlab("year") +
  ylab("PM2.5 Emission (in Tons)") +
  ggtitle("Comparision of Emission from Motor Vehicle Sources in Baltimore City and Los Angeles County")
dev.off()

## By Comparing emission from motor vehicle sources in Baltimore city and Los Angles county from 1999 to 2008,
# We can say the definetely Los-Angeles county has seen a greater changes over time in motor vehicle emission
