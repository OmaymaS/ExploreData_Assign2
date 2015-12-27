library(dplyr)
library(ggplot2)

#Importing data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Filtering data
#Select the emmision data corresonding to Baltimore (fips=24510) 
NEI.Balt<-NEI %>%                       
        filter(fips=="24510") %>%
        group_by(year)%>%
        summarise(yearPM25=sum(Emissions)/10^3) 

#Plotting data
png(filename = "plot2.png",width = 480, height = 480, units="px")

#Use barplot from Base plot the data
barplot(NEI.Balt$yearPM25,names.arg = NEI.Balt$year,xlab = "Year",main="Total emissions from PM2.5 in Baltimore City from 1999 to 2008",ylim=c(0,4),ylab = "PM2.5 emission from all sources (10^3 Tons)")
dev.off()