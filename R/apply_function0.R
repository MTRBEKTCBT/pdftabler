dur_year <- 2005:2021

conbini <- 
pmap_df(
  list(i = seq_along(dur_year), dur_year = dur_year),
  \(i, dur_year) {
    iconv_at_once(alldata, month_idx[, i], year = dur_year)
  }
)
save(conbini, file = "data/conbini.rdata")
write_csv(conbini, file = "data/conbini.csv")
