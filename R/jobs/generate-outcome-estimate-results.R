devtools::load_all(quiet = TRUE)
library(furrr)
library(NetCoupler)
library(rsample)
library(progressr)

plan(multisession, workers = availableCores() - 1)

handlers(
    handler_progress(
        format = "[:bar] :percent",
        width = 60,
        enable = TRUE
    )
)

set.seed(4125612)

message("Preparing dataset for analysis.")
proj_data <- prepare_data_for_netcoupler_analysis()

proj_data_cv <- proj_data %>%
    training() %>%
    create_cv_splits()

process_and_analyze <- function(.tbl, .network) {
    p()
    std_data <- .tbl %>%
        as.data.frame() %>%
        nc_standardize(starts_with("mtb_"))

    analyze_nc_outcome(
        .tbl = std_data,
        .network = .network
    )
}

message("Starting analysis.")
# Need to run generate-network-results.R first to get network_results
with_progress({
    p <- progressor(along = 1:length(proj_data_cv$splits))
    outcome_estimate_results <- future_map2(
        proj_data_cv$splits,
        network_results,
        process_and_analyze
    )
}, enable = TRUE)

message("Ended analysis.")
plan(sequential)

usethis::use_data(outcome_estimate_results, overwrite = TRUE)
