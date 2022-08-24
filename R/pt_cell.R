#' Split long vector to short
#'
#' pdfの表をセル単位に分割する。
#'
#' @param data vector data, extracted from pdf, mostly character.
#' @return splited data, each element has a each record.
#' @examples
#' \dontrun{conbini |> pt_cell()}
#' @export
pt_cell <- \(data, sep = " +") {
  data |>
    stringr::str_split(sep) |>
    purrr::flatten_chr()
}
