
analyze_nc_standardize_mtb_vars <- function(data, group_by_sex = FALSE) {
    # TODO: Do this as a global variable instead?
    confounders <- c("age", "sex_number", "waist_circumference")
    if (group_by_sex) {
        confounders <- stringr::str_subset(confounders, "^sex_number$", negate = TRUE)
    }

    data %>%
        {if (group_by_sex) dplyr::group_by(sex) else .} %>%
        dplyr::mutate(sex_number = as.numeric(as.factor(sex))) %>%
        NetCoupler::nc_standardize(
            cols = dplyr::starts_with("mtb_"),
            # TODO: Compare with BMI
            regressed_on = confounders
        ) %>%
        {if (group_by_sex) dplyr::ungroup() else .}
}

analyze_nc_network <- function(data, group_by_sex = FALSE) {

    data %>%
        {if (group_by_sex) dplyr::group_split(sex) else list(.)} %>%
    NetCoupler::nc_estimate_network(data, dplyr::starts_with("mtb_"))
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
