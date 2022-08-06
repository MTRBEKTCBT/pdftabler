library(pdftools)
library(tidyverse)
library(purrr)
library(stringr)

# PDFファイルパスを取得してデータを抽出する ------------
path <- dir("data", pattern = "\\.pdf", full.names = T)
# pdftools::pdf_textを使ってPDFファイル内の文字列を取得します。
# 再帰的処理にはmapを使います。
# 取得した文字列データは1つのベクトルになってるため、
# 改行を目印にして分割します。
pdf_data <-
  purrr::map(path, ~ pdftools::pdf_text(pdf = .x)) |> 
  purrr::map(~ stringr::str_split(.x, " +"))
# purrr::map(~ stringr::str_split(.x, "\\n")) |> 
# map(~str_split(.x, boundary("word")))


# 1枚目のPDF ---------------------------------------
df1 <- pdf_data[[1]][[1]]

# 2ページ目 -------------------------
df2 <- pdf_data[[2]][[1]]

# 全部
alldata <- unlist(pdf_data)
