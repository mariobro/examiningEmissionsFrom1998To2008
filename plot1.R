## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

changeInUSEmissions <- tapply(NEI$Emissions, NEI$year, sum)
relevantDataYears <- names(changeInUSEmissions)

plot(changeInUSEmissions,xaxt="n")
axis(1, at=1:length(relevantDataYears), labels=relevantDataYears)

dev.copy(png,'plot1.png')
dev.off()