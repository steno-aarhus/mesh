# To use for local job to keep session available.
devtools::load_all(here::here("."))
ukb_data_raw <- import_data_with_specific_columns()
