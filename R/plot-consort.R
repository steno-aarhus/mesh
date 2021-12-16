
#' Create a CONSORT diagram of the exclusions and removals.
#'
#' @param consort_object The ggconsort object output when `for_consort_diagram`
#'   is true in the `ukb_remove_exclusions()` function.
#' @param save_plot Logical, to save the diagram to the `doc/images/` folder.
#'
#' @return Outputs either the image file as a character string (while also
#'   saving it) or the image itself, unsaved. The character string output is
#'   necessary for the targets package.
#'
plot_consort_diagram <- function(consort_object, save_plot = FALSE) {
    consort_diagram <- consort_object %>%
        ggconsort::consort_box_add("full", 0, 2,
                                   ggconsort::cohort_count_adorn(exclusion_for_consort, .full)) %>%
        ggconsort::consort_box_add(
            "exclusions",
            0.25,
            1,
            glue::glue(
                '{ggconsort::cohort_count_adorn(exclusion_for_consort, excluded)}<br>
                   • {ggconsort::cohort_count_adorn(exclusion_for_consort, excluded_height)}<br>
                   • {ggconsort::cohort_count_adorn(exclusion_for_consort, excluded_hip)}<br>
                   • {ggconsort::cohort_count_adorn(exclusion_for_consort, excluded_bmi)}<br>
                   • {ggconsort::cohort_count_adorn(exclusion_for_consort, excluded_legs)}'
            )
        ) %>%
        ggconsort::consort_box_add("final", 0, 0,
                        ggconsort::cohort_count_adorn(exclusion_for_consort, too_large_or_small_legs)) %>%
        ggconsort::consort_arrow_add(
            end = "exclusions",
            end_side = "left",
            start_x = 0,
            start_y = 1
        ) %>%
        ggconsort::consort_arrow_add(
            start = "full",
            start_side = "bottom",
            end = "final",
            end_side = "top"
        ) %>%
        ggplot2::ggplot() +
        ggconsort::geom_consort() +
        ggconsort::theme_consort(margin_h = 15, margin_v = 4)

    if (save_plot) {
        consort_file_path <- here::here("doc/images/consort.png")
        ggplot2::ggsave(consort_file_path, consort_diagram)
        return(consort_file_path)
    } else {
        return(consort_diagram)
    }
}
