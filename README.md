# ecc-cmd-ukb: Early childhood conditions and cardiometabolic disease in the UK Biobank

<!-- TODO: Give a brief description of what your project is about -->

## Explanation of workflow

This part of the README details how this research directory is
structured, how files should be run, and what the different files do.
The layout and setup of this project was designed for using
[RStudio](https://www.rstudio.com/) and
[devtools](https://github.com/hadley/devtools). It is set up this way to
make it easy for others to run your code and analyses for themselves and
to skaffold onto devtools (used for R package development) because it is
well documented and actively maintained. See the excellent [R for Data
Science](http://r4ds.had.co.nz/) online book for more details on how to
work with this directory format.

Typical commands used in this workflow include:

-   *Ctrl-Shift-L* (`devtools::load_all()`)
-   *Ctrl-Shift-K* (`rmarkdown::render('file.Rmd')`)

For more detail on using this project workflow, see
[prodigenr](https://lwjohnst86.github.io/prodigenr).

To install all the packages necessary for this project (only if
`usethis::use_package("packagename")` has been used often), run this
command while in the project:

## Installing project R package dependencies

If dependencies have been managed by using
`usethis::use_package("packagename")` through the `DESCRIPTION` file,
installing dependencies is as easy as opening the `testproj3.Rproj` file
and running this command in the console:

``` r
renv::restore()
```

``` r
targets::tar_make()
```

## Brief description of folder and file contents

The following folders contain:

-   `data/`: Will contain the UK Biobank data (not saved to Git) as well
    as the intermediate results output files.

-   `data-raw/`: Contains the R script to download the data, as well as
    the CSV files that contain the project variables and the variable
    list as named in the RAP.

-   `doc/`: This file contains the R Markdown, Word, or other types of
    documents with written content, like the manuscript and protocol.

-   `R/`: Contains the R scripts and functions to create the figures,
    tables, and results for the project.

-   `renv/`: Contains the files needed by the renv package to help with
    installing the correct packages necessary for this project.

These files are for:

-   `.gitignore` tells [Git](https://git-scm.com/) to ignore certain
    files from being tracked and prevents them from entering the version
    control history.
-   `.Rbuildignore` tells devtools which files to not include when
    running functions such as `devtools::load_all()`.
-   `DESCRIPTION` is a standard file that includes metadata about your
    project, in a machine readable format for others to obtain
    information on about your project. It provides a description of what
    the project does and most importantly what R packages your project
    uses on.
-   The `.Rproj` file dictates that the directory is a RStudio project.
    Open the project by opening this file.

All subsequent folders have their own README inside. See them for more
details.

