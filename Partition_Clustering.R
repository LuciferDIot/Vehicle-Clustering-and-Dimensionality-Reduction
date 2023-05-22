
library(NbClust)
library(dplyr)
library(tidyr)
library(ggplot2)
library(factoextra)
library(cluster)

script_path <- dirname(rstudioapi::getSourceEditorContext()$path);
setwd(script_path)
df <- read.csv("vehicles.csv", row.names = 1)



################# PART A. Scale data using z-score normalization ###############
df_data <- df[1:18][complete.cases(df[1:18]),]


################## Identify ourliers using boxplots and remove them ############
# Create empty list to store outlier row indices
outlier_rows <- list()

# Loop through columns and extract outlier row indices
boxplot(df_data, plot = TRUE)
for (col in names(df_data)) {
  outliers <- boxplot(df_data[[col]], plot = FALSE)$out
  row_indices <- which(df_data[[col]] %in% outliers)
  
  if (length(row_indices) > 0) {
    outlier_rows[[col]] <- as.integer(row_indices)
  }
}

outlier_rows <- unique(unlist(outlier_rows))
df_outliers_removed <- df_data[-outlier_rows, ]

boxplot(df_outliers_removed, plot = TRUE)

################################ normalizing data ##############################
#function to normalize
normalize <- function(x){
  return((x - min(x))/(max(x) - min(x)))
}

# apply normalization
pre_processed <- data.frame(lapply(df_outliers_removed, scale))
pre_processed



########################### PART B. cchecking best K value #####################
### NbClust Method
set.seed(30)
clusterNoE = NbClust(pre_processed, distance = "euclidean", min.nc = 2, max.nc = 10, method = "kmeans", index = "all")
clusterNoM = NbClust(pre_processed, distance = "manhattan", min.nc = 2, max.nc = 10, method = "kmeans", index = "all")
clusterNoMx = NbClust(pre_processed, distance = "maximum", min.nc = 2, max.nc = 10, method = "kmeans", index = "all")

### Elbow Method
set.seed(42)
fviz_nbclust(pre_processed, kmeans, method = 'wss')
#WSS = sapply(k, function(k) {kmeans(pre_processed, centers=k)$tot.withinss})
#plot(k, WSS, type="l", xlab= "Number of k", ylab="Within sum of squares")

### silhouette method
fviz_nbclust(pre_processed, kmeans, method = 'silhouette')

### Gap Statistic Algorithm
fviz_nbclust(pre_processed, kmeans, method = 'gap_stat')




######################## PART C. k-means clustering ############################
k=3
kmeans_vehicle <- kmeans(pre_processed, centers = k, nstart = 10)
kmeans_vehicle

#visualizing the clusters
fviz_cluster(kmeans_vehicle, data = pre_processed)

wss <- kmeans_vehicle$tot.withinss
bss <- kmeans_vehicle$betweenss
tss <- kmeans_vehicle$totss

sprintf("Within-cluster sum of square %.2f ", wss)
sprintf("Between sum of square %.2f", bss)
sprintf("Total sum of squares %.2f", tss)
kmeans_vehicle$centers




################ PART D. Internal metrics for cluster evaluation ###############
sil <- silhouette(kmeans_vehicle$cluster, dist(pre_processed))
fviz_silhouette(sil)
