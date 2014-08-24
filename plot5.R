# Question 5:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)

# Read the data file
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")


NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

Baltimore_onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
Baltimore_df <- aggregate(Baltimore_onroad[, 'Emissions'], by=list(Baltimore_onroad$year), sum)
colnames(Baltimore_df) <- c('year', 'Emissions')


# make the plot
png('plot5.png')
ggplot(data=Baltimore_df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()
