devtools::load_all()
library(pcalg)
library(NetCoupler)
library(rsample)
library(progress)
library(furrr)

set.seed(4125612)

# This doesn't work, since I think it does too much processing to work
# plan(multiprocess, workers = availableCores() - 2, gc = TRUE)

message("Preparing dataset for analysis.")
proj_data <- prepare_data_for_netcoupler_analysis()

proj_data_cv <- proj_data %>%
    training() %>%
    create_cv_splits()

process_data <- function(data) {
    data %>%
        as.data.frame() %>%
        NetCoupler::nc_standardize(NetCoupler::starts_with("mtb_"))
}

analyze_data <- function(data, .network) {
    # TODO: Test parallel again but move this code out.
    pb$tick()
    analyze_nc_outcome(
        data = data,
        .network = .network
    )
}

message("Starting analysis.")
pb <- progress_bar$new(total = length(proj_data_cv$splits))
# Need to run generate-network-results.R first to get network_results
outcome_estimate_results <- proj_data_cv$splits %>%
    map(process_data) %>%
    map2_dfr(network_results,
                    analyze_data,
                    .id = "model_run_number")

message("Ended analysis.")
usethis::use_data(outcome_estimate_results, overwrite = TRUE)
# plan(sequential)
