#' Fixing character to numeric data
#'
#' @param data vector or list of vector
#' @examples
#' \dontrun{df |> pt_split_multi() |> pt_modify()}
#' @export
#' @importFrom dplyr mutate across everything rename
#' @importFrom readr parse_number
pt_modify <- \(data) {
  data |>
   mutate(
      # 余計な記号を除去
      across(everything(),
                    ~ parse_number(.x, na = c("", "NA"))
      ),
      year = rep(2005:2021, each = 12), .before = V1
    ) |>
    rename(
      month = V1
    )
}

