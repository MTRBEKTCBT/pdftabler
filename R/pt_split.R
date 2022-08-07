#' Extract data
#'
#' @param data vector or list of vector
#' @param initial number of begining
#' @param n_col number of columns
#' @param dur_month duration in months
#' @examples
#' \dontrun{
#' conbini |>
#'   pt_cell() |>
#'   purrr::flatten_chr() |>
#'   pt_split(initial = 29)
#'   }
#' @export
#' @importFrom purrr pmap
#' @importFrom tibble tibble
pt_split <- \(
  data, # データベクトル
  initial, # 始点スカラ
  n_col = 15, # 列数スカラ
  dur_month = 1 # 期間スカラ
) {
  purrr::pmap(
    tibble::tibble(
      initial = initial,
      n_col = n_col,
      dur_month = dur_month,
      i = seq(dur_month)
    ),
    \(initial, n_col, dur_month, i) {
     data[
       (initial + (i - 1) * n_col):((initial + n_col - 1) + (i - 1) * n_col)
     ]
    }
  )
}

