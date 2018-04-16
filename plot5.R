## This first line will likely take a few seconds. Be patient!
#REMOVE HASHTAGS ONCE YOU ARE DONE
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Use the ggplot2 system to make a plot 
#answering this question.
library(ggplot2)
library(stringr)
library(dplyr)

baltimoreNEI <- NEI[ which(NEI$fips =="24510"), ]

mvSCC <- SCC %>%
  filter(str_detect(SCC.Level.Two, "ehicle"))

relevantSCCNums <- mvSCC$SCC

relevantSCCNumsChar <- as.character(relevantSCCNums)

copyNEI <- baltimoreNEI
copyNEI['wantedSCC'] <- baltimoreNEI$SCC %in% relevantSCCNumsChar
relNEI<- subset(copyNEI, wantedSCC==TRUE)


motor.Vehicle.Emissions <- tapply(relNEI$Emissions, relNEI$year, sum)
relevantDataYears <- names(motor.Vehicle.Emissions)

p <- qplot(relevantDataYears, motor.Vehicle.Emissions)
print(p)

ggsave('plot5.png')

