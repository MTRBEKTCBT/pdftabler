# 関数：2つに分かれて抽出した月次データを統合する -----------------
# 目的：不揃いなデータを適切に処理すること
# 問題：はみ出しが1か所のデータにしか対応できない
# 概要：原理的にはvpr_at_onceを複数回適用しているだけ
# aのパラメータを調整することで始点をずらしている
vpr_at_once2 <- \(
  data,
  initial,
  dur_month = c(6, 6),
  year
  ) {
  # 引数リスト
  args <- tibble::tibble(
    initial = c(initial, initial + dur_month[1] * 15 + 1),
    dur_month = dur_month,
    year = rep(year, length(dur_month))
  )
  purrr::pmap_df(
    args,
    \(initial, dur_month, year) {
      data |> vpr_at_once(initial = initial, dur_month = dur_month, year = year)
    }
  )
}
