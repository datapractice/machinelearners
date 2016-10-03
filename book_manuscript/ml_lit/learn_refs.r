pdfgrep -p 'learn' hastie_elements_2009.pdf>learn.txt
l = read.csv('learn.txt', sep=':')
library(ggplot2)
colnames(l) = c('page', 'count')
l_clean = l[l$page >=8 & l$page <= 715,]
ggplot(l_clean, aes(x=X3,y=X1)) + geom_bar(stat='identity') + scale_y_discrete()
ggplot(l_clean, aes(x=page,y=count)) + geom_bar(stat='identity') + scale_y_discrete()
