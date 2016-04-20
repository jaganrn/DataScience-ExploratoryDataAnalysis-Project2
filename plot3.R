# Exploratory Data Analysis Course Project 2 - Week4
#
# This program is to answer the following question:
#    Of the four types of sources indicated by the type 
#    (point, nonpoint, onroad, nonroad) variable, which of these 
#    four sources have seen decreases in emissions from 1999–2008 for 
#    Baltimore City? Which have seen increases in emissions from 1999–2008? 
#    Use the ggplot2 plotting system to make a plot answer this question.

# common environment setup - change this dir to where the downloaded zip file is present
library(ggplot2)
setwd("/Users/jagan/work/DataScience/ExploratoryDataAnalysis/Week4/DataScience-ExploratoryDataAnalysis-Project2")
if(!file.exists("summarySCC_PM25.rds")) { #unzip for the first time
    unzip("exdata_data_NEI_data.zip")
}
summarySCCData <- readRDS("summarySCC_PM25.rds")

# get the Baltimore data
BaltimoreData <- subset(summarySCCData, fips == "24510")

# generate the total PM2.5 emission from all sources by each year & type
totalEmissions <- aggregate(Emissions~type+year, BaltimoreData,
                                  FUN=sum, na.rm=TRUE)

g <- ggplot(totalEmissions, aes(year, Emissions, color=type)) + 
     geom_line() + xlab("Year") + ylab("Total Emission (in tons)") +
     ggtitle("Total PM2.5 Emission in Baltimore by Type")
print(g)

# save the image into png form
dev.copy(png, "plot3.png")
dev.off()