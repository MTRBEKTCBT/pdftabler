conbini |>
  vpr_cell() |>
  purrr::flatten_chr() |>
  vpr_split_years()
