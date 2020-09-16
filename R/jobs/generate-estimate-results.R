devtools::load_all()
library(furrr)
library(NetCoupler)
library(rsample)
plan(multiprocess)

set.seed(4125612)

proj_data <- prepare_data_for_netcoupler_analysis()

proj_data_cv <- proj_data %>%
    training() %>%
    create_cv_splits()

process_and_analyze <- function(.tbl, .network) {
    std_data <- .tbl %>%
        as.data.frame() %>%
        nc_standardize(starts_with("mtb_"))

    analyze_nc_outcome(
        .tbl = std_data,
        .network = .network,
        .parallel = TRUE
    )
}

# Need to run generate-network-results.R first to get network_results
outcome_estimate_results <- future_map2(
    proj_data_cv$splits,
    network_results,
    analyze_nc_outcome,
    .parallel = TRUE
)

usethis::use_data(outcome_estimate_results, overwrite = TRUE)

plan(sequential)
