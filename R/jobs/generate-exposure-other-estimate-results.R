library(tidyverse)
library(vroom)
library(fs)
library(here)
library(pcalg)
library(NetCoupler)
r_files <- dir_ls(here("R"), glob = "*.R")
walk(r_files, source)

set.seed(4125612)

message("Preparing dataset for analysis.")

# load_data_as_job() for load_data() if necessary.
project_data <- load_data() %>%
    rename(hba1c = mtb_glycated_haemoglobin_hba1c) %>%
    select(
        # More than 25% missing for these variables.-mtb_microalbumin_in_urine,
        -mtb_lipoprotein_a,
        # Glucose should probably not be in models with HbA1c as outcom-mtb_glucose,
        # These aren't really "metabolic" variables-mtb_diastolic_blood_pressure,
        -mtb_systolic_blood_pressure,
        # Since these associate with muscle mass (which is associated with height)
        # Actually, keep them in for verification against height-mtb_creatinine,
        -mtb_creatinine_enzymatic_in_urine
    )

project_data_nc <- project_data %>%
    select(-age_of_t2dm_diagnosis) %>%
    mutate(t2dm_status = if_else(is.na(t2dm_status), FALSE, t2dm_status))

project_data <- project_data %>%
    sample_frac(0.1)

analyze_data <- function(.tbl, .network, .exp_var) {
    analyze_nc_exposure(
        .tbl = .tbl,
        .network = .network,
        .exp_var = .exp_var
    )
}

message("Starting analysis.")

# Need to run generate-network-results.R first to get network_results
std_proj_data <- project_data %>%
    nc_standardize(starts_with("mtb_")) %>%
    mutate(across(
        c(breastfed_as_a_baby,
          maternal_smoking_around_birth),
        ~ case_when(
            .x == "Yes" ~ 1,
            .x == "No" ~ 0
        )
    )) %>%
    mutate(across(
        c(felt_hated_by_family_member_as_a_child,
          physically_abused_by_family_as_a_child,
          felt_loved_as_a_child),
        ~ case_when(
            .x %in% c("Never true", "Rarely true")  ~ 0,
            .x %in% c("Sometimes true", "Often", "Very often true") ~ 1
        )
    )) %>%
    mutate(sexually_molested_as_a_child = case_when(
        sexually_molested_as_a_child == "Never true" ~ 0,
        sexually_molested_as_a_child %in% c("Rarely true", "Sometimes true", "Often", "Very often true") ~ 1)
    )

network_results <- project_data %>%
    analyze_nc_standardize_mtb_vars() %>%
    analyze_nc_network()

exposure_estimate_results_other <- list()

for (var in c(
    "breastfed_as_a_baby",
    "maternal_smoking_around_birth",
    "birth_weight",
    "felt_hated_by_family_member_as_a_child",
    "physically_abused_by_family_as_a_child",
    "felt_loved_as_a_child",
    "sexually_molested_as_a_child"
)) {
    exposure_estimate_results_other[[var]] <-
        analyze_data(
            std_proj_data,
            .network = network_results,
            .exp_var = var
        )
    beepr::beep(5)
}

exposure_estimate_results_other <- bind_rows(exposure_estimate_results_other)

message("Ended analysis.")
usethis::use_data(exposure_estimate_results_other, overwrite = TRUE)
beepr::beep(4)
