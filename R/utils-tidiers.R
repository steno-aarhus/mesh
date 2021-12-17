
tidy_nc_estimates <- function(data) {
    data %>%
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

tidy_network_node_names <- function(x) {
    x %>%
        stringr::str_remove("mtb_") %>%
        stringr::str_replace("direct", "cholesterol") %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_to_title() %>%
        stringr::str_replace("^([LH])dl", "\\1DL")
}

tidy_node_names <- function(x) {
    x %>%
        tidy_network_node_names() %>%
        str_replace("Leg Height Ratio", "LHR") %>%
        str_replace("Leg Length", "LL") %>%
        str_replace("Standing Height", "Height") %>%
        str_replace("Hba1c", "HbA1c") %>%
        str_replace("Alanine Aminotransferase", "ALT") %>%
        str_replace("Apolipoprotein A", "ApoA") %>%
        str_replace("Apolipoprotein B", "ApoB") %>%
        str_replace("Aspartate Aminotransferase", "AST") %>%
        str_replace("Creactive Protein", "CRP") %>%
        str_replace("Gamma Glutamyltransferase", "GGT")  %>%
        str_replace("HDL Cholesterol", "HDL")  %>%
        str_replace("LDL Cholesterol", "LDL") %>%
        str_replace("Triglycerides", "TAG")
}

tidy_node_names_column <- function(data) {
    data %>%
        activate("nodes") %>%
        mutate(name = tidy_node_names(name))
}

