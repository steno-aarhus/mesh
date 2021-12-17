
#' Descriptive statistics of the full dataset and by sex.
#'
#' @param data The final working sample.
#'
#' @return Outputs a list that is saved as an Rda file and returns a characters
#'   string for targets to track.
#'
analysis_descriptive_statistics <- function(data) {
    descriptive_statistics <- list(
        full_study = skimr::skim(data),
        by_sex = data %>%
            dplyr::group_by(sex) %>%
            skimr::skim() %>%
            dplyr::ungroup(),
        full_study_chr = data %>%
            dplyr::select(where(is.character)) %>%
            tidyr::pivot_longer(dplyr::everything()) %>%
            dplyr::count(name, value),
        by_sex_chr = data %>%
            dplyr::group_by(sex) %>%
            dplyr::select(where(is.character)) %>%
            tidyr::pivot_longer(-sex) %>%
            dplyr::count(name, value) %>%
            dplyr::ungroup()
    )

    usethis::use_data(descriptive_statistics, overwrite = TRUE)
    return(here::here("data/descriptive_statistics.rda"))
}
