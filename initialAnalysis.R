library(plyr)
library(dplyr)
library(ggplot2)

weatherData <- read.csv("repdata-data-StormData.csv.bz2", header = TRUE, na.strings = "NA")
healthWeatherData <- data.frame(EVTYPE=factor(), FATALITIES=numeric(), INJURIES=numeric())
healthWeatherData <- weatherData[,c(8,23,24)]
healthComputed <- mutate(healthWeatherData, HealthTotal=FATALITIES+INJURIES)
healthSums <- ddply(healthComputed, .(EVTYPE), summarize, HealthTotal=sum(HealthTotal))
topHealth <- head(healthSums[order(HealthTotal, na.last = TRUE, decreasing = TRUE),])
ggplot(topHealth, aes(x = factor(EVTYPE), y = HealthTotal)) + geom_bar(stat = "identity")
ggplot(topHealth, aes(x = factor(EVTYPE), y = HealthTotal)) + geom_bar(stat = "identity", fill = "#FF9999")
