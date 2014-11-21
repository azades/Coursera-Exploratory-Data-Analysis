----------------------------------
Week 2 - Exploratory Data Analysis
----------------------------------

-----------------------
Lattice Plotting System
-----------------------
#Simple Lattice Plot
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)
#Simple Lattice Plot
library(lattice)
library(datasets)
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))
#Lattice Panel Functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1))  #Plot with 2 panels
#Lattice Panel Functions
xyplot(y ~ x | f, panel = function(x, y, ...) {
        panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'
        panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})
#Lattice Panel Functions: Regression line
xyplot(y ~ x | f, panel = function(x, y, ...) {
        panel.xyplot(x, y, ...)  ## First call default panel function
        panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})

---------------
ggplot2 - qplot
---------------
#qplot
library(ggplot2)
str(mpg)
qplot(displ, hwy, data = mpg)
#Modifying aesthetics
qplot(displ, hwy, data = mpg, color = drv)
#Adding a geom
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
#Histograms
qplot(hwy, data = mpg, fill = drv)
#Facets
qplot(displ, hwy, data = mpg, facets = . ~ drv)
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)
#Examples Data set: MAACS Cohort
str(maacs)
qplot(log(eno), data = maacs)
qplot(log(eno), data = maacs, fill = mopos)
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, geom = "density", color = mopos)
qplot(log(pm25), log(eno), data = maacs)
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos)
qplot(log(pm25), log(eno), data = maacs, color = mopos, 
      geom = c("point", "smooth"), method = "lm")
qplot(log(pm25), log(eno), data = maacs, geom = c("point", "smooth"), 
      method = "lm", facets = . ~ mopos)

----------------
ggplot2 - ggplot
----------------
#qplot
qplot(log(pm25), NocturnalSympt, data = maacs, facets = . ~ bmicat, geom = 
              c("point", "smooth"), method = "lm")
#ggplt - Building up in layers
head(maacs)
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)
#addin plot function
p <- g + geom_point()
print(p)
#auto print plot object
g + geom_point()
#First Plot with Point Layer
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
g + geom_point()
#Adding More Layers: Smooth
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")
#Adding More Layers: Facets
g + geom_point() + facet_grid( . ~ bmicat) + geom_smooth(method = "lm")
#Modifying Aesthetics
g + geom_point(color = "steelblue", size = 4, alpha = 1/2)
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)
#Modifying Labels
g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") + 
        labs(x = expression("log " * PM[2.5]), y = "Nocturnal Symptoms")
#Customizing the Smooth
g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) +
        geom_smooth(size = 4, linetype = 3,  method = "lm", se = FALSE)
#Changing the Theme
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times"€)
#Axis Limits
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100 ## Outlier!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))
#plot
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()
#plot
g + geom_line() + ylim(-3, 3)
#plot
g + geom_line() + coord_cartesian(ylim = c(-3, 3)
#Example
How  does  the  rela:onship  between  PM2.5 and  nocturnal  symptoms  vary  by 
BMI  and  NO2?
#Calculate the deciles of the data
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 11), na.rm = TRUE)
#Cut the data at the deciles and create a new factor variable
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)
#See the levels of the newly created factor variable
levels(maacs$no2dec)
#Final Plot
#Setup ggplot with data frame
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
## Add layers
g + geom_point(alpha = 1/3)
+ facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4)
+ geom_smooth(method="lm", se=FALSE, col="steelblue")
+ theme_bw(base_family = "Avenir", base_size = 10)
+ labs(x = expression("log " * PM[2.5])
+ labs(y = "Nocturnal Symptoms")
+ labs(title = "MAACS Cohort")


