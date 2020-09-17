library(magrittr)

generate_poster_pdf <- function(input_file, output_file, deps = NULL) {
    temp_poster_html <- tempfile(fileext = ".html")
    rmarkdown::render(
        input_file,
        output_format = "postr::flex_dashboard_poster",
        output_file = temp_poster_html,
        params = list(output_media = "print"),
        quiet = TRUE
    )

    temp_poster_html %>%
        postr::render_poster_image(aspect_ratio = 1 / sqrt(2),
                                   poster_width = 841)

    temp_poster_png <- temp_poster_html %>%
        fs::path_ext_set("png")

    poster_pdf_image <- temp_poster_png %>%
        magick::image_read() %>%
        magick::image_convert(format = "pdf")

    magick::image_write(
        poster_pdf_image,
        path = output_file,
        quality = 100,
        density = 300
    )

    return(invisible(NULL))
}

generate_poster_html <- function(input_file, output_file, deps = NULL) {
    rmarkdown::render(
        input = input_file,
        output_file = output_file,
        output_format = "flexdashboard::flex_dashboard",
        quiet = TRUE
    )
    return(invisible(NULL))
}

generate_poster_pdf(
    here::here("poster/poster.Rmd"),
    here::here("poster/poster.pdf")
)
generate_poster_html(
    here::here("poster/poster.Rmd"),
    here::here("poster/poster.html")
)
