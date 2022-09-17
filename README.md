# mesh: The metabolic pathways between components of stature and HbA1c: An exploratory cross-sectional analysis in the UK Biobank

<!-- TODO: Add OSF Protocol DOI here.-->

Shorter relative adult leg length (LL), a marker of adverse growth
conditions during early childhood, is associated with a higher risk for
type 2 diabetes. How this link is mediated metabolically is not well
known in humans. Our aim was to explore how the components of stature
influence the metabolic profile in adults and the consequent risk for
type 2 diabetes through higher HbA1c.

Further project details can be found in the `doc/protocol.Rmd` file.
However, here are some brief details:

-   **Population:** Those without diabetes and who have had their
    stature measured in the UK Biobank.

-   **Exposures:** Height, sitting height, and leg length.

-   **Comparisons:** The exposure measures are used as continuous
    variables, so comparisons will be done on a continuum of
    increasing/decreasing exposure.

-   **Outcome:** HbA1c

## Explanation of workflow

This part of the README details how this research directory is
structured, how files should be run, and what the different files do.
The layout and setup of this project was designed for using
[RStudio](https://www.rstudio.com/) and
[devtools](https://github.com/hadley/devtools). It is set up this way to
make it easy for others to run the code and analyses for themselves and
to scaffold onto the devtools workflow (used for R package development).
For more detail on using this project workflow, see
[prodigenr](https://rostools.github.io/prodigenr).

## Installing project R package dependencies

If dependencies have been managed by using
`usethis::use_package("packagename")` through the `DESCRIPTION` file,
installing dependencies is as easy as opening the `testproj3.Rproj` file
and running this command in the console:

``` r
renv::restore()
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
