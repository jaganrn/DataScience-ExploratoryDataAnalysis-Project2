# Exploratory Data Analysis Course Project 2 - Week4
#
# This program is to answer the following question:
#    How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# common environment setup - change this dir to where the downloaded zip file is present
setwd("/Users/jagan/work/DataScience/ExploratoryDataAnalysis/Week4/DataScience-ExploratoryDataAnalysis-Project2")
if(!file.exists("summarySCC_PM25.rds")) { #unzip for the first time
    unzip("exdata_data_NEI_data.zip")
}
summarySCCData <- readRDS("summarySCC_PM25.rds")

# get the Baltimore data for Vehicle related emissions (ON-ROAD)
BaltimoreData <- subset(summarySCCData, fips == "24510" & type=="ON-ROAD")

# generate the total PM2.5 emission from all sources by each year
totalEmissions <- with(BaltimoreData, tapply(BaltimoreData$Emissions, 
                       BaltimoreData$year, FUN=sum, na.rm=TRUE))

plot(names(totalEmissions), totalEmissions, type="b", 
     col="purple", xlab="Year", ylab="Total Emission (in tons)", 
     main="Total PM2.5 Emission in Baltimore from Vehicles Over Years", lwd=2)

# save the image into png form
dev.copy(png, "plot5.png")
dev.off()