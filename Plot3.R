library(dplyr)
library(ggplot2)

#Importing data 
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Filtering data
#Select the emmision data corresonding to Baltimore (fips=24510) and group by year & type
NEI.Balt<-NEI %>%
        filter(fips=="24510") %>%
        group_by(year,type)%>%     
        summarise(TypePM25=sum(Emissions)/10^3)

#Plotting data
png(filename = "plot3.png",width = 800, height = 800, units="px")

#Use ggplot to plot the data with 4 facets based on the source type
g<-ggplot(NEI.Balt,aes(x=factor(year),y=TypePM25,fill=type))+                   #initial call to ggplot
        geom_bar(stat = "identity")+facet_grid(~type,scale="free")+             #adding the bar plot layer and the facets
        labs(title="Total emissions from PM2.5 in Baltimore City in four years by source type")+ #adding title
        labs(x="Year",y="PM2.5 emission from all sources (10^3 Tons)")          #adding labels 
print(g)
dev.off()