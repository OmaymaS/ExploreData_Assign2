library(dplyr)
library(ggplot2)

#Importing data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Filtering data
#Assume the motor vehicle sources correspond to type=="ON-ROAD" in NEI
NEI.OnRoad<-NEI %>%
        filter(fips=="24510",type=="ON-ROAD") %>% #filter the data corresponding to Baltimore city fips=="24510"
        group_by(year) %>%
        summarise(yearPM25=sum(Emissions)/10^3)

#Plotting data
png(filename = "plot5.png",width = 800, height = 800, units="px")

#Use ggplot to plot the data
g<-ggplot(NEI.OnRoad,aes(x=factor(year),y=yearPM25))+
        geom_bar(stat = "identity")+
        labs(title="PM2.5  emissions from motor vehicle sources from 1999-2008 in Baltimore City")+
        labs(x="Year",y="PM2.5 emissions from coal combustion-related sources (10^3 Tons)")
print(g)
dev.off()
