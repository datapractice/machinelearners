library(stringr)
library(RSQLite)
library(ggplot2)
con <- dbConnect(RSQLite::SQLite(),'../ml_lit/all_refs.sqlite3')
res = dbGetQuery(con, statement ='select * from basic_refs where WC like "%statist%" OR WC like "%computer%" OR WC like "%computer%";')
res = dbGetQuery(con, statement = "select DE, WC, SC, TI, PY from basic_refs")
head(res)
table(res$WC)
res$WC = tolower(res$WC)
res$DE = tolower(res$DE)
stat =  grep(res$WC, pattern = 'statistic', value=FALSE)
compsci =  grep(res$WC, pattern = 'computer', value=FALSE)
eng =  grep(res$WC, pattern = 'engineer', value=FALSE)
interdisc = intersect(stat, compsci)
count = dim(res)[1]

norm_terms <- function(x){
    y = str_replace(x, pattern='artificial ', '')
    z = str_replace(y, pattern='svm', 'support vector machine')
    return(z)
}

de_plural <- function(x){
    z = str_replace(x, pattern = '(.+)s$', replacement = '\\1')
    z = norm_terms(z)
    return(z)
}

de_split <- function(x){
    y = unlist(str_split(x, '; '))
    return(y)
}

tablify <- function(x) {
    z  = sort(table(de_plural(de_split(x))), decreasing=TRUE)
    df = data.frame(z, disc = names(z))
    return(df)
} 

view(head(tablify(res$DE[stat]), 30))
view(head(tablify(res$DE[interdisc]), 30))
view(head(tablify(res$DE[compsci]), 30))
view(head(tablify(res$DE[eng]), 30))

