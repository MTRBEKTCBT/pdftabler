#' Extract data
#'
#' @param data vector or list of vector
#' @param initial number
#' @param n_col number of columns
#' @examples
#' \dontrun{
#' conbini |>
#'   pt_cell() |>
#'   purrr::flatten_chr() |>
#'   pt_split_one(initial = idx[12,1])
#'   }
pt_split_one <- \(
  data, # データベクトル
  initial, # 始点スカラ
  n_col = 15 # 列数スカラ
) {
  data[initial:(initial + n_col - 1)] |>
    # 返り値をtibbleに
    t() |>
    as.data.frame() |>
    tibble::as_tibble()
}


