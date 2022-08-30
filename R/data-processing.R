
# Checking if connection to data exists -----------------------------------

check_if_data_exists <- function() {
    local_only_details_file <- here::here("R/ignore.R")
    if (fs::file_exists(local_only_details_file))
        source(local_only_details_file)

    if (exists("project_data_filename")) {
        if (!fs::file_exists(project_data_filename))
            rlang::abort("You're not connected to where the data is stored. Establish connection first.")
        return(project_data_filename)
    }

    fake_data_file <- here::here("data/fake_ukbiobank.rda")
    if (fs::file_exists(fake_data_file)) {
        rlang::inform("Didn't find the real data, using the fake data.")
        return(load(fake_data_file))
    }
}

# Initial importing of the UK Biobank dataset -----------------------------

#' Wrangle and prepare the loaded UK Biobank dataset.
#'
#' @param .save Optional. Save wrangled and trimmed down dataset to server.
#'
#' @return A tibble data frame object.
#'
#' @examples
#'
#' ukb_wrangle_and_save(.save = TRUE)
ukb_wrangle_and_save <- function(ukb_data_raw = here::here("data/data.csv"), .save = FALSE) {
    # The below code gets the data, but better to run a local job (in RStudio)
    # using the `R/jobs/loading-raw.R` file to load the dataset into the global
    # environment, *before* running this function.

    # Wrangle loaded ukb_data_raw.
    ukb_data_smaller <- ukb_data_raw %>%
        calc_leg_measures() %>%
        calc_dm_status()

    ukb_data_smallest <- ukb_data_smaller %>%
        # TODO: Replace with select(where(drop_empty_or_only_false_cols))?
        select_if(drop_empty_or_only_false_cols) %>%
        # Keep only first visit variables
        select(
            eid,
            ends_with("0_0"),
            matches("^(diastolic|systolic)_.*0_[0-1]$"),
            -matches("noncancer|interpolated")
        )

    if (.save) {
        if (!exists("project_data_filename"))
            rlang::abort("Can't find the variable that contains the location to the data.")
        vroom::vroom_write(ukb_data_smallest, project_data_filename, delim = ",")
    }
    ukb_data_smallest
}

# Importing project data --------------------------------------------------

#' Imports the project data from the original source.
#'
#' This function loads the main dataset from the server. Note, this data is not
#' stored outside of the server (i.e. not saved in this repository) and is only
#' loaded into RAM for analysis.
#'
#' @return Outputs a tibble data frame object.
#'
#' @examples
#'
#' # To run basic checks on the data.
#' checking <- ukb_import_project_data()
#'
#' # Check summary of dataset
#' skimr::skim(checking)
#' # Check for only unique ids.
#' any(duplicated(checking$eid))
#'
#' # Trim down variable list even more.
#' names(checking)
ukb_import_project_data <- function(file_path) {
    ukb_project_data <- vroom::vroom(file_path,
          col_types = cols_only(
              eid = col_double(),
              sex_f31_0_0 = col_character(),
              breastfed_as_a_baby_f1677_0_0 = col_character(),
              maternal_smoking_around_birth_f1787_0_0 = col_character(),
              year_of_birth_f34_0_0 = col_double(),
              birth_weight_f20022_0_0 = col_double(),
              felt_hated_by_family_member_as_a_child_f20487_0_0 = col_character(),
              physically_abused_by_family_as_a_child_f20488_0_0 = col_character(),
              felt_loved_as_a_child_f20489_0_0 = col_character(),
              sexually_molested_as_a_child_f20490_0_0 = col_character(),
              someone_to_take_to_doctor_when_needed_as_a_child_f20491_0_0 = col_character(),
              ethnic_background_f21000_0_0 = col_character(),
              basal_metabolic_rate_f23105_0_0 = col_double(),
              waist_circumference_f48_0_0 = col_double(),
              hip_circumference_f49_0_0 = col_double(),
              standing_height_f50_0_0 = col_double(),
              date_of_attending_assessment_centre_f53_0_0 = col_date(format = ""),
              uk_biobank_assessment_centre_f54_0_0 = col_double(),
              diastolic_blood_pressure_automated_reading_f4079_0_0 = col_double(),
              systolic_blood_pressure_automated_reading_f4080_0_0 = col_double(),
              sitting_height_f20015_0_0 = col_double(),
              body_mass_index_bmi_f21001_0_0 = col_double(),
              weight_f21002_0_0 = col_double(),
              age_when_attended_assessment_centre_f21003_0_0 = col_double(),
              microalbumin_in_urine_f30500_0_0 = col_double(),
              creatinine_enzymatic_in_urine_f30510_0_0 = col_double(),
              albumin_f30600_0_0 = col_double(),
              alanine_aminotransferase_f30620_0_0 = col_double(),
              apolipoprotein_a_f30630_0_0 = col_double(),
              apolipoprotein_b_f30640_0_0 = col_double(),
              aspartate_aminotransferase_f30650_0_0 = col_double(),
              cholesterol_f30690_0_0 = col_double(),
              creatinine_f30700_0_0 = col_double(),
              creactive_protein_f30710_0_0 = col_double(),
              gamma_glutamyltransferase_f30730_0_0 = col_double(),
              glucose_f30740_0_0 = col_double(),
              glycated_haemoglobin_hba1c_f30750_0_0 = col_double(),
              hdl_cholesterol_f30760_0_0 = col_double(),
              ldl_direct_f30780_0_0 = col_double(),
              lipoprotein_a_f30790_0_0 = col_double(),
              triglycerides_f30870_0_0 = col_double(),
              leg_length_0_0 = col_double(),
              leg_height_ratio_0_0 = col_double(),
              t1dm_status_0_0 = col_logical(),
              age_of_t1dm_diagnosis_0_0 = col_double(),
              t2dm_status_0_0 = col_logical(),
              age_of_t2dm_diagnosis_0_0 = col_double(),
              diastolic_blood_pressure_automated_reading_f4079_0_1 = col_double(),
              systolic_blood_pressure_automated_reading_f4080_0_1 = col_double()
          )
    )

    ukb_project_data <- ukb_project_data %>%
        mutate(
            diastolic_blood_pressure = rowMeans(across(matches(
                "^diastolic.*_0_[01]$"
            )), na.rm = TRUE),
            systolic_blood_pressure = rowMeans(across(matches(
                "^systolic.*_0_[01]$"
            )), na.rm = TRUE)
        ) %>%
        select(
            eid,
            body_mass_index = body_mass_index_bmi_f21001_0_0,
            hip_circumference_f49_0_0,
            waist_circumference_f48_0_0,
            sex_f31_0_0,
            standing_height_f50_0_0,
            sitting_height_f20015_0_0,
            leg_length_0_0,
            leg_height_ratio_0_0,
            age = age_when_attended_assessment_centre_f21003_0_0,
            diastolic_blood_pressure,
            systolic_blood_pressure,
            microalbumin_in_urine_f30500_0_0,
            creatinine_enzymatic_in_urine_f30510_0_0,
            albumin_f30600_0_0,
            alanine_aminotransferase_f30620_0_0,
            apolipoprotein_a_f30630_0_0,
            apolipoprotein_b_f30640_0_0,
            aspartate_aminotransferase_f30650_0_0,
            cholesterol_f30690_0_0,
            creatinine_f30700_0_0,
            creactive_protein_f30710_0_0,
            gamma_glutamyltransferase_f30730_0_0,
            glucose_f30740_0_0,
            glycated_haemoglobin_hba1c_f30750_0_0,
            hdl_cholesterol_f30760_0_0,
            ldl_direct_f30780_0_0,
            lipoprotein_a_f30790_0_0,
            triglycerides_f30870_0_0,
            t1dm_status_0_0,
            age_of_t1dm_diagnosis_0_0,
            t2dm_status_0_0,
            age_of_t2dm_diagnosis_0_0,
            breastfed_as_a_baby_f1677_0_0,
            maternal_smoking_around_birth_f1787_0_0,
            year_of_birth_f34_0_0,
            birth_weight_f20022_0_0,
            felt_hated_by_family_member_as_a_child_f20487_0_0,
            physically_abused_by_family_as_a_child_f20488_0_0,
            felt_loved_as_a_child_f20489_0_0,
            sexually_molested_as_a_child_f20490_0_0,
            someone_to_take_to_doctor_when_needed_as_a_child_f20491_0_0,
            ethnic_background_f21000_0_0,
            basal_metabolic_rate_f23105_0_0,
        ) %>%
        rename_with(tidy_up_column_names) %>%
        rename_with(
            ~ str_remove(.x, "^mtb_"),
            c(
                mtb_eid,
                mtb_breastfed_as_a_baby,
                mtb_maternal_smoking_around_birth,
                mtb_year_of_birth,
                mtb_birth_weight,
                mtb_felt_hated_by_family_member_as_a_child,
                mtb_physically_abused_by_family_as_a_child,
                mtb_felt_loved_as_a_child,
                mtb_sexually_molested_as_a_child,
                mtb_someone_to_take_to_doctor_when_needed_as_a_child,
                mtb_ethnic_background,
                mtb_basal_metabolic_rate,
                mtb_waist_circumference,
                mtb_body_mass_index,
                mtb_hip_circumference,
                mtb_sex,
                mtb_age,
                mtb_t1dm_status,
                mtb_age_of_t1dm_diagnosis,
                mtb_t2dm_status,
                mtb_age_of_t2dm_diagnosis,
                contains("length"), contains("height")
            )
        )

    # if (interactive()) beepr::beep(4)
    return(ukb_project_data)
}

# Wrangling, filtering, and preparing for other analyses ------------------

#' Remove rows that fit exclusion criteria or for other reasons determined while
#' exploring the data.
#'
#' @param data The UK Biobank data from `ukb_import_project_data()`.
#' @param for_consort_diagram Logical, whether to output the data for ggconsort
#'   or as a data frame.
#'
#' @return Outputs a dataframe or the ggconsort object.
#'
ukb_remove_exclusions <- function(data, for_consort_diagram = FALSE) {
    exclusions <- data %>%
        ggconsort::cohort_start("UK Biobank") %>%
        ggconsort::cohort_define(
            # Drop too big or too small values
            # This is really tiny and could be children or some other health condition
            too_small_height = dplyr::filter(.full, standing_height > 148),
            # Too small hip circumference, could be health condition
            too_small_hip = dplyr::filter(too_small_height, hip_circumference > 20),
            # Don't want underweight people in population, could be health condition
            too_small_bmi = dplyr::filter(too_small_hip, body_mass_index > 18.5),
            # These are too large or too small to be realistic
            too_large_or_small_legs = dplyr::filter(too_small_bmi,
                                                    leg_length < 120,
                                                    leg_length > 60),
            # Remove those with type 1 diabetes
            remove_t1dm = dplyr::filter(too_large_or_small_legs, !t1dm_status | is.na(t1dm_status)),

            # Nothing to drop.
            # Drop missing sitting heights
            # no_missing_sitting_height = dplyr::filter(
            #     too_large_or_small_legs,
            #     !is.na(sitting_height)
            # ),

            final_sample = remove_t1dm,

            # To include in CONSORT diagram
            excluded = dplyr::anti_join(.full, final_sample, by = "eid"),
            excluded_height = dplyr::anti_join(.full, too_small_height, by = "eid"),
            excluded_hip = dplyr::anti_join(too_small_height, too_small_hip, by = "eid"),
            excluded_bmi = dplyr::anti_join(too_small_hip, too_small_bmi, by = "eid"),
            excluded_legs = dplyr::anti_join(too_small_bmi, too_large_or_small_legs, by = "eid"),
            excluded_t1dm = dplyr::anti_join(too_large_or_small_legs, remove_t1dm, by = "eid"),
            # excluded_sitting_height = anti_join(too_large_or_small_legs, no_missing_sitting_height)

        ) %>%
        ggconsort::cohort_label(
            excluded = "Excluded from analysis",
            excluded_height = "Height < 148 cm",
            excluded_hip = "Hips < 20 cm",
            excluded_bmi = "BMI < 18.5",
            excluded_legs = "Legs > 120 cm or < 60 cm",
            excluded_t1dm = "Drop T1DM cases",
            # excluded_sitting_height = "Missing sitting height",
            final_sample = "Project analysis sample"
        )

    if (for_consort_diagram) {
        return(exclusions)
    } else {
        return(ggconsort::cohort_pull(exclusions, final_sample))
    }
}

#' Wrangle and process the data for use in NetCoupler, plus split into training
#' and testing sets.
#'
#' @param data The project data after removal of exclusions and general processing.
#'
#' @return Outputs an rsample split, with training and testing sets.
#'
ukb_wrangle_for_nc <- function(data) {
    nc_project_data <- data %>%
        dplyr::rename(hba1c = mtb_glycated_haemoglobin_hba1c) %>%
        variable_exclusions()

    project_data_nc <- project_data %>%
        dplyr::select(-age_of_t2dm_diagnosis) %>%
        dplyr::mutate(t2dm_status = dplyr::if_else(is.na(t2dm_status), FALSE, t2dm_status))

    rsample::initial_split(project_data_nc)
}

# Processing utilities ----------------------------------------------------

# TODO: Decide where this function should go... in the wrangling section? After
# row exclusions and other processing?
variable_exclusions <- function(data) {
    data %>%
        dplyr::select(
            # More than 25% missing for these variables.
            -mtb_microalbumin_in_urine,
            -mtb_lipoprotein_a,
            # Glucose should probably not be in models with HbA1c as outcome
            -mtb_glucose,
            # These aren't really "metabolic" variables
            -mtb_diastolic_blood_pressure,
            -mtb_systolic_blood_pressure,
            # Since these associate with muscle mass (which is associated with height)
            # Actually, keep them in for verification against height?
            -mtb_creatinine,
            -mtb_creatinine_enzymatic_in_urine
        ) %>%
        dplyr::mutate(leg_height_ratio = leg_height_ratio * 100)
}

create_cv_splits <- function(.training_data) {
    .training_data %>%
        rsample::mc_cv(prop = 0.10, times = 100)
}

drop_empty_or_only_false_cols <- function(x) {
    if (is.character(x) | inherits(x, "Date")) {
        TRUE
    } else {
        sum(x, na.rm = TRUE) != 0
    }
}

calc_leg_measures <- function(data) {
    data %>%
        mutate(
            leg_length_0_0 = standing_height_f50_0_0 - sitting_height_f20015_0_0,
            leg_height_ratio_0_0 = leg_length_0_0 / standing_height_f50_0_0
        )
}

calc_dm_status <- function(data) {
    # Convert to long form to extract age of diagnosis and t1 and t2 dm illness.
    longer_data <- data %>%
        select(eid,
               matches("^(noncancer_illness|interpolated_age).*_0_[0-9]+$")) %>%
        tidyr::pivot_longer(
            cols = -eid,
            names_to = c("Variables", "Items"),
            names_pattern = "(^.*)_f[0-9]+_([0-9]_[0-9]+$)",
            values_to = "Values"
        ) %>%
        dplyr::filter(!is.na(Values))

    # Convert to wide form so age and illness match up.
    wider_data <- longer_data %>%
        tidyr::pivot_wider(names_from = Variables, values_from = Values) %>%
        rename(illness_code = noncancer_illness_code_selfreported,
               age_of_dm_diagnosis_0_0 = interpolated_age_of_participant_when_noncancer_illness_first_diagnosed)

    # Convert illness variables to either with or without type 2 diabetes
    # (code for t2dm = 1223, t1dm = 1222). Have to do it for both t1 and t2 separately,
    # because of the way the data is structured.
    t1dm <- wider_data %>%
        mutate(t1dm_status_0_0 = illness_code == 1222,
               age_of_t1dm_diagnosis_0_0 = age_of_dm_diagnosis_0_0) %>%
        dplyr::filter(t1dm_status_0_0) %>%
        # To confirm no duplicate eid
        assertr::assert(assertr::is_uniq, eid) %>%
        select(eid, t1dm_status_0_0, age_of_t1dm_diagnosis_0_0)

    t2dm <- wider_data %>%
        mutate(t2dm_status_0_0 = illness_code == 1223,
               age_of_t2dm_diagnosis_0_0 = age_of_dm_diagnosis_0_0) %>%
        dplyr::filter(t2dm_status_0_0) %>%
        # To confirm no duplicate eid
        assertr::assert(assertr::is_uniq, eid) %>%
        select(eid, t2dm_status_0_0, age_of_t2dm_diagnosis_0_0)

    purrr::reduce(list(data, t1dm, t2dm), left_join, by = "eid")
}

tidy_up_column_names <- function(x) {
    x %>%
        stringr::str_remove("_0_0$") %>%
        stringr::str_remove("_f[0-9]+$") %>%
        # Add mtb prefix to make it easier to select metabolic variables
        stringr::str_replace("^", "mtb_")
}
