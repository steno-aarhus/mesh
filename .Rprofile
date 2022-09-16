options(
    repos = c(RSPM = "https://packagemanager.rstudio.com/all/latest"),
    browserNLdisabled = TRUE,
    deparse.max.lines = 2,
    todor_rmd = TRUE,
    dplyr.summarize.inform = FALSE,
    todor_patterns = c("FIXME", "TODO", "IDEA", "NOTE"),
    renv.settings.snapshot.type = "explicit",
    renv.config.auto.snapshot = TRUE,
    warnPartialMatchArgs = TRUE,
    warnPartialMatchDollar = TRUE,
    warnPartialMatchAttr = TRUE
)
options(renv.config.repos.override = getOption("repos"))

if (interactive()) {
    suppressMessages(require(devtools))
    suppressMessages(require(usethis))
}

if (interactive()) {
    source("renv/activate.R")
    options(Ncpus = 3)
}
