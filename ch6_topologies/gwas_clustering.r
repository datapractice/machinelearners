library(cluster)
library(gplots)
library(ape)
library(stringr)
library(dplyr)

#clean up the data and remove duplicates
gw = read.csv('data/gwas_catalog_v1.0-downloaded_2015-04-27.tsv', sep='\t')
colnames(gw)
gw_sel = distinct(select(gw, 2,4,8,33))
sort(table(gw_sel$DISEASE.TRAIT))
#construct N and p features
plat = gw$PLATFORM..SNPS.PASSING.QC.
p = str_extract(plat, pattern='\\[.*\\]')
#p = str_extract(p, '^.*?(?=(;))')
p = str_replace(p, '(\\w+ ){2}', '')
p = str_replace(p, ' \\w+', '00000')
p = str_replace_all(p, '[\\.~,]?', '')
p = str_replace_all(p, '\\[|\\]', '')
gw_sub = gw[,c(8,9,11,12, 13, 14,15,18, 21,25,27,33,14)]
gw_sub = data.frame(gw_sub,as.numeric(p))
samp = gw$INITIAL.SAMPLE.DESCRIPTION
n_list = str_extract_all(samp, '\\d+,?\\d*')
n_total = lapply(n_list, function(x){ sum(as.numeric(sub(x, ',' '')))})
sort(table(p))
unique(p)
top_traits = tail(sort(table(gw$DISEASE.TRAIT)),20)
top_traits = names(top_traits)
gw_top_diseases = gw_sub[gw_sub$DISEASE.TRAIT %in% top_traits,]
gw_top_diseases_full = gw[gw$DISEASE.TRAIT %in% top_traits,]
gw_sample = gw_top_diseases[sample(nrow(gw_top_diseases),100),]
gw_sample = gw_sub[sample(nrow(gw),100),]
gw_sample = sample_n(gw_sel, 200)
#dist_top = daisy(gw_top_diseases[sample(nrow(gw_top_diseases),1000),], metric='gower'
dist_top = daisy(gw_sample, metric='gower')
attr(dist_top, 'Labels') = gw_sample$DISEASE.TRAIT
attr(dist_top, 'Labels') = gw_sample$p
attr(dist_top, 'Labels') = paste(gw_sample$DISEASE.TRAIT, gw_sample$p)
heatmap.2(as.matrix(dist_top), trace='none')
heatmap.2(as.matrix(dist_top),labCol= gw_sample$DISEASE.TRAIT, labRow = gw_sample$p, trace='none')
plot(hclust(dist_top),cex=0.6)
plot(as.dendrogram(hclust(dist_top)),cex=0.5, horiz=TRUE)

##abbreviate dendrogram labels

hc= hclust(dist_top)
la_or  = hc$labels[hc$order] 
labs = unique(la_or)
lab_locs = sapply(labs, function(x){which(la_or ==x)})
lab_locs
names(lab_locs) = labs


hc.out = hclust(dist_top)
hcd = as.dendrogram(hc.out)
plot(hcd, type='triangle')
hc.clusters = cut(hcd, h=0.4)
plot(hc.clusters$upper ) 
plot(hc.clusters)
table(gw_sample$DISEASE.TRAIT)
sort(table(gw_sample$DISEASE.TRAIT))
as.dendrogram(hclust(dist_top))
plot(as.dendrogram(hclust(dist_top)))
plot(as.phylo(hc.out), type='fan')
dendro = as.dendrogram(hc.out)
plot(dendro, horiz=TRUE, cex=0.5, axes=FALSE)
savehistory('gwas_clustering.r')
