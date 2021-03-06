library(rda)
library(datamicroarray)
describe_data()
library(ISLR)
data(NCI60)
head(NCI60)
pr.out =prcomp(NCI60$data, scale=TRUE)
Colc = function(vec){
cols = rainbow(length(unique(vec))
return(cols[as.numeric(as.factor(vec))])
Colc = function(vec){
cols = rainbow(length(unique(vec)))
return(cols[as.numeric(as.factor(vec))])
}
par(mfrow=c(1,2))
plot(pr.out$x[,1:2], col =Cols(NCI60$labs), pch=19, xlab='Z1', ylab='Z2')
plot(pr.out$x[,1:2], col =Colc(NCI60$labs), pch=19, xlab='Z1', ylab='Z2')
plot(pr.out$x[,c(1,3)], col =Colc(NCI60$labs), pch=19, xlab='Z1', ylab='Z3')
plot(pr.out$x[,c(1,3)], col =Colc(NCI60$labs), pch=19, xlab='Z1', ylab='Z3')
plot(pr.out$x[,1:2], col =Colc(NCI60$labs), pch=19, xlab='Z1', ylab='Z2')
plot(pr.out$x[,c(1,3)], col =Colc(NCI60$labs), pch=19, xlab='Z1', ylab='Z3')
summary(pr.out)
plot(pr.out)
pve = 100*pr.out$sdev^2/sum(pr.out$sdev^2)
par(mfrow=c(1,2))
plot(pve, type='o', col='blue')
plot(cumsum(pve), typ='o', col='brown3')
par(mfrow=c(1,3))
sd.data = scale(NCI60$data)
data.dist = dist(sd.data)
plot(hclust(data.dist, method='complete'), labels=NCI60$labs, main='complete')
plot(hclust(data.dist, method='average'), labels=NCI60$labs, main='average')
plot(hclust(data.dist, method='single'), labels=NCI60$labs, main='single', xlab='')
#cutting the dendrograms
hc.out  =hclust(data.dist)
hc.clusters =cutree(hc.out, 4)
table(hc.clusters, NCI60$labs)
par(mfrow=c(1,1))
plot(hc.out, labels = NCI60$labs)
plot(hc.clusters, labels = NCI60$labs)
plot(hc.clusters)
par(mfrow=c(1,1))
plot(hc.out, labels = NCI60$labs)
abline(h=139, col='red')
km.out = kmeans(sd.data, 4, nstart=20)
km.clusters = km.out$cluster
table(km.cluster)
table(km.clusters)
hc.out2 = hclust(dist(pr.out$x[, 1:5]))
plot(hc.out2, labels = NCI60$labs)
plot(hc.out, labels = NCI60$labs)
savehistory(file='~/book/ch6_topologies/nci60.r')
