# To use for local job to keep session available.
# For powerful computers, this isn't necessary.
devtools::load_all(here::here("."))
project_data <- ukb_import_project_data()
