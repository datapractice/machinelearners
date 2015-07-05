library(tm)
library(topicmodels)
library(parallel)
files = list.files('data/topicmodel_WOS', full.names=T)
#df = read.delim(files[1], as.is=TRUE, header=TRUE, row.names=NULL)
#df2= read.delim(files[2], as.is=TRUE, header=TRUE, row.names=NULL)
#df3 = rbind(df, df2)
res = mclapply(files, function(x){
       read.delim(x, as.is=TRUE, header=TRUE, row.names=NULL)})
df_all = do.call(rbind, res)
cols = colnames(df_all)

cat(cols)
colnames(df_all) <- cols[2:length(cols)]
ti_ab = tolower(paste(df_all$TI, df_all$AB, sep=' '))
vs = VectorSource(x=ti_ab)
vc = VCorpus(vs)
vc = tm_map(vc, stemDocument, lazy=FALSE)
extra_stopwords = c('lda', 'acm', 'comp', 'ieee', 'paper', 'sci', 'doi', 'latent', 'allocation', 'res', 'conference', 'data', 'int', 'can', 'topic','latent', 'dirichlet', 'topics', 'model', 'models')
vc = tm_map(vc, removeWords, c(stopwords(), extra_stopwords))
dtm = DocumentTermMatrix(vc, list(stopwords=TRUE, removePunctuation=TRUE,  removeNumbers=TRUE))
k = 20
topicmodel_k = LDA(dtm, k)
terms(topicmodel_k, 10)
perplexity(topicmodel_k)

ks = seq(10, 300, 30)
tms =lapply(ks, LDA, x=dtm)

lapply(tms, perplexity)
