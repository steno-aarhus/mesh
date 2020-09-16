
run_generic_job <- function(.job_filename, .job_title, .export = "") {
    rstudioapi::jobRunScript(
        path = here::here("R", "jobs", .job_filename),
        name = .job_title,
        workingDir = here::here("."),
        exportEnv = .export
    )
}

# This is only necessary for slower computers.
# On my computer `load_data()` on its own runs pretty fast.
run_job_load_data <- function() {
    run_generic_job(
        "loading-project-data.R",
        "Load UK Biobank Project Data",
        "R_GlobalEnv"
    )
}

run_job_loading_raw <- function() {
    run_generic_job(
        "loading-raw.R",
        "Loading original raw UK Biobank data",
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
