# 関数：データの抽出 ------------------
# 目的：1列のベクトルで抽出された表データを1レコードずつ分割すること
# 問題：1レコードの長さが異なっている場合、うまく行頭を取り出すことができない
vpr_split <- \(
  data, # データベクトル
  initial, # 始点スカラ
  n_col, # 列数スカラ
  dur_month = 1 # 期間スカラ
) {
  purrr::pmap(
    tibble::tibble(
      initial = initial,
      n_col = n_col,
      dur_month = dur_month,
      i = seq(dur_month)
    ),
    \(initial, n_col, dur_month, i) {
     data[
       (initial + (i - 1) * n_col):((initial + n_col - 1) + (i - 1) * n_col)
     ]
    }
  )
}

df |> vpr_split(initial = idx[1,1], n_col = 15, dur_month = 2)
