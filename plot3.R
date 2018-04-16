## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in 
#emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 

#Use the ggplot2 system to make a plot 
#answering this question.
library(ggplot2)

baltimoreNEI <- NEI[ which(NEI$fips =="24510"), ]
baltNEIByType <- split(baltimoreNEI, baltimoreNEI$type)

#here we have the list of df's
#nonroadEM <- baltNEIByType[[1]]
#nonpointEM <- baltNEIByType[[2]]
#onroadEM <- baltNEIByType[[3]]
#pointEM <- baltNEIByType[[4]]

plotList <- lapply(baltNEIByType, function(x)  tapply(x$Emissions, x$year, sum ))
#the above returns a list of em's by year per type factor yay

fullDF <- data.frame()
for (i in (1:length(plotList))){
  curDF <- data.frame(year = unique(baltimoreNEI$year))
  curData <- unlist(plotList[[i]])
  curName <- names(plotList[i])
  curDF['Total Emissions By Type'] <- curData
  curDF['Emission Type'] <- curName
  
  fullDF <- rbind(fullDF, curDF)
}

p <- ggplot(fullDF, aes(fullDF$year, fullDF$`Total Emissions By Type`, colour = fullDF$`Emission Type`)) + geom_point()

print(p)

ggsave('plot3.png')

