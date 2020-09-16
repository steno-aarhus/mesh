devtools::load_all(quiet = TRUE)
library(furrr)
library(NetCoupler)
library(rsample)
library(progressr)

plan(multiprocess, workers = availableCores() - 1)

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

process_and_analyze <- function(.tbl) {
    p()
    .tbl %>%
        as.data.frame() %>%
        analyze_nc_standardize_mtb_vars() %>%
        analyze_nc_network()
}

message("Starting analysis.")
with_progress({
    p <- progressor(along = 1:length(proj_data_cv$splits))
    network_results <- proj_data_cv$splits %>%
        future_map(process_and_analyze)
}, enable = TRUE)

message("Ended analysis.")
plan(sequential)

usethis::use_data(network_results, overwrite = TRUE)
