#' data is vector
vpr_index <- \(data, keywords) {
  purrr::pmap(
    tibble::tibble(
      i = seq_along(keywords)
    ),
    \(i) {
      which(data == keywords[i])
    }
  ) |>
    purrr::set_names(keywords) |>
    tibble::as_tibble() |>
    t() |>
    as.data.frame()
}


# index 各月の始まりのベクトル位置をデータ化する -----
key_month <- sprintf("%d月", 1:12)
month_idx <-
  purrr::pmap(
    list(i = seq_along(key_month)),
    \(i) {
      which(conbini == key_month[i])
    }
  )
month_idx <-
  month_idx |>
  purrr::set_names(stringr::str_c("M", seq_along(month_idx))) |>
  tibble::as_tibble() |>
  t() |>
  as.data.frame()

month_idx
# 1枚目 -----------------------
idx_df1 <- vector("list", length(key_month))
for (i in seq_along(key_month)) {
  idx_df1[[i]] <- which(df1 == key_month[i])
}
idx_df1 <-
  idx_df1 |>
  set_names(str_c("M", seq_along(idx_df1))) |>
  as_tibble() |>
  t() |>
  as.data.frame()

# 2枚目 -----------------------
idx_df2 <- vector("list", length(key_month))
for (i in seq_along(key_month)) {
  idx_df2[[i]] <- which(df2 == key_month[i])
}
idx_df2 <-
  idx_df2 |>
  set_names(str_c("M", seq_along(idx_df2))) |>
  as_tibble() |>
  t() |>
  as.data.frame()

# 各行頭までの長さを計算します。--------------------
len1 <- diff(c(which(df1 == "1月"), length(df1) + 1))
# 各行頭の位置を取得します。
a1 <- which(df1 == "1月")
s1 <- which(str_detect(df1, "\\d{4}"))
df1[s1]


# 各行頭までの長さを計算します。
len2 <- diff(c(which(df2 == "1月"), length(df2) + 1))
# 各行頭の位置を取得します。
a2 <- which(df2 == "1月")
s2 <- which(str_detect(df2, "\\d{4}"))
df2[s2]

# 各月からの1年後までのベクトルの長さを計算する ----
# 1枚目
len_df1 <- vector("list", length(key_month))
for (i in seq_along(key_month)) {
  len_df1[[i]] <- diff(c(idx_df1[[i]], length(df1)+1))
}

# 2枚目
len_df2 <- vector("list", length(key_month))
for (i in seq_along(key_month)) {
  len_df2[[i]] <- diff(c(idx_df2[[i]], length(df2)+1))
}
