#' Split long vector to short
#'
#' @param data vector data, extracted from pdf, mostly character.
#' @return splited data, each element has a each record.
#' @examples
#' \dontrun{conbini |> pt_cell()}
#' @export
#' @importFrom stringr str_split
pt_cell <- \(data) {
  data |>
    str_split(" +")
}
