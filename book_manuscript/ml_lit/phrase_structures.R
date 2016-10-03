library('lattice')
library('tm')
library('TraMineR')
library('stringr')
library('multicore')
library(plyr)

Sys.setlocale("LC_ALL", "C")

#####################################
#
#	takes a corpus produced by tm package, and
#	runs a series of pattern matches against it
#	and then charts the results in various ways
#
#####################################################




prepare_corpus_for_patterns <- function(corpus)	{
	text  <- sapply(corpus, function(x) { t = paste(na.omit(x), collapse=' ')})
	wc <-length(unlist(gregexpr('\\w+\\W+', text, perl=TRUE)))
	cat('Corpus has ', wc, ' words in ', length(corpus), ' documents\n\n')
	return (text)
}


#########################################
#
#	what kind of 'file' does this function expect
#
#########################################

prepare_text <- function(file)	{
	t <- read.table(file, as.is=TRUE, sep='\n', header=FALSE, colClasses='character')
	t <- unlist(t)
	
	cmd <- paste('wc -w', file)
	wc <-system(cmd, intern=TRUE)
	cat('Corpus has ', wc, ' words.\n\n')
	return(t)
}





##################################
#
#	clean up  raw text and convert to vector of words
#
##############################

prepare_text <- function(text)	{
	#to lowercase, trim all white space and delete trailing whites spaces
	text <- tolower(enc2native(text))
	text_clean <- gsub('([^[:alnum:]\\s])', ' \\1 ', text, perl=TRUE, useBytes=FALSE)
	text_clean2 <- gsub('(^\\s+|\\s+$)', '', text_clean, perl=TRUE)
	#split text into vector of words
	text_words_vec <- unlist(strsplit(text_clean2, '([^-a-z0-9]+|--)'))
	cat(paste(length(text_words_vec), ' words \n'))
	return(text_words_vec)
}

##################################################
#
# frequency lists
#
################################################

frequency_list <- function(text, remove.stopwords=TRUE, stopwords='', stemming=TRUE)	{
  
	stopwords <- c(stopwords, stopwords(), ' ', '/n', 'nbsp', 'quot', 'div', 'em', 'http','www', 'com', 'margin', 'br', 'strong&gt', 'style=')
	text <- tolower(enc2native(text))
	text <- gsub('\\W+', ' ', text, perl=TRUE)
	words.list <- strsplit(text, '\\W')
	words.vector <- unlist(words.list)
	
	words.vector <- words.vector[-grep('[[:digit:]]+',x=words.vector, perl=TRUE)]
	if (remove.stopwords)	{
		words.vector <- words.vector[-which(words.vector %in% stopwords)]
	}
  if (stemming){
    require(Rstem)
    words.vector <- wordStem(words.vector)
  }
	freq.list <- sort(table(words.vector), decreasing=TRUE)
  
	return(freq.list)
}

removePlurals <- function(fl){
  library(Rstem)
  
  fl_red <- list()
  terms <- names(fl)
  stems <- wordStem(terms)
  dups <-which(duplicated(stems))
  
#   browser()
  for (i in 2:length(terms)){
    if (grepl(pattern=terms[i-1], x=terms[i]))  {
      fl_red[i-1] <- fl[i-1] + fl[i]
    } else {
      fl_red[i-1] <- fl[i-1]
    }
    names(fl_red[i-1]) <- terms[i-1]
  }
  return(fl_red)
}

combine_frequency_lists <- function(fl1, fl2, name1, name2, size=400, base_dir='.')	{
	fl1_sum <- sum(fl1)
	fl2_sum <- sum(fl2)

	fl1_centage <- round(fl1/fl1_sum * 100, 3)
	fl2_centage <- round(fl2/fl2_sum * 100, 3)
	
	df <-cbind(	names(fl1[1:size]), fl1[1:size], fl1_centage[1:size],  
			names(fl2[1:size]), fl2[1:size], fl2_centage[1:size])
	colnames(df) <- c(name1, 'freq', '%',  name2, 'freq', '%')
	
	filename <- paste(base_dir, '/', name1,'_', name2, '_freq_list.csv', sep='', collapse='')
	cat('writing combined frequency lists to: ', filename, '\n')
	write.table(df, file=filename, sep='\t', row.names=FALSE)
	return(df)
}



##############################
#
#	collocation for terms
#
#############################


collocate <- function(node, text, span=5, output.collocates=TRUE, base_dir='.', output_file_prefix='', append=FALSE, show_spreadsheet = FALSE, 
			remove.stopwords=FALSE)	{

	text_words_vec<-prepare_text(text)

	if (remove.stopwords)	{
		stopwords <- c(stopwords(), ' ', '/n', 'nbsp', 'quot', 'div', 'em', 
				'http','www', 'com', 'margin', 'br', 'strong&gt', 'style=')
		text_words_vec <- text_words_vec[!(text_words_vec %in% stopwords)]
	}
	#grep the search span
	node_word <- paste('\\b', node, '\\b', sep='')
	match_positions <- grep(node_word, text_words_vec, perl=TRUE, ignore.case=TRUE)
	results <- list()
	span_s <- (-span:span)	
	for (i in 1:length(span_s))	{
		collocate_positions <- match_positions+span_s[i]
		collocates <- text_words_vec[collocate_positions]
		sorted_collocates <- sort(table(collocates), decreasing=TRUE)
		results[[i]] <- sorted_collocates
	}

	##clean up file name
	node_name <- gsub(pattern = '[[:punct:]]*', replacement='', x=node)
	file <- paste(base_dir, '/', output_file_prefix, '_', node_name, '_collocate.csv', sep='', collapse='')

	if(output.collocates)	{
		output.collocates(results, span, output.file = file, append)
		if (show_spreadsheet) {
			system(paste('openoffice.org ', file))
		}
	}
	return(results)
}

multiple_collocate <- function(nodes, text, span=5, base_dir='.', output_file_prefix='')	{
	multi_results<-	sapply(nodes, collocate, text, span, base_dir, output_file_prefix, output.collocates=TRUE, append=TRUE)
}

#############################
#
##	output collocates
#
################################

output.collocates <- function(results, span=5, output.file, append)	{
	lengths <- sapply(results, length)
	span_f <- (-span:span)
	cat(paste(rep(c("W_", "F_"), length(span_f)), rep(span_f, each=2), sep=''), '\n', sep='\t', file=output.file, append=append)
	for (k in 1:max(lengths))	{
		string1<-paste(names(sapply(results, "[", k)), sapply(results, "[",k), sep='\t')
		string2<-gsub('NA\tNA', '\t', string1, perl=TRUE)	
		cat(string2, '\n', sep='\t', file=output.file, append=TRUE)
	}

}


##########################################
#
# construct concordance for a term
#
##########################################

concordance <- function(node, text, output.file=TRUE, base_dir='.', output_file_prefix='')	{
	pattern <- paste('\\b(', node,')\\b', sep='', collapse='')
	## find all occurrences of the node
	conc1 <- unlist(strsplit(enc2native(text), split='[?!.]', perl=TRUE))
	## split text into sentences
	conc2 <- grep(pattern, conc1, ignore.case=TRUE, value=TRUE)

	##format the output as tab separated lines	
	conc <- gsub(pattern, '\t\\1\t', conc2, ignore.case=TRUE)
	if (output.file)	{
		cat('PRECEDING CONTEXT\tNODE\tSUBSEQUENT CONTEXT', conc, 
			file=paste(base_dir, '/', output_file_prefix, '_', node, '_concordance.csv', sep='', collapse=''), sep='\n')
	}
	return(conc)

}


##############################################
#
# LSA analysis for a directory of plain text 
#
#################################################

prepare_textmatrix <- function(dir,stemming=TRUE, stopwords=TRUE)	{
	library(lsa)
	data(stopwords_de)
	data(stopwords_en)
	cat('loading files ..\n')
	sw <-''
	if (stopwords)	{
		sw=c(stopwords_en, stopwords_de, 'et', 'al', 'na')
	}
	tm <- textmatrix(dir, stemming=stemming, stopwords = sw)
	tm1 <- lw_tf(tm)*gw_idf(tm)	
	cat('write some code to remove rows with 0 entries ...\n\n')
	return(tm1)
}

heatmap_lsa <- function(tm = NULL, share=0.5, plot=TRUE)	{
	require(lsa)
	library('RColorBrewer')
	cat('doing lsa on text matrix ...\n')
	lsa <- lsa(tm, dims=dimcalc_share(share))
	cat('finished lsa, reconstituting text matrix ....\n')
	tm2 <- as.textmatrix(lsa)
	##use rowsums to work out the most important terms
	rs <- 	rowSums(tm2)
	#choose top 50 from the textmatrix
	tm_top <- head(tm2[order(rs, decreasing=TRUE),],50)
	if (plot)	{	
		cat('plotting heatmap of lsa text matrix ...\n')
		#choose colors
		cm <- brewer.pal(9, 'Blues')
		heatmap(cosine(tm2), Rowv=NA, Colv=NA, col=cm)
	}
	return(tm2)
}

##this line useful for taking a corpus
#l_ply(.data=lex_co, .fun=collocate, node='energy', span=5, output.file='energy.csv', .progress='text')




###########################
# to make combined frequency list

# bf_combined_fl <- data.frame('news'=names(bf_news_fl[1:400]), 'news_freq'=bf_news_fl[1:400], 'wos'=names(bf_wos_fl[1:400]), 'wos_freq' = bf_wos_fl[1:400],row.names=NULL, stringsAsFactors=FALSE)

