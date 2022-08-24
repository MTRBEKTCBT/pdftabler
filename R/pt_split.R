#' セル化されたpdf表データを列単位で抽出する
#'
#' 表の列数と行数を指定する必要があるが、
#' この値はデータ内容を探索して確かめる必要がある。
#' 表の形式が改行などの規則的な記号で識別できる場合は
#' \code{pt_index}を利用することができる。
#' \code{initial}は表の始まりとなるセルを指定する。
#'
#' @param data vector or list of vector
#' @param initial number of begining
#' @param n_col number of columns
#' @param n_row number of rows
#' @importFrom purrr pmap
#' @importFrom tibble tibble
#' @export
pt_split <- \(
  data, # データベクトル
  initial, # 始点スカラ
  n_col = 15, # 列数スカラ
  n_row = 1 # 期間スカラ
) {
  purrr::pmap(
    tibble::tibble(
      initial = initial,
      n_col = n_col,
      n_row = n_row,
      i = seq(n_row)
    ),
    \(initial, n_col, n_row, i) {
     data[
       (initial + (i - 1) * n_col):((initial + n_col - 1) + (i - 1) * n_col)
     ]
    }
  )
}
