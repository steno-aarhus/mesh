devtools::load_all()
library(pcalg)
library(NetCoupler)
library(rsample)
library(progress)
library(furrr)

set.seed(4125612)

plan(multiprocess, workers = availableCores() - 1)

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
    pb$tick()
    analyze_nc_exposure(
        .tbl = .tbl,
        .network = .network,
        .stature_var = .stature_var
    )
}

message("Starting analysis.")
num_splits <- length(proj_data_cv$splits)
pb <- progress_bar$new(total = num_splits * 4)
# Need to run generate-network-results.R first to get network_results
split_data <- proj_data_cv$splits %>%
    map(process_data)

stature_vars <- rep(c(
    "standing_height",
    "sitting_height",
    "leg_length",
    "leg_height_ratio"
    ),
    each = num_splits)

exposure_estimate_results <-
    list(
        .tbl = split_data,
        .network = network_results,
        .stature_var = stature_vars
    ) %>%
    future_pmap_dfr(analyze_data, .id = "model_run_number")

message("Ended analysis.")
usethis::use_data(exposure_estimate_results, overwrite = TRUE)
