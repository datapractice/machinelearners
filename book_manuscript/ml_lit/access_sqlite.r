library(RSQLite)
con <- dbConnect(RSQLite::SQLite(),'all_refs.sqlite3')
res = dbGetQuery(con, statement ="select * from basic_refs limit 10;")
res$anchor
res$TI
res$DE
