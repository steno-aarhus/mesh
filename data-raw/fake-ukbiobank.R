## code to prepare `fake_ukbiobank` dataset goes here

library(tidyverse)
source(here::here("R/data-processing.R"))
project_data <- check_if_data_exists() %>%
    ukb_import_project_data() %>%
    ukb_remove_exclusions() %>%
    # TODO: This function name and location might change.
    variable_exclusions()

prep_data <- project_data %>%
    select(-eid, -contains("t1dm"),
           -ends_with("as_a_child")) %>%
    mutate(across(where(is.character), as_factor)) %>%
    mutate(t2dm_status = !is.na(t2dm_status)) %>%
    sample_frac(0.3)

# Use this to check characteristics of the data before synthesizing it.
# synthpop::codebook.syn(prep_data)

fake_ukbiobank_object <- synthpop::syn(prep_data)
fake_ukbiobank <- as_tibble(fake_ukbiobank_object$syn)

# Quick check that they are not the same datasets.
# identical(fake_ukbiobank, prep_data)

usethis::use_data(fake_ukbiobank, overwrite = TRUE)
