# 関数：データフレームへの変換 ----------------
# 目的：vpr_splitで取り出したリストをデータフレームに返還すること
# 問題：適切に取り出したデータに使用しないとエラーになる
vpr_conbini <- \(data) {
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

# df |>
#   vpr_split_years() |>
#   vpr_conbini()
