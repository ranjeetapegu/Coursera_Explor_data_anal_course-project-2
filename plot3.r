# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

setwd("/Users/ranjeetapegu/Documents/Coursera/exploratory-data-analysis/Coursera week2")

if(!file.exists("./NEIData")){dir.create("./NEIData")} # check if the file directory exists.
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile = "./NEIData/NEIData.zip", mode="wb") # download zip file
unzip(zipfile="./NEIData/NEIData.zip", exdir ="./NEIData") # unzippping the data
# Reading the data 
library(dplyr)
NEI <- readRDS("./NEIData/summarySCC_PM25.rds")
SCC <- readRDS("./NEIData/Source_Classification_Code.rds")
# to get subset for Baltimore City Maryland
NEI <- filter(NEI, NEI$fips =="24510")

neitype <- aggregate(NEI$Emissions, by = list(as.character(NEI$year), NEI$type), FUN=sum,na.rm=TRUE)
head(neitype)
names(neitype) <- make.names(c("year","Type", "Emission"))
library(ggplot2)
png(file ="plot3.png",width=480,height = 480)
ggplot(data=neitype , aes(x=year, y= Emission, fill= Type)) + geom_bar(stat="identity" , position = position_dodge()) + geom_hline(yintercept = 296.795, size = 0.2) + ylab("PM2.5 Emission (Tons)") + ggtitle("Emisssion from PM2.5 from four sources in Baltimore city from 1999 to 2008")
dev.off()

# which of the sources sees increase in  emission from 1999 to 2008 :- POINT  
# which of the sources sees decrease in  emission from 1999 to 2008 :- NON-ROAD, NONPOINT, ON-ROAD

