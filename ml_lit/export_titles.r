
library(RSQLite)
con <- dbConnect(RSQLite::SQLite(),'../ml_lit/all_refs.sqlite3')
res = dbGetQuery(con, statement ="select * from basic_refs limit 10;")
res = dbGetQuery(con, statement ="select TI, DE, WC, TC from basic_refs;")
res$full = paste(res$TI, res$DE, sep=' ' )
writeLines(res$full, con = 'res.txt')
colnames(res)
