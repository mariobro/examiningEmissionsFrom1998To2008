## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Use the ggplot2 system to make a plot 
#answering this question.
library(ggplot2)
library(stringr)
library(dplyr)

baltimoreNEI <- NEI[ which(NEI$fips =="24510"), ]
laNEI <- NEI[ which(NEI$fips =="06037"), ]

mvSCC <- SCC %>%
  filter(str_detect(SCC.Level.Two, "ehicle"))

relevantSCCNums <- mvSCC$SCC

relevantSCCNumsChar <- as.character(relevantSCCNums)

copyNEI <- baltimoreNEI
copyNEI['wantedSCC'] <- baltimoreNEI$SCC %in% relevantSCCNumsChar
relNEI<- subset(copyNEI, wantedSCC==TRUE)

laCopyNEI <- laNEI
laCopyNEI['wantedSCC'] <- laNEI$SCC %in% relevantSCCNumsChar
laRelNEI<- subset(laCopyNEI, wantedSCC==TRUE)

motor.Vehicle.Emissions.Balt <- tapply(relNEI$Emissions, relNEI$year, sum)
motor.Vehicle.Emissions.LA <- tapply(laRelNEI$Emissions, laRelNEI$year, sum)


relevantDataYears <- names(motor.Vehicle.Emissions.Balt)

baltDF <- data.frame(year = relevantDataYears, total.Emissions = motor.Vehicle.Emissions.Balt, city = 'Baltimore')
laDF <- data.frame(year = relevantDataYears, total.Emissions = motor.Vehicle.Emissions.LA, city = 'Los Angeles')

laBaltDF <- rbind(baltDF, laDF)

p <- ggplot(laBaltDF, aes(year, total.Emissions, colour = city)) + geom_point()

print(p)

ggsave('plot6.png')

