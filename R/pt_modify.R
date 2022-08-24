#' Fixing character to numeric data
#'
#' @param data vector or list of vector
#' @examples
#' \dontrun{df |> pt_split_multi() |> pt_modify()}
#' @export
#' @importFrom dplyr mutate across everything rename
#' @importFrom readr parse_number
pt_modify <- \(data, .b, col = everything()) {
  dur_year <- .b:(dim(data)[1] / 12 + .b - 1)
  data |>
   mutate(
      # 余計な記号を除去
      across(col,
                    ~ parse_number(.x, na = c("", "NA"))
      ),
      year = rep(dur_year, each = 12), .before = V1
    ) |>
    rename(
      month = V1
    )
}

