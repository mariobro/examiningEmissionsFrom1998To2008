## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased 
#in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? 

#Use the base plotting system to make a plot 
#answering this question.
baltimoreNEI <- NEI[ which(NEI$fips =="24510"), ]

changeInBaltEmissions <- tapply(baltimoreNEI$Emissions, baltimoreNEI$year, sum)
relevantDataYears <- names(changeInBaltEmissions)

plot(changeInBaltEmissions,xaxt="n")
axis(1, at=1:length(relevantDataYears), labels=relevantDataYears)

dev.copy(png,'plot2.png')
dev.off()