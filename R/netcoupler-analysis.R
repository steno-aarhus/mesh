
analyze_nc_network <- function(.tbl) {
    metabolic_network <- .tbl %>%
        select(starts_with("mtb_")) %>%
        NetCoupler::nc_create_network()

    usethis::use_data(metabolic_network, overwrite = TRUE)
    return(metabolic_network)
}

analyze_nc_outcome <- function(.tbl, .network) {
    model_outcome_estimates <- .tbl %>%
        NetCoupler::nc_outcome_estimates(
            .network,
            .outcome = "hba1c",
            .adjustment_vars = c("age", "sex", "body_mass_index"),
            .model_function = lm
        )

    usethis::use_data(model_outcome_estimates, overwrite = TRUE)
    return(model_outcome_estimates)
}

analyze_nc_exposure <- function(.tbl, .network) {
    model_exposure_estimates <- .tbl %>%
        NetCoupler::nc_outcome_estimates(
            .network,
            .outcome = "leg_height_ratio",
            .adjustment_vars = c("age", "sex", "body_mass_index"),
            .model_function = lm
        ) %>%
        rename(exposure = outcome)

    usethis::use_data(model_exposure_estimates)
    return(model_exposure_estimates)
}
