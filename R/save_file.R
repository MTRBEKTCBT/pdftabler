
# できあがったデータはCSVとして保存しておきます。
write.csv(
  conbini1,
  file = "data/pdf_data.csv",
  fileEncoding = "CP932",
  row.names = F
)
# 使用したデータオブジェクトも保存しておきます。
save(conbini1, file = "data/conbini1.rdata")
