## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Use the ggplot2 system to make a plot 
#answering this question.
library(ggplot2)
library(stringr)
library(dplyr)

coalSCC <- SCC %>%
  filter(str_detect(SCC.Level.Three, "Coal"))

coalCombSCC <- coalSCC %>%
  filter(str_detect(SCC.Level.One, "Comb"))

relevantSCCNums <- coalCombSCC$SCC

relevantSCCNumsChar <- as.character(relevantSCCNums)

copyNEI <- NEI
copyNEI['wantedSCC'] <- NEI$SCC %in% relevantSCCNumsChar
relNEI<- subset(copyNEI, wantedSCC==TRUE)


Coal.Comb.Emissions <- tapply(relNEI$Emissions, relNEI$year, sum)
relevantDataYears <- names(Coal.Comb.Emissions)

p <- qplot(relevantDataYears, Coal.Comb.Emissions)
print(p)

ggsave('plot4.png')

