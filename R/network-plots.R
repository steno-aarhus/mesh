
plot_network_graph <- function(.tbl) {
    .tbl %>%
        tidygraph::activate("edges") %>%
        tidygraph::mutate(edge_label = dplyr::if_else(abs(.data$weight) > 0.2,
                                                      as.character(round(.data$weight, 2)),
                                                      "")) %>%
        ggraph::ggraph("stress") +
        ggraph::geom_edge_diagonal(
            ggplot2::aes_string(
                label = "edge_label",
                colour = "weight",
                width = "abs(weight)"
            ),
            angle_calc = "along",
            label_dodge = grid::unit(0.2, "cm")
        ) +
        ggraph::geom_node_point(size = 2) +
        ggraph::scale_edge_colour_gradient2(mid = "gray80", limits = c(-1, 1)) +
        ggraph::scale_edge_width(guide = FALSE, range = c(0.75, 2)) +
        ggraph::geom_node_text(ggplot2::aes_string(label = "name"),
                               repel = TRUE) +
        ggraph::theme_graph(base_family = 'Helvetica')
}

summarise_estimate_means <- function(.tbl) {
    .tbl %>%
        group_by(external_variable, index_node) %>%
        summarize(
            effect = names(which.max(table(effect))),
            estimate = mean(estimate),
            .groups = "drop"
        )
}

# convert_model_to_edges <- function(.tbl) {
#     .tbl %>%
#         arrange(exposure, index_node) %>%
#         mutate(
#             to = as.numeric(fct_inorder(index_node)),
#             from = max(to) + as.numeric(forcats::fct_inorder(exposure)),
#             effect = dplyr::na_if(.data$effect, "none"),
#             estimate = if_else(is.na(.data$effect), NA_real_, .data$estimate)
#         )
# }

convert_node_numbers_to_name <- function(.network_tbl, .node_name_tbl,
                                         .direction = c("to", "from")) {
    .direction <- rlang::arg_match(.direction)
    dir_col <- set_names("number", .direction)
    .network_tbl %>%
        left_join(.node_name_tbl, by = dir_col) %>%
        select(-all_of(.direction)) %>%
        rename_with(~.direction, "name")
}

network_node_number_to_name <- function(.network_tbl, .node_name_tbl) {
    .network_tbl %>%
        activate("edges") %>%
        as_tibble() %>%
        convert_node_numbers_to_name(.node_name_tbl, "to") %>%
        convert_node_numbers_to_name(.node_name_tbl, "from")
}


network_and_estimates_as_tbl_graph <- function(.model_tbl, .network_tbl) {
    network_nodes <- .network_tbl %>%
        activate("nodes") %>%
        mutate(number = row_number()) %>%
        as_tibble()

    network_prep <- .model_tbl %>%
        rename(from = external_variable, to = index_node) %>%
        bind_rows(network_node_number_to_name(.network_tbl, network_nodes))

    node_names <- sort(unique(c(network_prep$from, network_prep$to)))
    node_number <- as.numeric(as_factor(node_names))
    node_levels <- node_names %>%
        set_names(as.character(node_number))

    node_edges <- network_prep %>%
        mutate(
            from = match(network_prep$from, node_levels),
            to = match(network_prep$to, node_levels)
        ) %>%
        filter(effect != "ambiguous" | is.na(effect))

    tidygraph::tbl_graph(nodes = tibble(name = node_names),
                         edges = node_edges)
}

plot_estimation_with_network <- function(.graph_tbl, .exposure_vars, .outcome_vars) {
    node_positions <- .graph_tbl %>%
        ggraph::create_layout("stress") %>%
        mutate(
            y = scale(y),
            y = if_else(
                .data$name %in% .exposure_vars,
                rnorm(n(), sd = 0.7) + runif(n(), -0.5, 0.5) + 0.5,
                .data$y
            ),
            y = if_else(
                .data$name %in% .outcome_vars,
                mean(.data$y) + 0.5,
                .data$y
            ),
            # Shift x axis over so nudge works
            x = scale(.data$x),
            x = if_else(
                .data$name %in% .exposure_vars,
                min(.data$x) + runif(n(), 0, 0.5),
                .data$x
            ),
            x = if_else(
                .data$name %in% .outcome_vars,
                max(.data$x) + 0.5,
                .data$x
            )
        )

    .graph_tbl %>%
        NetCoupler:::set_weights_and_tidy() %>%
        NetCoupler:::define_edge_label() %>%
        mutate(
            edge_label = if_else(is.na(.data$edge_label) |
                                     .data$from == max(.data$from),
                                 "",
                                 .data$edge_label),
            edge_label = if_else(!is.na(estimate), "", edge_label)
        ) %>%
        ggraph::ggraph("manual", x = node_positions$x, y = node_positions$y) +
        ggraph::geom_edge_diagonal(
            ggplot2::aes_string(
                label = "edge_label",
                colour = "weight",
                width = "abs(weight)"
                # linetype = "forcats::fct_rev(effect)",
                # alpha = "effect"
            ),
            angle_calc = "along",
            label_dodge = grid::unit(0.25, "cm")
        ) +
        ggraph::geom_node_point(size = 2) +
        ggraph::scale_edge_colour_gradient2(mid = "gray80", limit = c(-1, 1)) +
        # ggraph::scale_edge_alpha_discrete(guide = FALSE, range = c(0.7, 0.9)) +
        ggraph::scale_edge_width(guide = FALSE, range = c(0.75, 2)) +
        ggraph::geom_node_text(ggplot2::aes_string(label = "name"),
                               repel = TRUE) +
        # ggraph::scale_edge_linetype_discrete(name = "") +
        ggraph::theme_graph()
}
