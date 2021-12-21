generate_network_results <- function(data_as_cv_splits, group_by_sex = FALSE) {
    process_and_analyze <- function(data, group_by_sex) {
        data %>%
            as.data.frame() %>%
            analyze_nc_standardize_mtb_vars() %>%
            analyze_nc_network()
    }

    network_results <- data_as_cv_splits %>%
        purrr::map(process_and_analyze)

    usethis::use_data(network_results, overwrite = TRUE)
    return(here::here("data/network_results.rda"))
}
