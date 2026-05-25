# =========================================================
# Local Moran's I (LISA) Analysis for Habitat Patches
# Including:
# 1. Local Moran's I
# 2. Moran Scatter Plot
# 3. HH / HL / LH / LL Cluster Map
# 4. Hotspot / Coldspot Analysis
# =========================================================

# =========================================================
# 1. Load Required Packages
# =========================================================
library(terra)
library(spdep)
library(RColorBrewer)

# =========================================================
# 2. Read Raster Data
# =========================================================
raster_path <- "F:/Paper_3/habitat_patch.tif"

habitat <- rast(raster_path)

# Convert raster to dataframe
df <- as.data.frame(habitat, xy = TRUE, na.rm = TRUE)

colnames(df)[3] <- "value"

# =========================================================
# 3. Create Spatial Neighbors
# =========================================================
coords <- cbind(df$x, df$y)

# K-nearest neighbors
# k = 8 is commonly used
knn <- knearneigh(coords, k = 8)

nb <- knn2nb(knn)

# Spatial weights
listw <- nb2listw(nb, style = "W")

# =========================================================
# 4. Global Moran's I
# =========================================================
global_moran <- moran.test(df$value, listw)

cat("\n====================================\n")
cat("Global Moran's I\n")
cat("====================================\n")

print(global_moran)

# =========================================================
# 5. Local Moran's I (LISA)
# =========================================================
local_moran <- localmoran(df$value, listw)

# Add results to dataframe
df$Ii <- local_moran[, 1]
df$Z_Ii <- local_moran[, 4]
df$P_Ii <- local_moran[, 5]

# =========================================================
# 6. Standardization
# =========================================================
value_std <- scale(df$value)[,1]

lag_value <- lag.listw(listw, value_std)

# =========================================================
# 7. Define Cluster Types
# =========================================================
df$Cluster <- "Not Significant"

sig_level <- 0.05

# HH
df$Cluster[
  value_std > 0 &
  lag_value > 0 &
  df$P_Ii <= sig_level
] <- "HH"

# LL
df$Cluster[
  value_std < 0 &
  lag_value < 0 &
  df$P_Ii <= sig_level
] <- "LL"

# HL
df$Cluster[
  value_std > 0 &
  lag_value < 0 &
  df$P_Ii <= sig_level
] <- "HL"

# LH
df$Cluster[
  value_std < 0 &
  lag_value > 0 &
  df$P_Ii <= sig_level
] <- "LH"

# =========================================================
# 8. Moran Scatter Plot
# =========================================================
png(
  "Moran_Scatterplot.png",
  width = 1800,
  height = 1600,
  res = 300
)

par(family = "Times New Roman")

plot(
  value_std,
  lag_value,
  pch = 19,
  col = "steelblue",
  xlab = "Standardized Habitat Patch Value",
  ylab = "Spatial Lag",
  main = "Moran Scatter Plot",
  cex.lab = 1.5,
  cex.main = 1.7
)

abline(h = 0, v = 0, col = "red", lty = 2)

abline(
  lm(lag_value ~ value_std),
  col = "black",
  lwd = 2
)

dev.off()

# =========================================================
# 9. Convert Cluster Results to Raster
# =========================================================
cluster_numeric <- rep(NA, nrow(df))

cluster_numeric[df$Cluster == "HH"] <- 1
cluster_numeric[df$Cluster == "LL"] <- 2
cluster_numeric[df$Cluster == "HL"] <- 3
cluster_numeric[df$Cluster == "LH"] <- 4
cluster_numeric[df$Cluster == "Not Significant"] <- 0

df$cluster_id <- cluster_numeric

# Create raster template
r_template <- habitat

# Convert points back to raster
cluster_raster <- rasterize(
  vect(df, geom = c("x", "y")),
  r_template,
  field = "cluster_id"
)

# =========================================================
# 10. Plot HH / HL / LH / LL Cluster Map
# =========================================================
cluster_colors <- c(
  "lightgrey",   # Not Significant
  "red",         # HH
  "blue",        # LL
  "orange",      # HL
  "skyblue"      # LH
)

png(
  "LISA_Cluster_Map.png",
  width = 1800,
  height = 1600,
  res = 300
)

par(family = "Times New Roman")

plot(
  cluster_raster,
  col = cluster_colors,
  legend = FALSE,
  main = "LISA Cluster Map"
)

legend(
  "bottomleft",
  legend = c(
    "Not Significant",
    "HH Hotspot",
    "LL Coldspot",
    "HL Spatial Outlier",
    "LH Spatial Outlier"
  ),
  fill = cluster_colors,
  bty = "n",
  cex = 1.1
)

dev.off()

# =========================================================
# 11. Hotspot / Coldspot Analysis
# =========================================================
hotspot_df <- df[
  df$Cluster %in% c("HH", "LL"),
]

hotspot_raster <- rasterize(
  vect(hotspot_df, geom = c("x", "y")),
  r_template,
  field = "cluster_id"
)

png(
  "Hotspot_Coldspot_Map.png",
  width = 1800,
  height = 1600,
  res = 300
)

par(family = "Times New Roman")

plot(
  hotspot_raster,
  col = c("red", "blue"),
  legend = FALSE,
  main = "Hotspot / Coldspot Analysis"
)

legend(
  "bottomleft",
  legend = c(
    "HH Hotspot",
    "LL Coldspot"
  ),
  fill = c("red", "blue"),
  bty = "n",
  cex = 1.2
)

dev.off()

# =========================================================
# 12. Export Results
# =========================================================
write.csv(
  df,
  "Local_Moran_LISA_Results.csv",
  row.names = FALSE
)

writeRaster(
  cluster_raster,
  "LISA_Cluster_Map.tif",
  overwrite = TRUE
)

writeRaster(
  hotspot_raster,
  "Hotspot_Coldspot_Map.tif",
  overwrite = TRUE
)

cat("\n====================================\n")
cat("Analysis Completed Successfully!\n")
cat("====================================\n")

cat("\nGenerated Outputs:\n")

cat("1. Moran_Scatterplot.png\n")
cat("2. LISA_Cluster_Map.png\n")
cat("3. Hotspot_Coldspot_Map.png\n")
cat("4. LISA_Cluster_Map.tif\n")
cat("5. Hotspot_Coldspot_Map.tif\n")
cat("6. Local_Moran_LISA_Results.csv\n")
