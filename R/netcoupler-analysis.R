
analyze_nc_standardize_mtb_vars <- function(.tbl) {
    .tbl %>%
        dplyr::mutate(sex_number = as.numeric(as.factor(sex))) %>%
        NetCoupler::nc_standardize(
            .vars = NetCoupler::starts_with("mtb_"),
            # TODO: Compare with BMI
            .regressed_on = c("age", "sex_number", "waist_circumference")
        )
}

analyze_nc_network <- function(.tbl) {
    .tbl %>%
        NetCoupler::nc_estimate_network(NetCoupler::starts_with("mtb_"))
}

analyze_nc_outcome <- function(.tbl, .network) {
    .tbl %>%
        NetCoupler::nc_outcome_estimates(
            NetCoupler::as_edge_tbl(.network),
            .outcome = "hba1c",
            .adjustment_vars = c("age", "sex", "waist_circumference"),
            .model_function = lm
        )
}

analyze_nc_exposure <- function(.tbl, .network, .exp_var) {
    .tbl %>%
        NetCoupler::nc_exposure_estimates(
            NetCoupler::as_edge_tbl(.network),
            .exposure = .exp_var,
            .adjustment_vars = c("age", "sex", "waist_circumference"),
            .model_function = lm
        )
}
