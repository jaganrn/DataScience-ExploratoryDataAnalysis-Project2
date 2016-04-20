# Exploratory Data Analysis Course Project 2 - Week4
#
# This program is to answer the following question:
#    Have total emissions from PM2.5 decreased in the Baltimore City, 
#    Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
#    to make a plot answering this question.


# common environment setup - change this dir to where the downloaded zip file is present
setwd("/Users/jagan/work/DataScience/ExploratoryDataAnalysis/Week4/DataScience-ExploratoryDataAnalysis-Project2")
if(!file.exists("summarySCC_PM25.rds")) { #unzip for the first time
    unzip("exdata_data_NEI_data.zip")
}
summarySCCData <- readRDS("summarySCC_PM25.rds")

# get the Baltimore data
BaltimoreData <- subset(summarySCCData, fips == "24510")

# generate the total PM2.5 emission from all sources by each year
totalEmissions <- with(BaltimoreData, tapply(BaltimoreData$Emissions, 
                       BaltimoreData$year, FUN=sum, na.rm=TRUE))

plot(names(totalEmissions), totalEmissions, type="b", 
     col="purple", xlab="Year", ylab="Total Emission (in tons)", 
     main="Total PM2.5 Emission in Baltimore Over Years", lwd=2)

# save the image into png form
dev.copy(png, "plot2.png")
dev.off()