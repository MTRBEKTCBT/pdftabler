## code to prepare `DATASET` dataset goes here


path <- dir("inst/extdata", "\\.pdf", full.names = TRUE)
conbini <- purrr::map(path, pdftools::pdf_text)

usethis::use_data(conbini, overwrite = TRUE)
