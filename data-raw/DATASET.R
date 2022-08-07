## code to prepare `DATASET` dataset goes here

path <- dir("inst/extdata", "\\.pdf", full.names = TRUE)
conbini <- purrr::map(path, pdftools::pdf_text)

usethis::use_data(conbini, overwrite = TRUE)

key <- sprintf("%d月", 1:12)

idx <-
conbini |>
  pt_cell() |>
  purrr::flatten_chr() |>
  pt_index(key)

usethis::use_data(idx, overwrite = TRUE)
