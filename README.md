<body>
  <h1>Vehicle Clustering and Dimensionality Reduction</h1>
  <h2>1st Subtask Objectives:</h2>
  <p>
    <strong>a. Pre-processing:</strong> Before conducting k-means, perform scaling and outliers detection/removal. The order of scaling and outlier removal is important. Outlier removal is not covered in tutorials, so you need to explore it yourself.
  </p>
  <p>
    <strong>b. Determining the number of cluster centers:</strong> Use four automated tools (NBclust, Elbow, Gap statistics, and silhouette methods) to determine the optimal number of clusters. Provide the related R-outputs and your discussion on these outcomes in the report.
  </p>
  <p>
    <strong>c. K-means clustering investigation:</strong> Perform k-means analysis using all input variables and the most favored "k" value from the automated tools. Show the related R-based kmeans output, including information for the centers, clustered results, and the ratio of Between-Cluster Sums of Squares (BSS) over Total Sum of Squares (TSS). Calculate and illustrate the BSS and Within-Cluster Sums of Squares (WSS) indices as internal evaluation metrics.
  </p>
  <p>
    <strong>d. Silhouette plot:</strong> Provide the silhouette plot, which displays the closeness of each point in one cluster to points in neighboring clusters. Include the average silhouette width score and your discussion on the quality of the obtained clusters.
  </p>
  <h2>2nd Subtask Objectives:</h2>
  <p>
    <strong>e. PCA method:</strong> Apply Principal Component Analysis (PCA) to the vehicle dataset and show all R-outputs related to the analysis, including eigenvalues/eigenvectors and the cumulative score per principal component (PC). Create a new "transformed" dataset with principal components as attributes, choosing PCs that provide at least a cumulative score > 92%. Provide a brief discussion for your choice.
  </p>
  <p>
    <strong>f. Determining the number of clusters for the PCA-based dataset:</strong> Apply the four automated tools to the new PCA-based dataset. Provide the related R-outputs and your discussion on the outcomes.
  </p>
  <p>
    <strong>g. K-means clustering on the PCA-based dataset:</strong> Perform k-means analysis using the most favored k from the automated tools. Show the related R-based kmeans output, including information for the centers, clustered results, and the ratio of BSS over TSS. Calculate and illustrate the BSS and WSS indices as internal evaluation metrics.
  </p>
  <p>
    <strong>h. Silhouette plot on the PCA-based dataset:</strong> Provide the silhouette plot for evaluating the quality of the obtained clusters. Include the average silhouette width score and your discussion on the plot.
  </p>
  <p>
    <strong>i. Calinski-Harabasz Index:</strong> Implement and illustrate the Calinski-Harabasz Index as another internal evaluation metric. Provide a brief discussion on the outcome of this index.
  </p>
  <h2>Usage</h2>
  <ol>
    <li>Install R and R Studio on your machine.</li>
    <li>Clone this repository to your local system or download the code files.</li>
    <li>Open the R Studio project for this repository.</li>
    <li>Ensure that the "vehicles.xls" dataset is available in the working directory.</li>
    <li>Run the code file "1st_Subtask.R" to execute the tasks related to the 1st subtask.</li>
    <li>Review the generated outputs, including the pre-processing tasks, automated tools results, k-means analysis, and silhouette plot.</li>
    <li>Proceed to the 2nd subtask by running the code file "2nd_Subtask.R".</li>
    <li>Examine the outputs related to PCA analysis, automated tools for determining the number of clusters, k-means analysis on the PCA-based dataset, silhouette plot, and Calinski-Harabasz Index.</li>
    <li>Review the report, which includes the discussion and interpretation of the results for each subtask.</li>
  </ol>
  <h2>Appendix</h2>
  <p>
    The appendix section of the report provides the full code developed for all the tasks mentioned above. It includes the necessary functions, libraries, and step-by-step instructions for executing the analysis.
  </p>
  <h2>Dependencies</h2>
  <p>
    The code in this repository has the following dependencies:
  </p>
  <ul>
    <li>R (version 4.2.2-win)</li>
    <li>R Studio (version RStudio 2023.03.0+386 "Cherry Blossom" Release)</li>
    <li>Required R packages (list the required packages and versions)</li>
  </ul>
  <p>
    Make sure to install the required dependencies before running the code.
  </p>
  
  <h2>License</h2>
  <p>
    This project is licensed under the MIT License. Feel free to explore, modify, and use the code in this repository according to the terms of the license.
  </p>
  <footer>
    <p>
      &copy; 2023 Pasindu Geevinda. All rights reserved.
    </p>
  </footer>
</body>

