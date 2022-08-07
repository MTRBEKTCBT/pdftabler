#' Extract data
#'
#' @param data vector
#' @param index data frame
#' @examples
#' \dontrun{df |> pt_split_multi()}
pt_split_multi <- \(data, index = idx) {
  years <- seq(ncol(index))
  purrr::pmap_df(
    tibble::tibble(
      years = years
      ),
    \(years) {
      data |>
      pt_split_year(initial = index[seq(nrow(index)), years])
    }
  )
}


