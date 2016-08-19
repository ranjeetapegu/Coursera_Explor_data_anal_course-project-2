#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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
x <- select(SCC,SCC, EI.Sector)
x1 <- distinct(SCC,EI.Sector )
x2 <- x1$EI.Sector
x8 <- subset(x1,grepl("Coal",x2)=="TRUE")
## filter on the coal
coal <- as.character(x8$EI.Sector)
SCCcoal<- SCC[ SCC$EI.Sector %in% coal,c(1,2,4)]
SCCc <- as.character(SCCcoal$SCC)
Neicoal <- NEI[NEI$SCC %in% SCCc, ]
d <- merge(Neicoal,x, by="SCC")
Emission <- aggregate(d$Emissions, by=list(d$year, d$EI.Sector),FUN =sum, na.rm=TRUE)
names(Emission) <- make.names(c("year","CoalSource","Emission"))
head(Emission)
library(ggplot2)
#Exporting the graphs

png(file ="plot4.png",width=480,height = 480)
ggplot(data=Emission , aes(x=as.character(year), y= Emission/10^5, fill= CoalSource)) +
  geom_bar(stat="identity" , position = position_dodge()) + xlab("Year") + 
  ylab("PM2.5 Emission (Tons 10^5)") +
  ggtitle("Emisssion from Coal Combustion-related Source Across USA from 1999 to 2008") +
  geom_hline(yintercept = 0.179, size = 0.5,color= "red")
dev.off()
## From the graph it is clear that there is overall decrease in emission from coal combustion -related source 
## but emission fuel com -Industiral boilers, ICEs-Coal has increase slightly from 1999 to 2008
