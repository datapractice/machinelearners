df = read.csv('kaggle_comp_clean_2.csv')
head(df)
table(df$data_type)
table(df$domain)
barplot(table(df$domain))
barplot(table(df$domain), 'horizontal')
?barplot
barplot(table(df$domain), horiz=TRUE)
?mosaicplot
mosaicplot(table(df$domain, df$data_type))
mosaicplot(table(df$data_type, df$domain))
table(df$domain)
table(df$domain)>2
sum(table(df$domain)>2)
sum(table(df$domain)>3)
table(df$domain)
library(ggplot2)
ggplot(df, aes(x=domain, y=data_type)) + geom_hist()
ggplot(df, aes(x=domain, y=data_type)) + geom_histogram()
ggplot(df, aes(x=domain, y=data_type)) + geom_bar()
ggplot(df, aes(x=domain)) + geom_histogram()
?facet_grid
ggplot(df, aes(x=domain)) + geom_histogram() + facet_grid(.~data_type)
ggplot(df, aes(x=data_type)) + geom_histogram() + facet_grid(.~domain)
ggplot(df, aes(x=data_type)) + geom_histogram() + facet_wrap(.~domain)
ggplot(df, aes(x=data_type)) + geom_histogram() + facet_wrap(data_type~domain)
ggplot(df, aes(x=data_type, y= Reward_amount)) + geom_histogram() + facet_wrap(data_type~domain)
ggplot(df, aes(x=data_type)) + geom_histogram() + coord_flip() + facet_wrap(.~domain)
ggplot(df, aes(x=data_type)) + geom_histogram() + coord_flip() + facet_grid(.~domain)
ggplot(df, aes(x=data_type)) + geom_histogram()  + facet_grid(.~domain)
ggplot(df, aes(x=data_type)) + geom_histogram()  + facet_grid(domain~.)
ggplot(df, aes(x=data_type)) + geom_histogram()  +coord_flip()+ facet_grid(domain~.)
ggplot(df, aes(x=data_type)) + geom_histogram()  + facet_grid(domain~.)
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar + facet_grid(domain~.)
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar() + facet_grid(domain~.)
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar()
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar() + facet_grid(.~domain)
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar() + facet_wrap(.~domain)
?facet_wrap
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar() + facet_wrap(~domain)
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar() + facet_wrap(~domain) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar() + facet_wrap(~domain) + theme(panel.background = element_blank())
ggplot(df, aes(x=Teams, y = Reward_amount)) + geom_point()
ggplot(df[,df$Reward_amount>0], aes(x=Teams, y = Reward_amount)) + geom_point()
df$Reward_amount>0
df[,df$Reward_amount>0]
df[df$Reward_amount>0,]
ggplot(df[df$Reward_amount>0,], aes(x=Teams, y = Reward_amount)) + geom_point()
df2 = df[df$Reward_amount>0,]
dim(df2)
ggplot(df2, aes(x=Teams, y = Reward_amount)) + geom_point()
df2
ggplot(df2, aes(x=Teams, y = Reward_amount)) + geom_point()
df2 = df[df$Reward_amount>1000,]
ggplot(df2, aes(x=Teams, y = Reward_amount)) + geom_point()
ggplot(df2, aes(x=Teams, y = Reward_amount)) + geom_point() + scale_y_log10()
ggplot(df2, aes(x=Teams, y = Reward_amount, shape=type)) + geom_point() + scale_y_log10()
ggplot(df2, aes(x=Teams, y = Reward_amount, shape=domain)) + geom_point() + scale_y_log10()
ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain)) + geom_point() + scale_y_log10()
ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain, color=domain)) + geom_point() + scale_y_log10()
ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain, color=domain)) + geom_point() + scale_y_log10() + facet_wrap(data_type)
ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain, color=domain)) + geom_point() + scale_y_log10() + facet_wrap(data_type)
ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain, color=domain)) + geom_point() + scale_y_log10() + facet_grid(data_type)
head(df2)
ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain, color=domain)) + geom_point() + scale_y_log10() + facet_grid(data_type~)
ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain, color=domain)) + geom_point() + scale_y_log10() + facet_grid(data_type~.)
library(grid)
g1 = ggplot(df, aes(x=data_type)) + geom_histogram()  + coord_polar() + facet_wrap(~domain) + theme(panel.background = element_blank())
g2 = ggplot(df2, aes(x=Teams, y = Reward_amount, fill=domain, color=domain)) + geom_point() + scale_y_log10() + facet_grid(data_type~.)
library(gridExtra)
grid.arrange(g1,g2, ncol=2)
table(df$domain, df$data_type)
heatmap(table(df$domain, df$data_type))
?heatmap
heatmap(table(df$domain, df$data_type), Rowv=NA)
heatmap(table(df$domain, df$data_type), Colv=NA)

library(stringr)
times = str_split(df$Deadline, pattern=' ')
timecal <- function(x) {
    time = as.integer(x[[1]])
    if(length(x) == 3) {
        if (grepl(x[[2]], pattern='months') & grepl(x[[3]], pattern='ago')){
            time = time * -30
        }
        if (grepl(x[[2]], pattern='years')& grepl(x[[3]], pattern='ago')){
            time = time * -365
        }
        if (grepl(x[[2]], pattern='days')& grepl(x[[3]], pattern='ago')){
            time = time * -1
        }
    } else {
        if (grepl(x[[2]], pattern='months')){
            time = time * 30
        }
        if (grepl(x[[2]], pattern='years')){
            time = time * 365
        }
        if (grepl(x[[2]], pattern='days')){
            time = time * 1
        }
       }

    return( time)
}
library(lubridate)
library(scales)
when = sapply(times, timecal)
d = as.Date(Sys.Date())
deadlines = sapply(when, function(x) d+days(x))
df$deadlines = deadlines
ggplot(df, aes(x=as.Date(deadlines, origin='01-01-1970'), y=Teams, color=data_type)) + geom_jitter() + scale_x_date(labels = date_format("%m-%Y"))
ggplot(df, aes(x=as.Date(deadlines, origin='01-01-1970'), y=Teams, color=data_type)) + geom_line(aes(group=data_type)) + scale_x_date(labels = date_format("%m-%Y"))

