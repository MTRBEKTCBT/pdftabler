# 関数：一括処理用 --------------
# 目的：全ての関数を一括で適用すること
# 問題：不揃いなデータには使用できない
vpr_at_once <- \(
  data,
  initial,
  dur_month = 12,
  year,
  n_col = n_col,
  col_names
) {
  args <- tibble::tibble(
    initial = initial,
    dur_month = rep(dur_month, length(initial)),
    year = year,
    n_col = n_col,
    col_names = col_names
  )
  purrr::pmap_df(args,
          \(
            initial,
            dur_month,
            year,
            n_col,
            col_names
            ) {
            data |>
              vpr_split(
                initial = initial,
                dur_month = dur_month,
                n_col = n_col
                ) |>
              vpr_conbini(col_names) |>
              add_year(year)
          }
  )
}

