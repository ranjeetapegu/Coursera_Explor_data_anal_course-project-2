#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

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
Emission <- aggregate(NEI$Emissions, by=list(NEI$year),FUN =sum, na.rm=TRUE)
c <- c("year","Emissions")
names(Emission) <- make.names(c)
# Visual representation emission.
png(file ="plot1.png",width=480,height = 480)
barplot(Emission$Emissions/10^6,width=1 ,names.arg  = Emission$year,
        col='blue' ,xlab="year",ylab="PM2.5 Emission (10^6 Tons)")
abline(h=3.46, lty= 5, col ="red", lwd=2)
dev.off()

# From the bar chart , we can safely say the emissions from PM2.5 in Unites states decrease from 1999 to 2008

