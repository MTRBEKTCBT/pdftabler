#' Extract data
#'
#' @param data vector
#' @param index data frame
#' @examples
#' \dontrun{df |> pt_split_multi()}
#' @export
#' @importFrom purrr pmap_df
#' @importFrom tibble tibble
pt_split_multi <- \(data, index = idx) {
  years <- seq(ncol(index))
  pmap_df(
    tibble(
      years = years
      ),
    \(years) {
      data |>
      pt_split_year(index = index[seq(nrow(index)), years])
    }
  )
}


