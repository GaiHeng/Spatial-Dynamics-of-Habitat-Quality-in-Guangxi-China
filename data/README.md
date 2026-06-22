# Data Description

## Overview

This project investigates habitat quality dynamics in Guangxi Province, China, from 1992 to 2022 using land-use data and the InVEST Habitat Quality Model.

The datasets used in this study include land-use maps, administrative boundaries, habitat threat factors, and habitat sensitivity parameters.

---

## Data Sources

### 1. Land Use Data

Source:

Chinese Academy of Sciences Resource and Environmental Science Data Center (RESDC)

Dataset:

Land Use/Cover Change (LUCC) Dataset of China

Temporal coverage:

* 1992
* 2002
* 2012
* 2022

Spatial resolution:

30 m × 30 m

Land-use classes:

| Code | Land-use Type |
| ---- | ------------- |
| 1    | Cropland      |
| 2    | Forest        |
| 3    | Grassland     |
| 4    | Water Body    |
| 5    | Built-up Land |
| 6    | Other Land    |

Format:

GeoTIFF (.tif)

Purpose:

Used as the primary input for habitat quality assessment and land-use change analysis.

---

### 2. Administrative Boundary Data

Source:

Chinese Academy of Sciences Resource and Environmental Science Data Center (RESDC)

Dataset:

Administrative Boundary of Guangxi Province

Format:

Shapefile (.shp)

Purpose:

Used to clip and standardize all spatial datasets to the study area.

---

### 3. Habitat Threat Factors

Threat factors were derived from land-use classes following previous InVEST habitat quality studies.

Threat layers include:

| Threat Factor | Maximum Distance (km) | Weight | Decay Type  |
| ------------- | --------------------- | ------ | ----------- |
| Cropland      | 2                     | 0.5    | Linear      |
| Built-up Land | 10                    | 1.0    | Exponential |
| Other Land    | 4                     | 0.2    | Exponential |

Purpose:

Used to quantify habitat degradation within the InVEST Habitat Quality Model.

---

### 4. Habitat Sensitivity Parameters

Habitat suitability and threat sensitivity parameters were assigned according to published literature and adapted to local ecological conditions in Guangxi.

| Land-use Type | Habitat Suitability |
| ------------- | ------------------- |
| Cropland      | 0.4                 |
| Forest        | 1.0                 |
| Water Body    | 0.9                 |
| Grassland     | 0.8                 |
| Built-up Land | 0                   |
| Other Land    | 0                   |

Purpose:

Used for habitat quality calculation within InVEST.

---

## Data Preprocessing

All datasets were preprocessed using ArcGIS 10.7.

Processing steps:

1. Projection standardization
2. Spatial clipping to Guangxi Province
3. Raster alignment
4. Resolution resampling to 30 m
5. Land-use reclassification
6. Threat-factor raster generation
7. InVEST input table construction

---

## Data Availability

Due to data licensing restrictions, the original land-use datasets are not distributed in this repository.

Researchers may obtain the datasets directly from the original data provider.

Recommended repository structure:

```text
data/
│
├── raw/
│   ├── LUCC_1992.tif
│   ├── LUCC_2002.tif
│   ├── LUCC_2012.tif
│   └── LUCC_2022.tif
│
├── processed/
│   ├── habitat_quality_1992.tif
│   ├── habitat_quality_2002.tif
│   ├── habitat_quality_2012.tif
│   └── habitat_quality_2022.tif
│
└── tables/
    ├── threat_factors.csv
    └── sensitivity_table.csv
```

---

## Reproducibility

All datasets were processed following a reproducible workflow based on:

* ArcGIS 10.7
* InVEST Habitat Quality Model
* Spatial Autocorrelation Analysis
* Getis-Ord Gi* Hotspot Analysis

The workflow enables replication of habitat quality assessment and spatial pattern analysis for other regions and time periods.

