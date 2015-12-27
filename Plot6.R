library(dplyr)
library(ggplot2)

#Importing data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Filtering data
#Assume the motor vehicle sources correspond to type=="ON-ROAD" in NEI
NEI.OnRoad<-NEI %>%
filter(fips=="24510" | fips=="06037",type=="ON-ROAD") %>% #filter the data corresponding to Baltimore city fips=="24510" and LA fips=="06037"
        group_by(year,fips) %>%
        summarise(yearPM25=sum(Emissions)/10^3)

#Create look up table to replace the cities' code by the name
lut<-c("06037"="Baltimore","24510"="LA")
NEI.OnRoad$fips<-lut[NEI.OnRoad$fips]

#Plotting data
png(filename = "plot6.png",width = 800, height = 800, units="px")

#Use ggplot to plot the data with facets based on the city 
g<-ggplot(NEI.OnRoad,aes(x=factor(year),y=yearPM25))+
        geom_bar(stat = "identity")+facet_grid(~fips)+
        labs(title="PM2.5  emissions from motor vehicle sources from 1999-2008 in Baltimore & LA City")+
        labs(x="Year",y="PM2.5 emissions from coal combustion-related sources (10^3 Tons)")

print(g)
dev.off()