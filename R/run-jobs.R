
run_generic_job <- function(.job_filename, .job_title, .export = "") {
    rstudioapi::jobRunScript(
        path = here::here("R", "jobs", .job_filename),
        name = .job_title,
        workingDir = here::here("."),
        exportEnv = .export
    )
}

# This is only necessary for slower computers.
# On my computer `ukb_import_project_data()` on its own runs pretty fast.
run_job_import_project_data <- function() {
    run_generic_job(
        "importing-project-data.R",
        "Import UK Biobank Project Data",
        "R_GlobalEnv"
    )
}

run_job_network_results <- function() {
    run_generic_job(
        "generate-network-results.R",
        "Generating the network results of the CV splits"
    )
}

run_job_outcome_estimate_results <- function() {
    run_generic_job(
        "generate-outcome-estimate-results.R",
        "Generating the network results of the CV splits"
    )
}
