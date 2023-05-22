library(NbClust)
library(dplyr)
library(tidyr)
library(ggplot2)
library(factoextra)
library(cluster)

script_path <- dirname(rstudioapi::getSourceEditorContext()$path);
setwd(script_path)

################################ Substask 2 ####################################
############################### PART E. PCA ####################################
vehicleDF <- read.csv("vehicles.csv", row.names = 1)[1:18]

# Create empty list to store outlier row indices
outlier_rows <- list()

# Loop through columns and extract outlier row indices
boxplot(vehicleDF, plot = TRUE)
for (col in names(vehicleDF)) {
  outliers <- boxplot(vehicleDF[[col]], plot = FALSE)$out
  row_indices <- which(vehicleDF[[col]] %in% outliers)
  
  if (length(row_indices) > 0) {
    outlier_rows[[col]] <- as.integer(row_indices)
  }
}

outlier_rows <- unique(unlist(outlier_rows))
vehicleDF <- vehicleDF[-outlier_rows, ]

boxplot(vehicleDF, plot = TRUE)

# compute variance of each variable
apply(vehicleDF, 2, var)

# Apply PCA using prcomp()
pca <- prcomp(vehicleDF, center = TRUE, scale = TRUE)
pca_summary <- summary(pca, loadings=TRUE)
print(summary(pca))

# Extract the eigenvalues and eigenvector
(eigenvalues <- pca$sdev^2)
(eigenvectors <- data.frame(pca$rotation))

# Extract the cumulative proportion values
proportion_of_Variance <- data.frame(pca_summary$importance)[2,]

plot(1:length(proportion_of_Variance), proportion_of_Variance, type = "b",
     xlab = "Principal Component", ylab = "Proportion of Variance Explained",
     main = "Scree Plot")
abline(h = 0.92, lty = 2)

# if we used the first 6 components we would be able to account for >92% of total variance in the data.
# we are avoiding including too many components, which could result in overfitting or loss of interpretability.
# find the index of PC's that crosses the 0.92(92%) threshold
pc_indexes = list()
sorted_values <- sort(pca_summary$importance[2,], decreasing = TRUE)
sum <- 0
row <- proportion_of_Variance[1,]

index_of_list <- 1
for (i in sorted_values) {
  sum <- sum + i
  
  index <- which(row == i)
  
  pc_indexes[[index_of_list]] <- index
  index_of_list <- index_of_list +1
  if(sum>=0.92){
    break
  }
}

pc_indexes <- as.integer(unlist(pc_indexes))

transformed <- data.frame(-pca$x)[pc_indexes]

########################### PART F. cchecking best K value #####################
### NbClust Method
set.seed(30)
#clusterNoE = NbClust(transformed, distance = "euclidean", min.nc = 2, max.nc = 10, method = "kmeans", index = "all")
#clusterNoM = NbClust(transformed, distance = "manhattan", min.nc = 2, max.nc = 10, method = "kmeans", index = "all")
clusterNoMx = NbClust(transformed, distance = "maximum", min.nc = 2, max.nc = 10, method = "kmeans", index = "all")

### Elbow Method
set.seed(42)
fviz_nbclust(transformed, kmeans, method = 'wss')
#WSS = sapply(k, function(k) {kmeans(transformed, centers=k)$tot.withinss})
#plot(k, WSS, type="l", xlab= "Number of k", ylab="Within sum of squares")

### silhouette method
fviz_nbclust(transformed, kmeans, method = 'silhouette')

### Gap Statistic Algorithm
fviz_nbclust(transformed, kmeans, method = 'gap_stat')




########################### PART G. Perform k-means ############################
k=3
kmeans_vehicle_pca <- kmeans(transformed, centers = k, nstart = 10)
kmeans_vehicle_pca

wss <- kmeans_vehicle_pca$tot.withinss
bss <- kmeans_vehicle_pca$betweenss
tss <- kmeans_vehicle_pca$totss

sprintf("Within-cluster sum of square %.2f ", wss)
sprintf("Between sum of square %.2f", bss)
sprintf("Total sum of squares %.2f", tss)
kmeans_vehicle_pca$centers


################ PART D. Internal metrics for cluster evaluation ###############
sil_pca <- silhouette(kmeans_vehicle_pca$cluster, dist(transformed))
fviz_silhouette(sil_pca)



####################### PART D. Calinski-Harabasz Index ########################
library(fpc)
ch_index <- calinhara(transformed, kmeans_vehicle_pca$cluster)
sprintf("Calinski-Harabasz Index = %.2f", ch_index)
#visualizing the clusters
fviz_cluster(kmeans_vehicle_pca, data = transformed)

library('fpc')

set.seed(789)
round(calinhara(vehicleDF,kmeans_vehicle_pca$cluster), digits=2)

# Number of clusters to evaluate
k <- 2:10

# Empty vector for storing Calinski-Harabasz index values
ch_values <- vector("numeric", length(k))

# Compute the Calinski-Harabasz index for each number of clusters
for (i in 1:length(k)) {
  km <- kmeans(vehicleDF, centers = k[i], nstart = 10)
  ch_values[i] <- calinhara(vehicleDF, km$cluster)
}

# Plot the Calinski-Harabasz index values
plot(k, ch_values, type = "b", xlab = "Number of Clusters", ylab = "Calinski-Harabasz Index", main = "Calinski-Harabasz Index vs. Number of Clusters")
