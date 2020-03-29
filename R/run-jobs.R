
# This is only necessary for slower computers.
# On my computer `load_data()` on its own runs pretty fast.
load_data_as_job <- function() {
    rstudioapi::jobRunScript(
        path = here::here("scripts/loading-project-data.R"),
        name = "Load UK Biobank Project Data",
        workingDir = here::here("."),
        exportEnv = "R_GlobalEnv"
    )
}
