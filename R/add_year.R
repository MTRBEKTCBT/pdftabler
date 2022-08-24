#' データフレームに年数をを加える。
#'
#' \code{data}はデータフレーム。
#' \code{year}は年数のベクトル。
#' データフレームの長さと年数ベクトルの長さは等しくなければならない。
#'
#' @param data データフレーム
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
