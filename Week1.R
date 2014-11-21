----------------------------------
Week 1 - Exploratory Data Analysis 
----------------------------------
        
-------------------
Exploratory Graphs
-------------------                
#Data
pollution <- read.csv("data/avgpm25.csv", colClasses = c("numeric", "character", 
                                                                 "factor", "numeric", "numeric"))
head(pollution)
#Five Number Summary
summary(pollution$pm25)
#Boxplot
boxplot(pollution$pm25, col = "blue")
#Histogram
hist(pollution$pm25, col = "green")
#Histogram
hist(pollution$pm25, col = "green")
rug(pollution$pm25)
#Histogram
hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)
#Overlaying Features
boxplot(pollution$pm25, col = "blue")
abline(h = 12)
#Overlaying Features
hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)
#Barplot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")
#Multiple Boxplots
boxplot(pm25 ~ region, data = pollution, col = "red")
#Multiple Histograms
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")
#Scatterplot
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)
#Scatterplot - Using Color
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)
#Multiple Scatterplots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))

---------------------
Plotting Systems in R
---------------------
#Base Plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))
#Lattice Plot
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))
#ggplot2 Plot
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

--------------------
Base Plotting System
--------------------
#Histogram
library(datasets)
hist(airquality$Ozone)  ## Draw a new plot
#Scatterplot
library(datasets)
with(airquality, plot(Wind, Ozone))
#Boxplot
library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
#par()
par("lty")
par("col")
par("pch")
par("bg")
par("mar")
par("mfrow")
#Base Plot with Annotation
library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")  ## Add a title
#Base Plot with Annotation
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
#Base Plot with Annotation
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", 
                      type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))
#Base Plot with Regression Line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", 
                      pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)
#Multiple Base Plots
par(mfrow = c(1, 2))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})
#Multiple Base Plots
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
        mtext("Ozone and Weather in New York City", outer = TRUE)
})
