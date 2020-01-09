raw_data_filename <- "/run/user/1000/gvfs/smb-share:server=uni.au.dk,share=users/au597503/Documents/ukbiobank/ukb_data_cleaned.csv"
project_data_filename <- "/run/user/1000/gvfs/smb-share:server=uni.au.dk,share=users/au597503/Documents/ukbiobank/ukb_data_netcoupler_project.csv"

extract_raw_column_names <- function() {
    variable_names <- vroom_lines(raw_data_filename, n_max = 1)
    # Get variables names to keep.
    variable_names %>%
        stringr::str_split(",") %>%
        .[[1]]
}

# Run this to get a variable list to use in `col_types` argument of vroom.
initial_import_for_var_list_specs <- function() {
    ukb_data <- vroom::vroom(raw_data_filename,
                             # Obtained by using `vroom::spec()` on a smaller subset of the data
                             # To read faster.
                             n_max = 25000)
    spec(ukb_data)
}

import_data_with_specific_columns <- function() {
    vroom(
        raw_data_filename,
        # Obtained by using `initial_import_for_var_list_specs()` and types are edited.
        col_types = cols_only(
            eid = col_double(),
            sex_f31_0_0 = col_character(),
            year_of_birth_f34_0_0 = col_double(),
            waist_circumference_f48_0_0 = col_double(),
            waist_circumference_f48_1_0 = col_double(),
            waist_circumference_f48_2_0 = col_double(),
            hip_circumference_f49_0_0 = col_double(),
            hip_circumference_f49_1_0 = col_double(),
            hip_circumference_f49_2_0 = col_double(),
            standing_height_f50_0_0 = col_double(),
            standing_height_f50_1_0 = col_double(),
            standing_height_f50_2_0 = col_double(),
            date_of_attending_assessment_centre_f53_0_0 = col_date(format = ""),
            date_of_attending_assessment_centre_f53_1_0 = col_date(format = ""),
            date_of_attending_assessment_centre_f53_2_0 = col_date(format = ""),
            uk_biobank_assessment_centre_f54_0_0 = col_double(),
            uk_biobank_assessment_centre_f54_1_0 = col_double(),
            uk_biobank_assessment_centre_f54_2_0 = col_double(),
            diastolic_blood_pressure_automated_reading_f4079_0_0 = col_double(),
            diastolic_blood_pressure_automated_reading_f4079_0_1 = col_double(),
            diastolic_blood_pressure_automated_reading_f4079_1_0 = col_double(),
            diastolic_blood_pressure_automated_reading_f4079_1_1 = col_double(),
            diastolic_blood_pressure_automated_reading_f4079_2_0 = col_double(),
            diastolic_blood_pressure_automated_reading_f4079_2_1 = col_double(),
            systolic_blood_pressure_automated_reading_f4080_0_0 = col_double(),
            systolic_blood_pressure_automated_reading_f4080_0_1 = col_double(),
            systolic_blood_pressure_automated_reading_f4080_1_0 = col_double(),
            systolic_blood_pressure_automated_reading_f4080_1_1 = col_double(),
            systolic_blood_pressure_automated_reading_f4080_2_0 = col_double(),
            systolic_blood_pressure_automated_reading_f4080_2_1 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_0 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_1 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_2 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_3 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_4 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_5 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_6 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_7 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_8 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_9 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_10 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_11 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_12 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_13 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_14 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_15 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_16 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_17 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_18 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_19 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_20 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_21 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_22 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_23 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_24 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_25 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_26 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_27 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_28 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_29 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_30 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_31 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_32 = col_double(),
            noncancer_illness_code_selfreported_f20002_0_33 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_0 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_1 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_2 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_3 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_4 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_5 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_6 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_7 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_8 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_9 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_10 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_11 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_12 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_13 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_14 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_15 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_16 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_17 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_18 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_19 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_20 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_21 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_22 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_23 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_24 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_25 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_26 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_27 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_28 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_29 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_30 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_31 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_32 = col_double(),
            noncancer_illness_code_selfreported_f20002_1_33 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_0 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_1 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_2 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_3 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_4 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_5 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_6 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_7 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_8 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_9 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_10 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_11 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_12 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_13 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_14 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_15 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_16 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_17 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_18 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_19 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_20 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_21 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_22 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_23 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_24 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_25 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_26 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_27 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_28 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_29 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_30 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_31 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_32 = col_double(),
            noncancer_illness_code_selfreported_f20002_2_33 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_0 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_1 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_2 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_3 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_4 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_5 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_6 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_7 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_8 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_9 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_10 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_11 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_12 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_13 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_14 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_15 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_16 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_17 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_18 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_19 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_20 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_21 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_22 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_23 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_24 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_25 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_26 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_27 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_28 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_29 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_30 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_31 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_32 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_0_33 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_0 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_1 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_2 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_3 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_4 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_5 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_6 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_7 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_8 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_9 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_10 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_11 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_12 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_13 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_14 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_15 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_16 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_17 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_18 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_19 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_20 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_21 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_22 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_23 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_24 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_25 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_26 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_27 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_28 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_29 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_30 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_31 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_32 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_1_33 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_0 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_1 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_2 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_3 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_4 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_5 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_6 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_7 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_8 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_9 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_10 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_11 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_12 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_13 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_14 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_15 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_16 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_17 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_18 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_19 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_20 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_21 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_22 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_23 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_24 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_25 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_26 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_27 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_28 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_29 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_30 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_31 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_32 = col_double(),
            interpolated_age_of_participant_when_noncancer_illness_first_diagnosed_f20009_2_33 = col_double(),
            sitting_height_f20015_0_0 = col_double(),
            sitting_height_f20015_1_0 = col_double(),
            sitting_height_f20015_2_0 = col_double(),
            body_mass_index_bmi_f21001_0_0 = col_double(),
            body_mass_index_bmi_f21001_1_0 = col_double(),
            body_mass_index_bmi_f21001_2_0 = col_double(),
            weight_f21002_0_0 = col_double(),
            weight_f21002_1_0 = col_double(),
            weight_f21002_2_0 = col_double(),
            age_when_attended_assessment_centre_f21003_0_0 = col_double(),
            age_when_attended_assessment_centre_f21003_1_0 = col_double(),
            age_when_attended_assessment_centre_f21003_2_0 = col_double(),
            microalbumin_in_urine_f30500_0_0 = col_double(),
            microalbumin_in_urine_f30500_1_0 = col_double(),
            creatinine_enzymatic_in_urine_f30510_0_0 = col_double(),
            creatinine_enzymatic_in_urine_f30510_1_0 = col_double(),
            albumin_f30600_0_0 = col_double(),
            albumin_f30600_1_0 = col_double(),
            alanine_aminotransferase_f30620_0_0 = col_double(),
            alanine_aminotransferase_f30620_1_0 = col_double(),
            apolipoprotein_a_f30630_0_0 = col_double(),
            apolipoprotein_a_f30630_1_0 = col_double(),
            apolipoprotein_b_f30640_0_0 = col_double(),
            apolipoprotein_b_f30640_1_0 = col_double(),
            aspartate_aminotransferase_f30650_0_0 = col_double(),
            aspartate_aminotransferase_f30650_1_0 = col_double(),
            cholesterol_f30690_0_0 = col_double(),
            cholesterol_f30690_1_0 = col_double(),
            creatinine_f30700_0_0 = col_double(),
            creatinine_f30700_1_0 = col_double(),
            creactive_protein_f30710_0_0 = col_double(),
            creactive_protein_f30710_1_0 = col_double(),
            gamma_glutamyltransferase_f30730_0_0 = col_double(),
            gamma_glutamyltransferase_f30730_1_0 = col_double(),
            glucose_f30740_0_0 = col_double(),
            glucose_f30740_1_0 = col_double(),
            glycated_haemoglobin_hba1c_f30750_0_0 = col_double(),
            glycated_haemoglobin_hba1c_f30750_1_0 = col_double(),
            hdl_cholesterol_f30760_0_0 = col_double(),
            hdl_cholesterol_f30760_1_0 = col_double(),
            ldl_direct_f30780_0_0 = col_double(),
            ldl_direct_f30780_1_0 = col_double(),
            lipoprotein_a_f30790_0_0 = col_double(),
            lipoprotein_a_f30790_1_0 = col_double(),
            triglycerides_f30870_0_0 = col_double(),
            triglycerides_f30870_1_0 = col_double()
        )
    )
}

drop_empty_or_only_false_cols <- function(x) {
    if (is.character(x) | inherits(x, "Date")) {
        TRUE
    } else {
        sum(x, na.rm = TRUE) != 0
    }
}

calc_leg_measures <- function(.tbl) {
    .tbl %>%
        mutate(
            leg_length_0_0 = standing_height_f50_0_0 - sitting_height_f20015_0_0,
            leg_height_ratio_0_0 = leg_length_0_0 / standing_height_f50_0_0
        ) %>%
        # Drop too large or too small values
        dplyr::filter(leg_length_0_0 < 120, leg_length_0_0 > 60)
}

calc_t2dm_status <- function(.tbl) {
    # Convert to long form to extract age of diagnosis and t2dm illness.
    longer_data <- .tbl %>%
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
               age_of_t2dm_diagnosis_0_0 = interpolated_age_of_participant_when_noncancer_illness_first_diagnosed) %>%
        # Convert illness variables to either with or without type 2 diabetes
        # (code for t2dm = 1223)
        mutate(t2dm_status_0_0 = if_else(illness_code == 1223, TRUE, FALSE)) %>%
        dplyr::filter(t2dm_status_0_0) %>%
        # To confirm no duplicate eid
        assertr::assert(assertr::is_uniq, eid) %>%
        select(eid, t2dm_status_0_0, age_of_t2dm_diagnosis_0_0)

    left_join(.tbl, wider_data, by = "eid")
}

#' Wrangle and prepare the loaded UK Biobank dataset.
#'
#' @param .save Optional. Save wrangled and trimmed down dataset to server.
#'
#' @return A tibble data frame object.
#'
#' @examples
#'
#' ukb_prep <- wrangle_ukb_data()
#' ukb_prep %>%
#' count(t2dm_status_0_0)
#' ukb_prep %>%
#' View()
#' skimr::skim(ukb_prep) %>%
#' View()
#' wrangle_ukb_data(.save = TRUE)
wrangle_ukb_data <- function(.save = FALSE) {
    # The below code gets the data, but better to run a local job (in RStudio)
    # using the `scripts/loading-raw.R` file to load the dataset into the global
    # environment, *before* running this function.
    # ukb_data_raw <- import_data_with_specific_columns()

    # Wrangle loaded ukb_data_raw.
    ukb_data_smaller <- ukb_data_raw %>%
        # Filter out type 1 diabetes (code for t1dm = 1222)
        filter_at(vars(matches("^noncancer_illness_")),
                  all_vars(. != 1222 |
                               is.na(.))) %>%
        # Drop missing sitting heights
        dplyr::filter(!is.na(sitting_height_f20015_0_0)) %>%
        # Drop too big or too small values
        dplyr::filter(
            standing_height_f50_0_0 > 148,
            hip_circumference_f49_0_0 > 20,
            body_mass_index_bmi_f21001_0_0 > 18.5
        ) %>%
        calc_leg_measures() %>%
        calc_t2dm_status()

    ukb_data_smallest <- ukb_data_smaller %>%
        select_if(drop_empty_or_only_false_cols) %>%
        # Keep only first visit variables
        select(
            eid,
            ends_with("0_0"),
            matches("^(diastolic|systolic)_.*0_[0-1]$"),
            -matches("noncancer|interpolated")
        )

    if (.save) {
        vroom_write(ukb_data_smallest, project_data_filename, delim = ",")
    }
    ukb_data_smallest
}
