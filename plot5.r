#how have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
setwd("/Users/ranjeetapegu/Documents/Coursera/exploratory-data-analysis/Coursera week2")

if(!file.exists("./NEIData")){dir.create("./NEIData")} # check if the file directory exists.
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile = "./NEIData/NEIData.zip", mode="wb") # download zip file
unzip(zipfile="./NEIData/NEIData.zip", exdir ="./NEIData") # unzippping the data
# Reading the data 
library(dplyr)
NEI <- readRDS("./NEIData/summarySCC_PM25.rds")
SCC <- readRDS("./NEIData/Source_Classification_Code.rds")

x <- select(SCC,SCC, EI.Sector)
x1 <- distinct(SCC,EI.Sector )
x2 <- x1$EI.Sector
x8 <- subset(x1,grepl("Mobile",x2)=="TRUE")
## filter on the coal
mobile <-as.character(x8$EI.Sector)
SCCmobile <- SCC[ SCC$EI.Sector %in% mobile,c(1,2,4)]
SCCm <- as.character(SCCmobile$SCC)
# filter from Emission from Motor vehicle in Baltimore
NEImobile <- NEI[NEI$SCC %in% SCCm & NEI$fips=="24510",]
d <- merge(NEImobile,SCCmobile, by="SCC")
# Total emission from mobile vehicle
Emission <- aggregate(d$Emissions, by=list(d$year,d$EI.Sector),FUN =sum, na.rm=TRUE)
names(Emission) <- make.names(c("year","Motor Vehicle Source", "Emission"))
head(Emission)
# will use ggplot2 system and bar charts
library(ggplot2)
png(file ="plot5.png", width=480, height=480)
ggplot(data=Emission , aes(x=as.character(year), y= Emission, fill= Motor.Vehicle.Source)) +
  geom_bar(stat="identity" , position = position_dodge()) + xlab("Year") + 
  ylab("PM2.5 Emission (Tons )") +
  ggtitle("Emisssion from Motor Vehicle in Baltimore city from 1999 to 2008")
dev.off()

## we can conclude that emission from most of Motor vehicle have decrease; Excepts
#Emission from Mobile - Non-Road Equipment - Gasoline has increase from 1999 to 2008;
# Emission from Mobile - Non-Road Equipment - Other has increase very slightly.
#Data from Emission from Aircraft is available only for year 2008

