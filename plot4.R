# Exploratory Data Analysis Course Project 2 - Week4
#
# This program is to answer the following question:
#    Across the United States, how have emissions 
#    from coal combustion-related sources changed from 1999–2008?

# common environment setup - change this dir to where the downloaded zip file is present
library(ggplot2)
setwd("/Users/jagan/work/DataScience/ExploratoryDataAnalysis/Week4/DataScience-ExploratoryDataAnalysis-Project2")
if(!file.exists("Source_Classification_Code.rds") || !file.exists("summarySCC_PM25.rds")) { #unzip for the first time
    unzip("exdata_data_NEI_data.zip")
}
summarySCCData <- readRDS("summarySCC_PM25.rds")
sourceClassificationCodeData <- readRDS("Source_Classification_Code.rds")

coalClassificationCodes <- sourceClassificationCodeData[grepl("coal", 
                           sourceClassificationCodeData$Short.Name, 
                           ignore.case = TRUE), ]
# get the Baltimore data
coalData <- subset(summarySCCData, summarySCCData$SCC %in% coalClassificationCodes$SCC)

# generate the total PM2.5 emission from coal sources by each year
totalEmissions <- with(coalData, tapply(coalData$Emissions, 
                                              coalData$year, FUN=sum, na.rm=TRUE))

plot(names(totalEmissions), totalEmissions, type="b", 
     col="purple", xlab="Year", ylab="Total Emission (in tons)", 
     main="Total PM2.5 Emission Over Years from Coal", lwd=2)

# save the image into png form
dev.copy(png, "plot4.png")
dev.off()