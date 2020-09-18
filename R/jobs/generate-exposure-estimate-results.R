library(tidyverse)
library(vroom)
library(fs)
library(here)
library(pcalg)
library(NetCoupler)
library(rsample)
library(progress)
library(furrr)
r_files <- dir_ls(here("R"), glob = "*.R")
walk(r_files, source)
load(here("data/network_results.rda"))
options(future.globals.onReference = "error")

set.seed(4125612)

# This doesn't work, since I think it does too much processing to work
plan(multisession, workers = availableCores() - 3)

message("Preparing dataset for analysis.")
proj_data <- prepare_data_for_netcoupler_analysis()

proj_data_cv <- proj_data %>%
    training() %>%
    create_cv_splits()

process_data <- function(.tbl) {
    .tbl %>%
        as.data.frame() %>%
        NetCoupler::nc_standardize(NetCoupler::starts_with("mtb_"))
}

analyze_data <- function(.tbl, .network, .stature_var) {
    # pb$tick()
    analyze_nc_exposure(
        .tbl = .tbl,
        .network = .network,
        .stature_var = .stature_var
    )
}

message("Starting analysis.")
num_splits <- length(proj_data_cv$splits)
# pb <- progress_bar$new(total = num_splits * 4)
# Need to run generate-network-results.R first to get network_results
split_data <- proj_data_cv$splits %>%
    map(process_data)

exposure_estimate_results <- list()

for (var in c("standing_height",
              "sitting_height",
              "leg_length",
              "leg_height_ratio")) {
    exposure_estimate_results[var] <-
        future_map2_dfr(split_data, network_results, analyze_data, .stature_var = var,
                        .id = "model_run_number")
}

exposure_estimate_results <- bind_rows(exposure_estimate_results)

message("Ended analysis.")
usethis::use_data(exposure_estimate_results, overwrite = TRUE)
plan(sequential)
