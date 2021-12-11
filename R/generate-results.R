generate_network_results <- function(tbl_as_cv_splits) {
    process_and_analyze <- function(tbl) {
        tbl %>%
            as.data.frame() %>%
            analyze_nc_standardize_mtb_vars() %>%
            analyze_nc_network()
    }

    network_results <- tbl_as_cv_splits %>%
        purrr::map(process_and_analyze)

    usethis::use_data(network_results, overwrite = TRUE)
    return(here::here("data/network_results.rda"))
}
