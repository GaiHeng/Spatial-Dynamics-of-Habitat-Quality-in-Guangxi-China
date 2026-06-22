library(terra)
library(dplyr)
library(tidyr)

#========================
# 1. Load data
#========================
files <- list(
  "1992" = "F:/1992.tif",
  "2002" = "F:/2002.tif",
  "2012" = "F:/2012.tif",
  "2022" = "F:/2022.tif"
)

# Land use classification mapping
lu_map <- c(
  "1" = "Cropland",
  "2" = "Forest",
  "3" = "Grassland",
  "5" = "Water",
  "6" = "Built-up",
  "other" = "Other land"
)

#========================
# 2. Calculation function
#========================
calc_lu_stats <- function(r, year){

  # Pixel area (unit depends on projection: m² or degree-based unit)
  res_area <- prod(res(r))

  # Frequency table of raster values
  freq_table <- as.data.frame(freq(r, useNA = "no"))

  colnames(freq_table) <- c("class", "count")

  # Compute area
  freq_table$area <- freq_table$count * res_area
  freq_table$year <- year

  # Ensure class is character
  freq_table$class <- as.character(freq_table$class)

  # Total area
  total_area <- sum(freq_table$area)

  # Proportion of each land use type
  freq_table$share <- freq_table$area / total_area

  # Map class codes to land use names
  freq_table$landuse <- lu_map[freq_table$class]

  return(freq_table)
}

#========================
# 3. Batch processing
#========================
all_stats <- lapply(names(files), function(y){
  r <- rast(files[[y]])
  calc_lu_stats(r, y)
})

df <- bind_rows(all_stats)

#========================
# 4. Reshape results (time comparison tables)
#========================

# Area table (wide format)
area_table <- df %>%
  select(year, landuse, area) %>%
  pivot_wider(names_from = year, values_from = area)

# Share table (proportion)
share_table <- df %>%
  select(year, landuse, share) %>%
  pivot_wider(names_from = year, values_from = share)

#========================
# 5. Change analysis (1992 vs 2022)
#========================

area_change_table <- area_table %>%
  mutate(
    area_change = `2022` - `1992`,
    area_change_percentage = (`2022` - `1992`) / `1992`
  )

share_change_table <- share_table %>%
  mutate(
    share_change = `2022` - `1992`
  )

#========================
# 6. Output results
#========================

print("=== Land Use Area Table ===")
print(area_table)

print("=== Land Use Share Table ===")
print(share_table)

print("=== Area Change (2022 vs 1992) ===")
print(area_change_table)

print("=== Share Change (2022 vs 1992) ===")
print(share_change_table)

#========================
# 7. Save results
#========================

write.csv(df, "F:/LUCC_yearly_stats_long.csv", row.names = FALSE)
write.csv(area_table, "F:/LUCC_area_table.csv", row.names = FALSE)
write.csv(share_table, "F:/LUCC_share_table.csv", row.names = FALSE)
write.csv(area_change_table, "F:/LUCC_area_change.csv", row.names = FALSE)
