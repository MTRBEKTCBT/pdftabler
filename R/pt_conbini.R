#' 年次時系列データの加工
#'
#' 単位記号がついていたりして
#' 文字列として扱われてしまうデータを数値として加工する。
#' 年次データに年数がついていない場合
#' 年数を追加する。
#'
#' @param data vector or list of vector
#' @examples
#' \dontrun{df |> pt_split_multi() |> pt_conbini()}
#' @export
#' @importFrom dplyr mutate across everything rename
#' @importFrom readr parse_number
pt_conbini <- \(data) {
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

