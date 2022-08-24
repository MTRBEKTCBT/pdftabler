#' Extract data
#'
#' \code{pt_split_year}のラッパー関数。
#' \code{pt_index}によって表の行と列の位置情報が与えられている場合
#' 抽出したpdf表を一括でデータフレームに変換できる。
#'
#' @param data vector
#' @param index data frame
#' @examples
#' \dontrun{df |> pt_split_multi()}
#' @export
#' @importFrom purrr pmap_df
#' @importFrom tibble tibble
pt_split_multi <- \(data, index = idx) {
  n_col <- seq(ncol(index))
  pmap_df(
    tibble(
      n_col = n_col
      ),
    \(n_col) {
      data |>
      pt_split_year(index = index[seq(nrow(index)), n_col])
    }
  )
}


