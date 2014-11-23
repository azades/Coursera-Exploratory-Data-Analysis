----------------------------------
Week 3 - Exploratory Data Analysis       
----------------------------------

-----------------------
Hierarchical clustering
-----------------------
#Hierarchical clustering - example
set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
#Hierarchical clustering - dist
dataFrame <- data.frame(x = x, y = y)
dist(dataFrame)
#Hierarchical clustering - hclust
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)
#heatmap()
dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)

-----------------
kmeans Clustering
-----------------
#Kmeans clustering - example
set.seed(1234)
par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
#kmeans()
dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj$cluster
#kmeans(), plotting the clusters and centroids
par(mar = rep(0.2, 4))
plot(x,y, col = kmeansObj$cluster, pch = 19, cex = 2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)

-------------------
Dimension Reduction
-------------------
        
-----------------------
Plotting and Color in R
-----------------------
#colorRamp
pal <- colorRamp(c("red", "blue"))
#[,1] [,2] [,3] corresponds to [Red] [Blue] [Green]
pal(0)
pal(1)
pal(0.5)
#colorRamp
pal(seq(0, 1, len = 10))
#colorRampPalette
pal <- colorRampPalette(c("red", "yellow"))
pal(2)
pal(10)
#RColorBrewer and colorRampPalette
library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
cols
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))
#The smoothScatter function
x <- rnorm(10000)
y = rnorm(10000)
smoothScatter(x, y)
#Scatterplot with no transparency
plot(x, y, pch = 19)
#Scatterplot with transparency
plot(x, y, col = rgb(0,0,0,0, 0.2), pch = 19)