##2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips =24510) from 1999 and 2008 ?
##Use the base plotting system to make a plot answering this question.

#set the working directory
setwd("/Users/ranjeetapegu/Documents/Coursera/exploratory-data-analysis/Coursera week2")

if(!file.exists("./NEIData")){dir.create("./NEIData")} # check if the file directory exists.
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile = "./NEIData/NEIData.zip", mode="wb") # download zip file
unzip(zipfile="./NEIData/NEIData.zip", exdir ="./NEIData") # unzippping the data
# Reading the data 
library(dplyr)
NEI <- readRDS("./NEIData/summarySCC_PM25.rds")
SCC <- readRDS("./NEIData/Source_Classification_Code.rds")
# subset the data only for Baltimore city
NEI<- subset(NEI, fips=="24510")
Emission <- aggregate(NEI$Emissions, by=list(NEI$year),FUN =sum, na.rm=TRUE)
c <- c("year","Emissions")
names(Emission) <- make.names(c)
head(Emission)

# Visual representation emission.
png(file ="plot2.png",width=480,height = 480)
barplot( Emission$Emission, names.arg = Emission$year, main="Total Emissions from PM2.5 in Baltimore City (1999-2008", xlab="Year",ylab="PM2.5 Emission (Tons)",col="light Yellow" )
abline (h=1862, lty=5, col="red", lwd=2)
dev.off()
# from the bar charts , we can clearly say the total emissions from PM2.5 in Baltimore City have decreased from 1999 to 2008

