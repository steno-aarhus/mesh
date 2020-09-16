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

process_and_analyze <- function(.tbl, .network) {
    pb$tick()
    std_data <- .tbl %>%
        as.data.frame() %>%
        NetCoupler::nc_standardize(NetCoupler::starts_with("mtb_"))

    analyze_nc_outcome(
        .tbl = std_data,
        .network = .network
    )
}

message("Starting analysis.")
pb <- progress_bar$new(total = length(proj_data_cv$splits))
# Need to run generate-network-results.R first to get network_results
outcome_estimate_results <- map2(
    proj_data_cv$splits,
    network_results,
    process_and_analyze
)

message("Ended analysis.")
usethis::use_data(outcome_estimate_results, overwrite = TRUE)
