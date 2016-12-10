
```{r global_options, include=FALSE}
knitr::opts_chunk$set(fig.width=12, tidy=TRUE, fig.height=8, 
                      echo=FALSE,  fig.show='hide', results='hide', warning=FALSE, message=FALSE, dev='pdf')
library(RSQLite)
con <- dbConnect(RSQLite::SQLite(),'../ml_lit/all_refs.sqlite3')
library(ggplot2)
library(stringr)
library(xtable)
options(xtable.comment = FALSE)
options(xtable.size = 'tiny')
options(xtable.tableplacement = '!htbp')
options(xtable.rownames = FALSE)
simpleCap <- function(x) {
    s <- strsplit(x, " |-")[[1]]
    return (paste(toupper(substring(s, 1,1)), tolower(substring(s, 2)), sep="", collapse=" "))
}
```

