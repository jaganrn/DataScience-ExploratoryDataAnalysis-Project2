# Exploratory Data Analysis Course Project 2 - Week4
#
# This program is to answer the following question:
#    Compare emissions from motor vehicle sources in Baltimore City with 
#    emissions from motor vehicle sources in Los Angeles County, 
#    California (fips == "06037"). Which city has seen greater changes over 
#    time in motor vehicle emissions?

# common environment setup - change this dir to where the downloaded zip file is present
setwd("/Users/jagan/work/DataScience/ExploratoryDataAnalysis/Week4/DataScience-ExploratoryDataAnalysis-Project2")
if(!file.exists("summarySCC_PM25.rds")) { #unzip for the first time
    unzip("exdata_data_NEI_data.zip")
}
summarySCCData <- readRDS("summarySCC_PM25.rds")

# get the Baltimore data for Vehicle related emissions (ON-ROAD)
BaltimoreData <- subset(summarySCCData, fips == "24510" & type=="ON-ROAD")

# get the Baltimore data for Vehicle related emissions (ON-ROAD)
LAData <- subset(summarySCCData, fips == "06037" & type=="ON-ROAD")

# generate the total PM2.5 emission from all sources by each year
totalBaltimoreEmissions <- with(BaltimoreData, tapply(BaltimoreData$Emissions, 
                                BaltimoreData$year, FUN=sum, na.rm=TRUE))

totalLAEmissions <- with(LAData, tapply(LAData$Emissions, 
                                        LAData$year, FUN=sum, na.rm=TRUE))

rng <- range(min(totalBaltimoreEmissions, totalLAEmissions), 
             max(totalBaltimoreEmissions, totalLAEmissions))

plot(names(totalBaltimoreEmissions), totalBaltimoreEmissions, type="b", 
     col="purple", xlab="Year", ylab="Total Emission (in tons)", 
     main="Total PM2.5 Emission in Baltimore from Vehicles Over Years", lwd=2, ylim=rng)

lines(names(totalLAEmissions), totalLAEmissions, type="b", col="red", lwd=2)
legend("right", c("Baltimore", "Los Angeles"), lty=1, lwd=2, col=c("purple", "red"))

# save the image into png form
dev.copy(png, "plot6.png")
dev.off()