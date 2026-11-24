# Introduction to Data Analysis with R and Bioconductor

An introductory R script covering foundational programming, data manipulation, visualization, and RNA-seq data structures using **tidyverse** and **Bioconductor**.

## What's Inside (`Introduction to data analysis with R and Bioconductor.R`)
* **R Basics & Data Structures:** Package setup (`BiocManager`, `remotes`), sequences, random sampling, indexing/subsetting, factors, matrices, dates (`lubridate`), lists, and saving/loading data.
* **Data Wrangling (`dplyr` & `tidyr`):** Filtering, selecting, pipes (`|>`), `mutate()`, `group_by()` / `summarise()`, reshaping (`pivot_wider` / `pivot_longer`), and joining annotation tables[cite: 1].
* **Data Visualization (`ggplot2`):** Histograms, log transformations, scatter/jitter plots, boxplots, violin plots, line plots, faceting, themes/customization, combining plots (`patchwork`, `gridExtra`), and exporting figures[cite: 1].
* **Bioconductor & `SummarizedExperiment`:** Building `SummarizedExperiment` objects from count matrices and sample/gene metadata, subsetting, saving/loading `.rds` files, and working with `tidySummarizedExperiment`[cite: 1].

## Prerequisites & Packages
Install the required CRAN and Bioconductor packages before running the script[cite: 1]:

```r
install.packages(c("BiocManager", "remotes", "tidyverse", "hexbin", "patchwork", "gridExtra", "lubridate"))
BiocManager::install(c("SummarizedExperiment", "tidySummarizedExperiment"))
