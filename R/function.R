# 関数：データの抽出 ------------------
# 目的：1列のベクトルで抽出された表データを1レコードずつ分割すること
# 問題：1レコードの長さが異なっている場合、うまく行頭を取り出すことができない
ext_data <- \(
  data, # データベクトル
  a, # 始点スカラ
  d = 15, # 列数スカラ
  dur_month # 期間スカラ
  ) {
  a <- a
  d <- d
  x <- vector("list", dur_month)
  x <- set_names(x, str_c("V", seq_along(x)))
  for (i in seq_along(x)) {
    x[[i]] <- data[
      (a + (i - 1) * d):((a + 14) + (i - 1) * d)
    ]
  }
  x
}

# 関数：データフレームへの変換 ----------------
# 目的：ext_dataで取り出したリストをデータフレームに返還すること
# 問題：適切に取り出したデータに使用しないとエラーになる
conv_data <- \(data) {
  bind_rows(data) |> 
    t() |> 
    as.data.frame() |> 
    as_tibble() |> 
    mutate(
      # 余計な記号を除去
      across(
        seq(from = 3, to = 15, by = 2),
        ~ str_extract(.x, "-?\\d.\\d+")
      ),
      # コンマを除去
      across(
        -V1,
        ~as.numeric(str_replace_all(.x, ",", ""))
      ),
      V1 = str_replace(V1, "月", "") |> as.numeric()
    )
}

# 関数：年次列を追加する ---------------
# 目的：データの情報を補完すること
add_year <- \(data, year) {
  data |> 
    mutate(
      year = year,
      .before = V1
    )
}

# 関数：一括処理用 --------------
# 目的：全ての関数を一括で適用すること
# 問題：不揃いなデータには使用できない
conv_at_once <- \(
  data,
  a,
  dur_month = 12,
  year
) {
  args <- tibble::tibble(
    a = a,
    dur_month = rep(dur_month, length(a)),
    year = year
  )
  pmap_df(args,
          \(a, dur_month, year) {
            data |> 
              ext_data(a = a, dur_month = dur_month) |> 
              conv_data() |> 
              add_year(year)
          }
  ) 
}

# 関数：2つに分かれて抽出した月次データを統合する -----------------
# 目的：不揃いなデータを適切に処理すること
# 問題：はみ出しが1か所のデータにしか対応できない
# 概要：原理的にはconv_at_onceを複数回適用しているだけ
# aのパラメータを調整することで始点をずらしている
conv_at_once2 <- \(
  data, 
  a, 
  dur_month = c(6, 6),
  year
  ) {
  # 引数リスト
  args <- tibble::tibble(
    a = c(a, a + dur_month[1] * 15 + 1),
    dur_month = dur_month,
    year = rep(year, length(dur_month))
  )
  purrr::pmap_df(
    args,
    \(a, dur_month, year) {
      data |> conv_at_once(a = a, dur_month = dur_month, year = year)
    }
  )
}

# 関数：不揃いなデータを分割して関数を適用する -----------------
# 目的：不揃いなデータを適切に処理するためひと月ずつ処理すること
# 概要：indexを使用して各月の頭を取り出して処理する
iconv_at_once <- \(
  data, 
  a = idx_df2[, 1], # indexを使用すること
  year,
  e = 1 # ズレ数
  ) {
  # 引数リスト
  args <- tibble::tibble(
    a = a,
    year = rep(year, length(a))
  )
  purrr::pmap_df(
    args,
    \(a, year) {
      data |> conv_at_once(a = a, dur_month = 1, year = year)
    }
  )
}
