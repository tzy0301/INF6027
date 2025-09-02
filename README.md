
# Spotify Death Metal Analysis  

## Project Objective  
This project aims to analyze the characteristics of death metal tracks on Spotify, exploring the relationships between audio features (such as danceability, loudness, speechiness, tempo, etc.) and track popularity. A popularity prediction model is built, supported by multiple visualization techniques, to provide insights for the music industry and recommendation systems.  

---

## Workflow  

1. **Data Processing**  
   - Filtered the original Spotify dataset (20.1MB, 113,638 tracks) for death metal tracks (N=1,000).  
   - Handled missing values and outliers (replaced with median using IQR method).  
   - Standardized numeric variables using Z-scores.  

2. **Exploratory Data Analysis (EDA)**  
   - Performed descriptive statistics and missing value checks.  
   - Visualized data distributions with boxplots and histograms.  
   - Built correlation heatmaps.  
   - Conducted Principal Component Analysis (PCA) and biplots.  

3. **Modeling Methods**  
   - **Chi-squared Tests**: Examined associations between categorical features and popularity.  
   - **Multiple Linear Regression (MLR)**: Modeled the linear relationship between popularity and multiple features.  
   - **Model Comparison**: Compared linear regression, quadratic polynomial regression, and LOESS regression.  

4. **Visualization**  
   - PCA scree plots and biplots.  
   - Scatterplots with regression fits (ggplot2).  
   - Correlation matrix heatmaps.  

---

## Findings  

- Track duration, loudness, and speechiness show significant correlations with popularity.  
- Highest popularity occurs for tracks of **3–4 minutes in length**.  
- Higher **danceability and loudness** → increased popularity.  
- Higher **speechiness** → decreased popularity.  
- LOESS regression outperformed linear and polynomial regression in explaining popularity trends.  

---

## Contributions  

- Demonstrates **R-based data analysis and visualization skills** (RStudio, PCA, Regression, ggplot2).  
- Provides **practical recommendations** for the music industry: optimize track length, loudness, and arrangement.  
- Supports **music recommendation system design** with empirical data to improve user experience and commercial value.  

---

## How to Run  

1. Clone the repository locally and open `death_metal_analysis.R` in RStudio.  
2. Install the required packages and run the script to reproduce the analysis and visualizations:  

```R
install.packages(c("ggplot2", "reshape2", "FactoMineR", "factoextra", "plotly", "tidyverse", "caTools"))
