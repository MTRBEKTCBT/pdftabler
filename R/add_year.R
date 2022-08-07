#' Add year column in data frame
#'
#' @param data data frame
#' @param year vector
#' @examples
#' \dontrun{df |> add_year(2001:2020)}
# 関数：年次列を追加する ---------------
# 目的：データの情報を補完すること
add_year <- \(data, year) {
  data |>
    dplyr::mutate(
      year = year,
      .before = V1
    )
}
