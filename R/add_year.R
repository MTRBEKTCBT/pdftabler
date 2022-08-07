#' Add year column in data frame
#'
#' @param data data frame
#' @param year vector
#' @examples
#' \dontrun{df |> add_year(2001:2020)}
#' @importFrom dplyr mutate
add_year <- \(data, year) {
  data |>
    mutate(
      year = year,
      .before = V1
    )
}
