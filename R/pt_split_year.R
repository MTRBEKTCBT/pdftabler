#' Extract data
#'
#' @param data vector or list of vector
#' @param index vector which passes into initial number,
#' appropriate index is required.
#' @param n_col number of columns
#' @examples
#' conbini |>
#'   pt_cell() |>
#'   purrr::flatten_chr() |>
#'   pt_split_year()
pt_split_year <- \(data, index = idx[seq(nrow(idx)), 1], n_col = 15) {
  purrr::pmap_df(
    tibble::tibble(
      index = index,
      n_col = n_col
    ),
    \(index, n_col) {
      data |>
        pt_split_one(
          initial = index,
          n_col = n_col
        )
    }
  )
}



