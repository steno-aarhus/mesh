generate_network_results <- function(data_as_cv_splits) {
    process_and_analyze <- function(data, group_by_sex) {
        data %>%
            as.data.frame() %>%
            analyze_nc_standardize_mtb_vars(group_by_sex = group_by_sex) %>%
            analyze_nc_network(group_by_sex = group_by_sex)
    }

    network_results_total <- data_as_cv_splits %>%
        purrr::map(process_and_analyze, group_by_sex = FALSE)

    usethis::use_data(network_results, overwrite = TRUE)
    return(here::here("data/network_results.rda"))
}
