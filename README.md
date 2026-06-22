# 🌿 Guangxi Habitat Quality Dynamics (1992–2022)

## Spatiotemporal Dynamics and Spatial Autocorrelation of Habitat Quality in Guangxi, China

---

## 📌 Research Overview

Habitat quality is a key indicator of ecosystem health and biodiversity conservation. Rapid urbanization and land-use transformation have increasingly altered habitat conditions across southern China.

This project evaluates habitat quality dynamics in Guangxi Province from 1992 to 2022 using the Integrated Valuation of Ecosystem Services and Tradeoffs (InVEST) Habitat Quality Model.

The study integrates:

* Land-use change analysis
* Habitat quality assessment
* Spatial autocorrelation analysis
* Hotspot identification

to reveal long-term ecological changes and biodiversity conservation implications.

---

## 🎯 Research Objectives

The project aims to:

1. Quantify land-use changes from 1992–2022.
2. Evaluate habitat quality dynamics using InVEST.
3. Identify spatial clustering patterns of habitat quality.
4. Explore relationships between land-use transformation and ecological degradation.
5. Provide evidence for biodiversity conservation and ecological restoration planning.

---

## 🗺 Study Area

Guangxi Zhuang Autonomous Region, China

Characteristics:

* Subtropical monsoon climate
* High forest coverage
* Rich biodiversity
* Rapid urban expansion during the past three decades

---

## 🔬 Methodological Framework
 <img width="4961" height="3508" alt="Graphical abstract" src="https://github.com/user-attachments/assets/45afd9aa-1b80-4f0f-9f04-6582e0fddd88" />

```

---

## 📊 Data Sources

| Dataset                                | Source                              |
| -------------------------------------- | ----------------------------------- |
| Land-use data (1992, 2002, 2012, 2022) | Chinese Academy of Sciences (RESDC) |
| Administrative boundaries              | RESDC                               |
| Threat factors                         | Derived from land-use classes       |
| Habitat sensitivity parameters         | Literature-based calibration        |

Spatial resolution:

```text
30 m × 30 m
```

---

## 🧩 Habitat Quality Modelling

Tool:

```text
InVEST Habitat Quality Model
```

Threat factors:

* Cropland
* Built-up land
* Unused land

Outputs:

* Habitat degradation
* Habitat quality
* Spatial distribution of ecological conditions

Habitat quality values range from:

```text
0 – 1
```

where larger values indicate better habitat conditions.

---

## 📈 Spatial Statistical Analysis

### Global Spatial Autocorrelation

Method:

```text
Global Moran's I
```

Purpose:

* Evaluate spatial clustering of habitat quality

### Local Hotspot Analysis

Method:

```text
Getis-Ord Gi*
```

Purpose:

* Detect high-value habitat hotspots
* Identify ecological degradation hotspots

---

## 📊 Key Results

### Land-use Change

Main land-use types:

* Forest
* Cropland
* Water bodies

Key findings:

* Built-up land increased by over 200%.
* Grassland continuously declined.
* Forest area remained relatively stable.
* Landscape fragmentation increased.

### Habitat Quality Trends

Mean habitat quality:

| Year | Habitat Quality |
| ---- | --------------- |
| 1992 | 0.288           |
| 2002 | 0.285           |
| 2012 | 0.276           |
| 2022 | 0.264           |

Overall habitat quality exhibited a continuous decline.

### Spatial Patterns

High habitat quality areas:

* Baise
* Hechi
* Liuzhou
* Guilin

Low habitat quality areas:

* Nanning
* Guigang
* Central Guangxi urbanized regions

### Spatial Autocorrelation

Moran's I:

| Year | Moran's I |
| ---- | --------- |
| 1992 | 0.362     |
| 2002 | 0.323     |
| 2012 | 0.311     |
| 2022 | 0.326     |

Results indicate significant spatial clustering of habitat quality throughout the study period.

---

## 🧠 Technical Skills Demonstrated

This project demonstrates proficiency in:

* GIS spatial analysis
* ArcGIS
* InVEST ecosystem service modelling
* Landscape ecological assessment
* Habitat quality evaluation
* Spatial autocorrelation analysis
* Biodiversity conservation planning
* Scientific visualization

---

## 📂 Repository Structure

```text
Guangxi-Habitat-Quality-Dynamics/
│
├── data/
│   ├── landuse_1992.tif
│   ├── landuse_2002.tif
│   ├── landuse_2012.tif
│   └── landuse_2022.tif
│
├── workflow/
│   └── methodological_framework.png
│
├── result/
│   ├── landuse_change.png
│   ├── habitat_quality_maps.png
│   ├── hotspot_analysis.png
│   └── moransI_results.png
│
├── scripts/
│   ├── habitat_quality_analysis.py
│   ├── spatial_autocorrelation.R
│   └── visualization.R
│
├── docs/
│   └── manuscript.pdf
│
└── README.md
```

---

## 📚 Citation

Gai, H. (2024).

Spatiotemporal Dynamics and Spatial Autocorrelation of Habitat Quality in Guangxi, China.

Agriculture and Technology.

