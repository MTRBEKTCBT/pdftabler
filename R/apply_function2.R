
# 2017 -----------------------------
df_2017 <- 
iconv_at_once(
  df2,
  a = idx_df2[, 1],
  year = 2017
)

# 2018 ----------------------
df_2018 <- 
  iconv_at_once(
    df2,
    a = idx_df2[, 2],
    year = 2018
  )
  
# 2017--2021 ------------------
pmap_df(
  list(i = 1:5),
  \(i) {
    iconv_at_once(df2, a = idx_df2[, i], year = 2016 + i)
  }
)

# 2005--2016 --------------
pmap_df(
  list(i = 1:12),
  \(i) {
    iconv_at_once(df1, a = idx_df1[, i], year = 2004 + i)
  }
)

length(df2)
df2[idx_df2[[1]][1]:(idx_df2[[2]][1] - 1)]

f <- \(from, to) {
  df2[idx_df2[[from]][1]:(idx_df2[[to]][1] - 1)]
}

from <- 1:11
to <- from + 1

args <- list(from = from, to = to)

pmap(args, f)

df2[a2[1]:a2[2]]
df1[seq(from = 1592, length.out = 196)]
df1[1:200]
df1[seq(from = 810+15*11, length.out = 15)]
# 1月から次の1月までのベクトルの長さを数えます
df1[29:(29+196*2)] |> 
  str_subset("^1月$")
df1[29:(29+196*2)] |> 
  str_detect("^1月$") |> sum()
df1[29:(29+196*2)] |> 
  str_subset("1月")
df1[29:(29+196*2)] |> 
  str_detect("^(1月)") |> sum()
