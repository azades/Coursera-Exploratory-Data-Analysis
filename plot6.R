# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == 06037).
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

# Read the data file
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland
# Los Angeles County, California
Baltimore_onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
LA_onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate
Baltimore_df <- aggregate(Baltimore_onroad[, 'Emissions'], by=list(Baltimore_onroad$year), sum)
colnames(Baltimore_df) <- c('year', 'Emissions')
Baltimore_df$City <- paste(rep('MD', 4))

LA_df <- aggregate(LA_onroad[, 'Emissions'], by=list(LA_onroad$year), sum)
colnames(LA_df) <- c('year', 'Emissions')
LA_df$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(Baltimore_df, LA_df))


# make the plot
png('plot6.png')
ggplot(data=DF, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
dev.off()


dev.off()
