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

process_and_analyze <- function(.tbl) {
    pb$tick()
    .tbl %>%
        as.data.frame() %>%
        analyze_nc_standardize_mtb_vars() %>%
        analyze_nc_network()
}

message("Starting analysis.")
pb <- progress_bar$new(total = length(proj_data_cv$splits))
network_results <- proj_data_cv$splits %>%
    map(process_and_analyze)

message("Ended analysis.")
usethis::use_data(network_results, overwrite = TRUE)
