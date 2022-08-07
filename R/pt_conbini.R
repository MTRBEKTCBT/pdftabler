#' Fixing character to numeric data
#'
#' @param data vector or list of vector
#' @examples
#' \dontrun{df |> pt_split_multi() |> pt_conbini()}
pt_conbini <- \(data) {
  data |>
   dplyr::mutate(
      # 余計な記号を除去
      dplyr::across(everything(),
                    ~ readr::parse_number(.x, na = c("", "NA"))
      ),
      year = rep(2005:2021, each = 12), .before = V1
    ) |>
    dplyr::rename(
      month = V1
    )
}

