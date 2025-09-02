# Spotify Death Metal 分析  

## 專案目標  
本專案旨在分析 Spotify 平台中 death metal 曲風的歌曲特徵，探討音樂屬性（如 danceability、loudness、speechiness、tempo 等）與歌曲流行度的關聯，並建立流行度預測模型。同時透過多種視覺化方法呈現結果，支持音樂產業洞察與推薦系統應用。  

---

## 工作內容  

1. **資料處理**  
   - 使用 Spotify 原始資料集 (20.1MB, 113,638 筆)，篩選 death metal 曲風 (N=1,000)。  
   - 處理缺失值與異常值（使用四分位數篩選 outlier 並以中位數替代）。  
   - 數值變數標準化 (Z-score)。  

2. **探索性資料分析 (EDA)**  
   - 描述統計、缺失值檢查。  
   - Boxplot、Histogram 呈現數據分布。  
   - 相關矩陣熱圖。  
   - 主成分分析 (PCA) 與 biplot。  

3. **建模方法**  
   - 卡方檢定 (Chi-squared Test)：檢驗類別化特徵與流行度的關聯。  
   - 多元線性迴歸 (MLR)：解釋流行度與多變數特徵之間的線性關係。  
   - 模型比較：線性回歸、二次多項式回歸、LOESS 回歸。  

4. **視覺化**  
   - PCA scree plot、biplot。  
   - ggplot2 散點圖與迴歸擬合曲線。  
   - 相關矩陣熱圖。  

---

## 研究成果  

- 歌曲時長、音量 (loudness)、speechiness 與流行度顯著相關。  
- 流行度最高落在 **3–4 分鐘歌曲長度**。  
- **danceability、loudness** ↑ → 流行度上升。  
- **speechiness** ↑ → 流行度下降。  
- LOESS 非線性回歸在解釋流行度趨勢上 **優於線性與多項式回歸**。  

---

## 專案貢獻  

- 展現 **R 語言數據分析與視覺化能力**（RStudio, PCA, Regression, ggplot2）。  
- 提供音樂產業 **實證建議**：優化歌曲長度、音量與編曲特性。  
- 對 **音樂推薦系統設計** 提供數據支撐，提升使用者體驗與商業價值。  

---

## 使用方法  

1. Clone 專案到本地端，並於 RStudio 開啟 `death_metal_analysis.R`。  
2. 安裝必要套件：  

```R
install.packages(c("ggplot2", "reshape2", "FactoMineR", "factoextra", "plotly", "tidyverse", "caTools"))
