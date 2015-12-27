library(dplyr)
library(ggplot2)

#Importing data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Filtering data
#Find the index of the rows containing  coal combustion-related sources in SCC
idx<-grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case=T)

#Select the emission data from NEI where NEI$SCC rows correspond to SCC$SCC values extracted based on idx
NEI.Coal<-NEI %>%
        filter(NEI$SCC %in% as.character(SCC$SCC[idx])) %>% 
        group_by(year) %>%
        summarise(yearPM25=sum(Emissions)/10^3)

#Plotting data
png(filename = "plot4.png",width = 800, height = 800, units="px")

#Use ggplot to plot the data
g<-ggplot(NEI.Coal,aes(x=factor(year),y=yearPM25))+
        geom_bar(stat = "identity")+
        labs(title="PM2.5 emissions from coal combustion-related sources in US from 1999-2008")+
        labs(x="Year",y="PM2.5 emission from coal combustion-related sources (10^3 Tons)")
print(g)
dev.off()


#Extra-4-------------------------------------------#
#This extra plot seperates the coal combustion-related sources data by the EI.Sector 

SCCdata<-SCC #rename SCC in order not to confuse the dataframe with the column name

NEI.Coalex<-NEI %>%
        filter(NEI$SCC %in% as.character(SCC$SCC[idx])) %>% #Select the emission data from NEI where NEI$SCC rows correspond to SCC$SCC values extracted based on idx
        mutate(EI.Sector=SCCdata[match(SCC,SCCdata[,"SCC"]),"EI.Sector"]) %>% #add a column with the EI.Sector from SCCdata corresponding to NEI$SCC values extracted based on idx
        group_by(year, EI.Sector) %>%
        summarise(yearPM25=sum(Emissions)/10^3)

png(filename = "plot4_extra.png",width = 800, height = 800, units="px")

#Use ggplot to plot the data with facets based on EI.Sector
g<-ggplot(NEI.Coalex,aes(x=factor(year),y=yearPM25),ylim=c(0,500))+
        geom_bar(stat = "identity")+facet_grid(~EI.Sector)+
        labs(title="PM2.5 emissions from coal combustion-related sources in US from 1999-2008 by sector")+
        labs(x="Year",y="PM2.5 emission from coal combustion-related sources (10^3 Tons)")
print(g)
dev.off()
#Extra-4-------------------------------------------------#