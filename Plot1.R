library(dplyr)
library(ggplot2)

#Importing data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Filtering data
#calculate total emissions for each year
filterData <- NEI %>% 
        group_by(year) %>%
        summarise(yearPM25=sum(Emissions)/10^3)

#Plotting data
png(filename = "plot1.png",width = 480, height = 480, units="px")
barplot(filterData$yearPM25,names.arg = filterData$year,main="Total emissions from PM2.5 in US from 1999 to 2008",xlab = "Year" ,ylim=c(0,8000),ylab = "PM2.5 emission from all sources (10^3 Tons)" )
dev.off()