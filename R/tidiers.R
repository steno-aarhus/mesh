
tidy_nc_estimates <- function(.tbl) {
    .tbl %>%
        dplyr::filter(index_node == term) %>%
        # select(outcome, index_node, estimate, conf.low, conf.high, p.value) %>%
        group_by(outcome, index_node) %>%
        summarize_at(vars(estimate, p.value), mean) %>%
        ungroup() %>%
        mutate(index_node = tidy_metabolic_names(index_node)) %>%
        arrange(index_node) %>%
        assertr::assert(assertr::is_uniq, index_node)
}

tidy_metabolic_names <- function(x) {
    x %>%
        stringr::str_remove("mtb_") %>%
        stringr::str_replace_all("_", " ")

}
