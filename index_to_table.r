#!/usr/bin/Rscript

library(stringr)
v = read.csv('index_fin_by_chapter.md', sep=':', header=FALSE)
colnames(v) = c('ch', 'term')
v$term_clean = gsub(str_extract(v$term, '\\{.+\\}'), pattern ='[{}|()]', replace='')
v$ch = str_extract(v$ch, '\\w+(\\d_)?(\\w+)?/')
tab = table(v$term_clean, v$ch)
names = grep(rownames(tab), pattern='^[[:lower:]]+')
tab_index = tab[names,]
write.csv(tab_index, 'index_table.csv')
