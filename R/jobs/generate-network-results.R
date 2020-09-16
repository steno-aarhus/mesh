devtools::load_all()
library(pcalg)
library(furrr)
library(NetCoupler)
library(rsample)

plan(multiprocess, workers = availableCores() - 1)

set.seed(4125612)

message("Preparing dataset for analysis.")
proj_data <- prepare_data_for_netcoupler_analysis()

proj_data_cv <- proj_data %>%
    training() %>%
    create_cv_splits()

process_and_analyze <- function(.tbl) {
    .tbl %>%
        as.data.frame() %>%
        analyze_nc_standardize_mtb_vars() %>%
        analyze_nc_network()
}

message("Starting analysis.")
network_results <- proj_data_cv$splits %>%
    future_map(process_and_analyze)

message("Ended analysis.")
plan(sequential)

usethis::use_data(network_results, overwrite = TRUE)
