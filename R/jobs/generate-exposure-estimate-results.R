devtools::load_all()
library(pcalg)
library(NetCoupler)
library(rsample)
library(progress)

set.seed(4125612)

message("Preparing dataset for analysis.")
proj_data <- prepare_data_for_netcoupler_analysis()

proj_data_cv <- proj_data %>%
    training() %>%
    create_cv_splits()

process_and_analyze <- function(.tbl, .network, .stature_var) {
    pb$tick()
    # TODO: Test parallel again but move this code out.
    std_data <- .tbl %>%
        as.data.frame() %>%
        NetCoupler::nc_standardize(NetCoupler::starts_with("mtb_"))

    analyze_nc_exposure(
        .tbl = std_data,
        .network = .network,
        .stature_var = .stature_var
    )
}

message("Starting analysis.")
pb <- progress_bar$new(total = length(proj_data_cv$splits) * 4)
# Need to run generate-network-results.R first to get network_results
exposure_estimate_results <- map(
    c("standing_height",
      "sitting_height",
      "leg_length",
      "leg_height_ratio"),
    ~ map2(proj_data_cv$splits,
           network_results,
           process_and_analyze,
           .stature_var = .x)
) %>%
    flatten() %>%
    bind_rows(.id = "model_run_number")


message("Ended analysis.")
usethis::use_data(exposure_estimate_results, overwrite = TRUE)
