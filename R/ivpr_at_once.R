# 関数：不揃いなデータを分割して関数を適用する -----------------
# 目的：不揃いなデータを適切に処理するためひと月ずつ処理すること
# 概要：indexを使用して各月の頭を取り出して処理する
ivpr_at_once <- \(
  data,
  index = idx_df2[, 1], # indexを使用すること
  year,
  e = 1, # ズレ数
  n_col = n_col,
  col_names
) {
  purrr::pmap_df(
    # 引数リスト
    tibble::tibble(
      initial = index,
      year = rep(year, length(index)),
      n_col = n_col,
  col_names = col_names
    ),
    \(initial, year, n_col) {
      data |>
        vpr_at_once(
          initial = initial,
          dur_month = 1,
          year = year,
          n_col = n_col,
          col_names = col_names
        )
    }
  )
}
