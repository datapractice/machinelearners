
# code from https://code.google.com/p/rf-ace/wiki/RPackageInstallation
rface_demo <- function(x) {

	library(rfacer)
	setwd('~/Documents/data_intensive/post_genome_book_stevens_etc_2012/')
	# Loads a file into a data frame
	data <- read.afm("data/test_103by300_mixed_nan_matrix.afm")
	print(head(data[1:10, 1:10]))
	# Perform feature selection with default parameters
	associations <- rface.filter(data,"N:output")

	
	# Train a RF predictor with default parameters
	predictorObj1 <- rface.train(data,"N:output")

	# Predict with train data
	predictions1 <- rface.predict(predictorObj1,data)

	# Save the predictor
	rface.save(predictorObj1,"data/predictor.sf")

	# Load the same predictor (equals to predictor1)
	predictorObj2 <- rface.load("data/predictor.sf")

	# Make predictions with the loaded predictor (equals to predictions1)
	predictions2 <- rface.predict(predictorObj2,data)
cat('\n\n Predictions .... ')
	print(predictions1)
}

tests <- function(x) {
	library(rfacer)
	data <- read.afm('data/test_12by21_categorical_matrix.arff')
	head(data)
		predictorObj1 <- rface.train(data,"N:output")
}

lasso <- function(x) {	

dat<- read.table('data/BPdata.txt')
height <- dat$height
bp <-dat[,'bloodpressure']
plot(bp,height)
m1<-lm(height~bp)
summary(m1)


snps <- as.matrix(dat[,1:100])
t1<-table(bp, snps[, "RS6659552"])

snps1<-as.matrix(snps)
height1<-height
for(i in 1:100){
height1<-height1[!is.na(snps1[,i])]
snps1<-snps1[!is.na(snps1[,i]),]
}
dim(snps1)
library(lars)
lass <- lars(snps1, y=height1, max.steps=10)
plot(lass)
coef(lass)
n<-nrow(snps1)

# to chosse model
aic <- 2*lass$df + n*log(lass$RSS/n)
bic <- log(n)*lass$df + n*log(lass$RSS/n)
aic
bic
which.min(aic)
which.min(bic)


 # demo based on Wu, et al, 

library(lars)
data(diabetes)
diabetes$x
summary(diabetes$x)
model <- lars(type='lasso',x = diabetes$x, y=diabetes$y )
plot(model)


	library(GEOquery)
	 # get the van Heel,D. et al. (2007) A genome-wide association study for celiac disease identifies
	#risk variants in the region harboring IL2 and IL21. Nat. Genet., 397, 827–829.



	# celiac_gse<- getGEO('GSE11501',GSEMatrix=TRUE)
	# show(gse2553)
	# show(pData(phenoData(gse2553[[1]]))[1:5,c(1,6,8)])

	#this is the coeliac datasets
	gds <- getGEO("GDS3646")

	# gds <- getGEO(filename=system.file("extdata/GDS507.soft.gz",package="GEOquery"))
	Meta(gds)
	Table(gds)[1:5,]
	Columns(gds)

	response <- Columns(gds)[2]
	features <-  Table(gds)[1:2,-c(1:2)]

	 gpl <- getGEO(filename=system.file("extdata/GPL6104.annot.gz",package="GEOquery"))

	eset <- GDS2eSet(gds,do.log2=TRUE, GPL=gpl)
	pData(eset)

	#get the response variable and the features

	response <- eset@phenoData@data$disease.state
	exprs(eset)
	# show the logistic model for the probability of a particular case being positive?

	# show the lasso model finding a limited set of predictors

	# show the lasso mode working on interactions between those predictors ... 


}


knn <- function(k=c(15,5)) {
	# based on Hastie

	library(ElemStatLearn)
	require(class)
	x <- mixture.example$x
	g <- mixture.example$y
	xnew <- mixture.example$xnew
	par(mar=rep(2,4), mfrow=c(1,2))

	mod <- class::knn(train=x, test=xnew, cl=g, k[1], prob=TRUE)
	prob <- attr(mod, "prob")
	prob <- ifelse(mod=="1", prob, 1-prob)
	px1 <- mixture.example$px1
	px2 <- mixture.example$px2
	prob <- matrix(prob, length(px1), length(px2))

	contour(px1, px2, prob, levels=0.5, labels="", xlab="", ylab="", main=paste(k[1],"- nearest neighbour"), axes=FALSE)
	points(x, col=ifelse(g==1, "coral", "cornflowerblue"))
	gd <- expand.grid(x=px1, y=px2)
	points(gd, pch=".", cex=1.2, col=ifelse(prob>0.5, "coral", "cornflowerblue"))
	box()

	mod <- class::knn(train=x, test=xnew, cl=g, k[2], prob=TRUE)
	prob <- attr(mod, "prob")
	prob <- ifelse(mod=="1", prob, 1-prob)
	px1 <- mixture.example$px1
	px2 <- mixture.example$px2
	prob <- matrix(prob, length(px1), length(px2))

	contour(px1, px2, prob, levels=0.5, labels="", xlab="", ylab="", main=paste(k[2],"- nearest neighbour"), axes=FALSE)
	points(x, col=ifelse(g==1, "coral", "cornflowerblue"))
	gd <- expand.grid(x=px1, y=px2)
	points(gd, pch=".", cex=1.2, col=ifelse(prob>0.5, "coral", "cornflowerblue"))
	box()
}


