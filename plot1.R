# Exploratory Data Analysis Course Project 2 - Week4
#
# This program is to answer the following question:
#     Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#     Using the base plotting system, make a plot showing the total PM2.5 emission from 
#     all sources for each of the years 1999, 2002, 2005, and 2008.

# common environment setup - change this dir to where the downloaded zip file is present
setwd("/Users/jagan/work/DataScience/ExploratoryDataAnalysis/Week4/DataScience-ExploratoryDataAnalysis-Project2")
if(!file.exists("summarySCC_PM25.rds")) { #unzip for the first time
    unzip("exdata_data_NEI_data.zip")
}
summarySCCData <- readRDS("summarySCC_PM25.rds")

# generate the total PM2.5 emission from all sources by each year
totalEmissions <- with(summarySCCData, tapply(summarySCCData$Emissions, 
                       summarySCCData$year, FUN=sum, na.rm=TRUE))

plot(names(totalEmissions), totalEmissions, type="b", 
     col="purple", xlab="Year", ylab="Total Emission (in tons)", 
     main="Total PM2.5 Emission Over Years", lwd=2)

# save the image into png form
dev.copy(png, "plot1.png")
dev.off()