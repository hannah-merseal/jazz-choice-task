rds_files <- list.files("output/results", pattern = "\\.rds$", full.names = TRUE)
simple.results <- readRDS(rds_files[1])
