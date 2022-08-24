#' Create index for extracted data from pdf.
#'
#' pdfから抽出した表の加工のためのインデックスを作成する。
#' このインデックスは主に表の1列目の文字列のパターンを指定し、
#' そのパターンに一致するベクトルの位置番号を返す。
#'
#' @param data vector or list of vector
#' @param keywords character vector which indicates first column of each raw.
#' @examples
#' \dontrun{df |> pt_index()}
#' @export
#' @importFrom purrr pmap set_names
#' @importFrom tibble tibble as_tibble
pt_index <- \(data, keywords) {
  purrr::pmap(
    tibble::tibble(
      i = seq_along(keywords)
    ),
    \(i) {
      which(data == keywords[i])
    }
  ) |>
    purrr::set_names(keywords) |>
    tibble::as_tibble() |>
    t() |>
    as.data.frame()
}


