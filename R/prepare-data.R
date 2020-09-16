
prepare_data_for_netcoupler_analysis <- function() {
    # TODO: Update this comment below.
    # load_data_as_job() for load_data() if necessary.
    project_data <- load_data() %>%
        rename(hba1c = mtb_glycated_haemoglobin_hba1c) %>%
        select(
            # More than 25% missing for these variables.
            -mtb_microalbumin_in_urine,
            -mtb_lipoprotein_a,
            # Glucose should probably not be in models with HbA1c as outcom
            -mtb_glucose,
            # These aren't really "metabolic" variables
            -mtb_diastolic_blood_pressure,
            -mtb_systolic_blood_pressure,
            # Since these associate with muscle mass (which is associated with height)
            -mtb_creatinine,
            -mtb_creatinine_enzymatic_in_urine
        ) %>%
        mutate(leg_height_ratio = leg_height_ratio * 100)

    project_data_nc <- project_data %>%
        select(-age_of_t2dm_diagnosis) %>%
        mutate(t2dm_status = if_else(is.na(t2dm_status), FALSE, t2dm_status))

    rsample::initial_split(project_data_nc)
}

create_cv_splits <- function(.training_data) {
    .training_data %>%
        rsample::mc_cv(prop = 0.10, times = 150)
}
