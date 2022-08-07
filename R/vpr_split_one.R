# 関数：データの抽出 ------------------
# 目的：1列のベクトルで抽出された表データを1レコードずつ分割すること
# 問題：1レコードの長さが異なっている場合、うまく行頭を取り出すことができない
vpr_split_one <- \(
  data, # データベクトル
  initial, # 始点スカラ
  n_col = 15 # 列数スカラ
) {
  data[initial:(initial + n_col - 1)] |>
    # 返り値をtibbleに
    t() |>
    as.data.frame() |>
    tibble::as_tibble()
}

# df |> vpr_split_one(initial = idx[12,1])

