library(stringr)
library(RSQLite)
library(ggplot2)
con <- dbConnect(RSQLite::SQLite(),'../ml_lit/all_refs.sqlite3')
res = dbGetQuery(con, statement ='select * from basic_refs where WC like "%statist%" OR WC like "%computer%" ;')
head(res)
table(res$WC)
res$WC = tolower(res$WC)
stat =  grep(res$WC, pattern = 'statistic', value=FALSE)
compsci =  grep(res$WC, pattern = 'computer', value=FALSE)
count = dim(res)[1]

res$DE = tolower(res$DE)
res$DE[stat]
de_split <- function(x){
    y = unlist(str_split(x, '; '))
    return(y)
}

head(sort(table(de_split(res$DE[stat])), decreasing=TRUE))
head(sort(table(de_split(res$DE[compsci])), decreasing=TRUE))
