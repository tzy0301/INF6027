getwd()
setwd("C:/Users/ASUS/桌面/learning/6027introtodatascience")
spotifydata= read.csv('dataset.csv')
View(spotifydata)
View(death_metal_tracks)
death_metal_df <- read.csv("death_metal_tracks.csv")
# Check for missing values
missing_values <- colSums(is.na(death_metal_df))
print(missing_values)
# boxplot
par(mfrow = c(1, 8))  
boxplot(death_metal_df$popularity, main = "Boxplot of Popularity", ylab = "Popularity")
boxplot(death_metal_df$duration_ms, main = "Boxplot of Duration", ylab = "Duration (ms)")
boxplot(death_metal_df$danceability, main = "Boxplot of Danceability", ylab = "Danceability")
boxplot(death_metal_df$key, main = "Boxplot of Key", ylab = "Key")
boxplot(death_metal_df$loudness, main = "Boxplot of Loudness", ylab = "Loudness (dB)")
boxplot(death_metal_df$speechiness, main = "Boxplot of Speechiness", ylab = "Speechiness")
boxplot(death_metal_df$instrumentalness, main = "Boxplot of Instrumentalness", ylab = "Instrumentalness")
boxplot(death_metal_df$tempo, main = "Boxplot of Tempo", ylab = "Tempo (BPM)")


# Fill outliers with median
Q1 <- quantile(death_metal_df$duration_ms, 0.25)
Q3 <- quantile(death_metal_df$duration_ms, 0.75)
IQR <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR
outliers <- death_metal_df$duration_ms[death_metal_df$duration_ms < lower_bound | death_metal_df$duration_ms > upper_bound]
print(outliers)
death_metal_df$duration_ms[death_metal_df$duration_ms < lower_bound | death_metal_df$duration_ms > upper_bound] <- median(death_metal_df$duration_ms, na.rm = TRUE)
outliers_after <- death_metal_df$duration_ms[death_metal_df$duration_ms < lower_bound | death_metal_df$duration_ms > upper_bound]
print(outliers_after)

# standardize
standardize <- function(x) {
  return((x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE))
}
death_metal_df_standardized <- as.data.frame(lapply(death_metal_df, function(col) {
  if (is.numeric(col)) {
    return(standardize(col))
  } else {
    return(col)
  }
}))
print(head(death_metal_df_standardized))

# histogram
library(ggplot2)
ggplot(death_metal_df, aes(x = popularity)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  labs(title = "Distribution of Popularity", x = "Popularity", y = "Frequency")

# correlation matrix heatmap
correlation_matrix <- cor(death_metal_df[, c("duration_ms", "danceability", "loudness", "speechiness", "instrumentalness", "tempo", "popularity")])
print(correlation_matrix)
install.packages('reshape2')
library(reshape2)
correlation_melted <- melt(correlation_matrix)
ggplot(correlation_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "black") +  # 顯示相關係數，保留兩位小數
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), 
                       name = "Correlation") +
  labs(title = "Correlation Matrix Heatmap", x = "Variables", y = "Variables") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # 旋轉 x 軸標籤

# PCA
df_scaled <- scale(death_metal_df[, c("duration_ms", "danceability", "loudness", "speechiness", "instrumentalness", "tempo", "popularity")])
pca_result <- prcomp(df_scaled, center = TRUE, scale. = TRUE)
summary(pca_result)
pca_data <- as.data.frame(pca_result$x)
ggplot(pca_data, aes(x = PC1, y = PC2)) +
  geom_point() +
  labs(title = "PCA Result", x = "PC 1", y = "PC 2") +
  theme_minimal()
install.packages("car", type = "binary")
install.packages("leaps", type = "binary")
install.packages("FactoMineR")
install.packages("factoextra")
install.packages("plotly")
library(FactoMineR)
library(factoextra)
library(plotly)
str(death_metal_tracks)
death_metal_tracks$duration_ms <- as.numeric(as.character(death_metal_tracks$duration_ms))
death_metal_tracks$popularity <- as.numeric(as.character(death_metal_tracks$popularity))
numeric_data <- death_metal_tracks[, c("danceability", "tempo", "duration_ms", 
                                       "loudness", "speechiness", "instrumentalness", 
                                       "popularity")]
numeric_data_scaled <- scale(numeric_data)

pca_result <- PCA(numeric_data_scaled, graph = FALSE)
summary(pca_result)
# PCA scree plot
fviz_eig(pca_result, addlabels = TRUE, ylim = c(0, 100)) +
  labs(title = "Scree Plot of Explained Variance", x = "Principal Components", y = "Percentage of Explained Variance") +
  theme_minimal()

#PCA biplot
fviz_pca_biplot(pca_result, 
                geom.ind = FALSE,     # 不顯示數據點
                col.var = "contrib", 
                gradient.cols = c("steelblue", "orange", "darkgreen"),
                repel = TRUE,         # 避免標籤重疊
                label = "var")        # 顯示所有變數的箭頭


#from numeric variables to categorical variables(for chis)
death_metal_tracks$duration_cat <- cut(death_metal_tracks$duration_ms, 
                                       breaks = quantile(death_metal_tracks$duration_ms, probs = seq(0, 1, 0.2), na.rm = TRUE), 
                                       include.lowest = TRUE, 
                                       labels = paste0("Q", 1:5))  # 使用四分位數進行分類

death_metal_tracks$danceability_cat <- cut(death_metal_tracks$danceability, 
                                           breaks = quantile(death_metal_tracks$danceability, probs = seq(0, 1, 0.2), na.rm = TRUE), 
                                           include.lowest = TRUE, 
                                           labels = paste0("Q", 1:5))

death_metal_tracks$tempo_cat <- cut(death_metal_tracks$tempo, 
                                    breaks = quantile(death_metal_tracks$tempo, probs = seq(0, 1, 0.2), na.rm = TRUE), 
                                    include.lowest = TRUE, 
                                    labels = paste0("Q", 1:5))

death_metal_tracks$loudness_cat <- cut(death_metal_tracks$loudness, 
                                       breaks = quantile(death_metal_tracks$loudness, probs = seq(0, 1, 0.2), na.rm = TRUE), 
                                       include.lowest = TRUE, 
                                       labels = paste0("Q", 1:5))
death_metal_tracks$speechiness_cat <- cut(death_metal_tracks$speechiness, 
                                          breaks = quantile(death_metal_tracks$speechiness, probs = seq(0, 1, 0.2), na.rm = TRUE), 
                                          include.lowest = TRUE, 
                                          labels = paste0("Q", 1:5))
death_metal_tracks$instrumentalness_cat <- cut(death_metal_tracks$instrumentalness, 
                                               breaks = quantile(death_metal_tracks$instrumentalness, probs = seq(0, 1, 0.2), na.rm = TRUE), 
                                               include.lowest = TRUE, 
                                               labels = paste0("Q", 1:5))

# chisq test
death_metal_tracks$popularity <- as.factor(death_metal_tracks$popularity)
chisq_duration <- chisq.test(table(death_metal_tracks$popularity, death_metal_tracks$duration_cat))
chisq_danceability <- chisq.test(table(death_metal_tracks$popularity, death_metal_tracks$danceability_cat))
chisq_key <- chisq.test(table(death_metal_tracks$popularity, death_metal_tracks$key))
chisq_loudness <- chisq.test(table(death_metal_tracks$popularity, death_metal_tracks$loudness_cat))
chisq_speechiness <- chisq.test(table(death_metal_tracks$popularity, death_metal_tracks$speechiness_cat))
chisq_instrumentalness <- chisq.test(table(death_metal_tracks$popularity, death_metal_tracks$instrumentalness_cat))
chisq_tempo <- chisq.test(table(death_metal_tracks$popularity, death_metal_tracks$tempo_cat))
#result of chisq test
alpha <- 0.05
print(chisq_duration)
print(chisq_danceability)
print(chisq_key)
print(chisq_loudness)
print(chisq_tempo)
print(chisq_instrumentalness)
print(chisq_speechiness)


#mutiple linear model
install.packages("tidyverse")
install.packages("caTools")
library(tidyverse)
library(caTools)  # For splitting data
data <- death_metal_tracks %>%
mutate(across(where(is.character), as.factor))
numeric_columns <- c("danceability", "tempo", "duration_ms", "loudness", "speechiness", "instrumentalness")
data[numeric_columns] <- scale(data[numeric_columns])
# Split the data set into training set and test set
set.seed(123)
split <- sample.split(data$popularity, SplitRatio = 0.7)
train_data <- subset(data, split == TRUE)
test_data <- subset(data, split == FALSE)
train_data$popularity <- as.numeric(as.character(train_data$popularity))
str(train_data$popularity)
linear_model <- lm(popularity ~ duration_ms + danceability + tempo + loudness + 
                     speechiness + instrumentalness + 
                     key, 
                   data = train_data)
summary(linear_model)

