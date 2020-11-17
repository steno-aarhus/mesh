#' Loads the data from the original source.
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
#' checking <- load_data()
#'
#' # Check summary of dataset
#' skimr::skim(checking)
#' # Check for only unique ids.
#' any(duplicated(checking$eid))
#'
#' # Trim down variable list even more.
#' names(checking)
load_data <- function() {
    ukb_project_data <- vroom(project_data_filename,
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
              t2dm_status_0_0 = col_logical(),
              age_of_t2dm_diagnosis_0_0 = col_double(),
              diastolic_blood_pressure_automated_reading_f4079_0_1 = col_double(),
              systolic_blood_pressure_automated_reading_f4080_0_1 = col_double()
          )
    )

    ukb_project_data <- ukb_project_data %>%
        mutate(
            diastolic_blood_pressure = rowMeans(
                select(
                    .,
                    diastolic_blood_pressure_automated_reading_f4079_0_0,
                    diastolic_blood_pressure_automated_reading_f4079_0_1
                ),
                na.rm = TRUE
            ),
            systolic_blood_pressure = rowMeans(
                select(
                    .,
                    systolic_blood_pressure_automated_reading_f4080_0_0,
                    systolic_blood_pressure_automated_reading_f4080_0_1
                ),
                na.rm = TRUE
            )
        ) %>%
        select(
            body_mass_index = body_mass_index_bmi_f21001_0_0,
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
        rename_with(.tidy_up_column_names) %>%
        rename_with(
            ~ str_remove(.x, "^mtb_"),
            c(
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
                mtb_sex,
                mtb_age,
                mtb_t2dm_status,
                mtb_age_of_t2dm_diagnosis,
                contains("length"), contains("height")
            )
        )

    if (interactive()) beepr::beep(4)
    return(ukb_project_data)
}

.tidy_up_column_names <- function(x) {
    x %>%
        stringr::str_remove("_0_0$") %>%
        stringr::str_remove("_f[0-9]+$") %>%
        # Add mtb prefix to make it easier to select metabolic variables
        stringr::str_replace("^", "mtb_")
}
