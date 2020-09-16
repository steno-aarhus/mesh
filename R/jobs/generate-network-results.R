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

process_and_analyze <- function(.tbl) {
    .tbl %>%
        as.data.frame() %>%
        analyze_nc_standardize_mtb_vars() %>%
        analyze_nc_network()
}

network_results <- proj_data_cv$splits %>%
    future_map(process_and_analyze)

usethis::use_data(network_results, overwrite = TRUE)

plan(sequential)
