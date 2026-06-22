library(terra)
library(dplyr)
library(tidyr)

#========================
# 1. Load raster files
#========================
files <- list(
  "1992" = "F:/1992.tif",
  "2002" = "F:/2002.tif",
  "2012" = "F:/2012.tif",
  "2022" = "F:/2022.tif"
)

# Habitat quality classification
hq_map <- c(
  "1" = "Low",
  "2" = "Relatively low",
  "3" = "Medium",
  "4" = "Relatively high",
  "5" = "High"
)

#========================
# 2. Function: calculate area statistics
#========================
calc_hq_stats <- function(r, year){

  # pixel area (depends on projection: m² or degree-based unit)
  pixel_area <- prod(res(r))

  # frequency table of raster values
  freq_table <- as.data.frame(freq(r, useNA = "no"))
  colnames(freq_table) <- c("class", "count")

  # compute area
  freq_table$area <- freq_table$count * pixel_area
  freq_table$year <- year

  # convert class to character
  freq_table$class <- as.character(freq_table$class)

  # total area
  total_area <- sum(freq_table$area)

  # proportion
  freq_table$share <- freq_table$area / total_area

  # map classification
  freq_table$hq_level <- hq_map[freq_table$class]

  return(freq_table)
}

#========================
# 3. Batch processing
#========================
all_stats <- lapply(names(files), function(y){
  r <- rast(files[[y]])
  calc_hq_stats(r, y)
})

df <- bind_rows(all_stats)

#========================
# 4. Annual statistics tables
#========================

# Area table (wide format)
area_table <- df %>%
  select(year, hq_level, area) %>%
  pivot_wider(names_from = year, values_from = area)

# Share table (wide format)
share_table <- df %>%
  select(year, hq_level, share) %>%
  pivot_wider(names_from = year, values_from = share)

#========================
# 5. Year-to-year change analysis
#========================

# Function to compute change between two years
calc_change <- function(df, year1, year2){

  df_wide <- df %>%
    select(year, hq_level, area) %>%
    pivot_wider(names_from = year, values_from = area)

  df_wide <- df_wide %>%
    mutate(
      area_change = .data[[year2]] - .data[[year1]],
      area_change_percent = (.data[[year2]] - .data[[year1]]) / .data[[year1]]
    ) %>%
    mutate(
      from_year = year1,
      to_year = year2
    )

  return(df_wide)
}

# 1992 → 2002
change_92_02 <- calc_change(df, "1992", "2002")

# 2002 → 2012
change_02_12 <- calc_change(df, "2002", "2012")

# 2012 → 2022
change_12_22 <- calc_change(df, "2012", "2022")

# Combine all changes
change_all <- bind_rows(change_92_02, change_02_12, change_12_22)

#========================
# 6. Output results
#========================

print("=== Habitat Quality Area Table ===")
print(area_table)

print("=== Habitat Quality Share Table ===")
print(share_table)

print("=== Year-to-Year Change (Area) ===")
print(change_all)

#========================
# 7. Save results
#========================

write.csv(df, "F:/HQ_yearly_stats_long.csv", row.names = FALSE)
write.csv(area_table, "F:/HQ_area_table.csv", row.names = FALSE)
write.csv(share_table, "F:/HQ_share_table.csv", row.names = FALSE)
write.csv(change_all, "F:/HQ_area_change_by_period.csv", row.names = FALSE)
