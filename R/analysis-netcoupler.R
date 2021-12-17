
analyze_nc_standardize_mtb_vars <- function(.tbl) {
    .tbl %>%
        dplyr::mutate(sex_number = as.numeric(as.factor(sex))) %>%
        NetCoupler::nc_standardize(
            cols = NetCoupler::starts_with("mtb_"),
            # TODO: Compare with BMI
            regressed_on = c("age", "sex_number", "waist_circumference")
        )
}

analyze_nc_network <- function(data) {
    data %>%
        NetCoupler::nc_estimate_network(NetCoupler::starts_with("mtb_"))
}

analyze_nc_outcome <- function(data, .network) {
    data %>%
        NetCoupler::nc_estimate_outcome_links(
            NetCoupler::as_edge_tbl(.network),
            .outcome = "hba1c",
            .adjustment_vars = c("age", "sex", "waist_circumference"),
            .model_function = lm
        )
}

analyze_nc_exposure <- function(data, .network, .exp_var) {
    data %>%
        NetCoupler::nc_exposure_estimates(
            NetCoupler::as_edge_tbl(.network),
            .exposure = .exp_var,
            .adjustment_vars = c("age", "sex", "waist_circumference"),
            .model_function = lm
        )
}
