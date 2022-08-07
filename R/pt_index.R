#' Create index for extracted data from pdf.
#'
#' @param data vector or list of vector
#' @param keywords character vector which indicates first column of each raw.
#' @examples
#' \dontrun{df |> pt_index()}
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


