library('stringr')
library('ggplot2')
library('tm')
source('phrase_structures.R')

#################################
#
# combine a whole lot of 500 record downloads into one data frame
#
#################################
combine_wos_records <- function(dir){
  files <- dir(dir,full.names=TRUE, pattern='savedrecs.*')
  recs <-lapply(files, read.csv, sep='\t', header=TRUE, as.is=TRUE, quote='', row.names=NULL)  
  df <-do.call( rbind, recs )
  
#   had to do this workaround to get full web of science working -- something
#   strange about the number of columns
  colnames(df)[1:52] <- colnames(df)[2:53]
  colnames(df)[1] <-'PT'
  return(df)
#   df[1,1:10]
}

##############################
#
#  load wos data from plain text file - usually have to save this via openoffice
#	for some reason
#
###############################

load_wos_file <- function(file='./biofuels/data/biofuel_wos_11dec2010_fixed.csv', abbreviated_frame=FALSE)	{
	wos <- read.delim(file, sep='\t', header=TRUE, fill=TRUE, as.is=TRUE, quote='')

	if (abbreviated_frame)	{
		wos_df <- data.frame('abstract' = wos$AB, 'year' = wos$PY, 'title' = wos$TI, 'journal' = wos$SO, 'type'=wos$PT)	
		return (wos_df)
	} else {
		return (wos)
	}
}

##############
#
# publication type by years
#
#############################

plot_publication_types <- function(wos){
  
  qplot(wos$DT)
}

# publications by disciplines

plot_by_discipline <- function(wos) {
  dy<-dlply(wos,.variables='PY' )
  extract_fields <- function(x){
#     browser()
    x_s <- sapply(x$WC, str_split, pattern=';')
    return(str_trim(unlist(x_s,use.names=FALSE)))
  }
  field_year <- lapply(dy, extract_fields)
  field_year[[10]]
  
#   names(f_y)
#   sapply(f_y, length)
#   is.vector(  f_y[[10]])
  field_year_melt<-melt.list(field_year)
  names(field_year_melt) <- c('field', 'year')
  field_year_melt[1,]
#   could clean things up more by combining similar fields e.g. all different psychologyies
  field_year_melt$field_short <-str_extract(field_year_melt$field, pattern='\\w+')
  field_table_df <- count(field_year_melt, 'field_short')
  field_table_df <- arrange(field_table_df, freq, field_short)
field_table_df[1:20,]
  field_table_df <- na.omit(field_table_df)

  field_table_df <- field_table_df[field_table_df$freq >20,]
  ggplot(data=field_table_df, aes(x=field_short, y=freq, fill=field_short)) + geom_bar(stat='identity') +coord_flip()+opts(axis.text.y=theme_text(size=7,hjust=1)) 
  
  #   get all the records relating to top 30 fields
  fields_top <-names(tail(sort(table(field_year_melt$field)),20))
  
  
  f <- which(field_year_melt$field %in% fields_top)
  f[1:5]
  
  field_year_melt_top <- field_year_melt[f, ]
  field_year_melt_top <- droplevels.data.frame(field_year_melt_top)
  field_year_melt_top[1:3,]
#   plots of fields by years
  ggplot(field_year_melt_top, aes(field)) + geom_bar() + coord_flip()  + facet_wrap(~year, nrow=4) +opts(axis.text.y=theme_text(size=7))
  
#   plot the topfields over years by fields
  ggplot(field_year_melt_top, aes(year)) + geom_bar() + facet_wrap(~field,ncol=4) +scale_x_discrete(name='years', breaks=seq(1966, 2011, 5))  
  
    ggplot(field_year_melt_top, aes(x=year)) + geom_histogram(aes(fill=field)) + facet_grid(field~.) 

  

}

##################################
#
#	using wos to generate movement of terms over time
#
#################################

list_frequency_by_years <- function(terms, years, wos)	{
	year_count <- vector(length=length(years))
	for (i in 1:length(years))	{
		text <- paste(wos$AB[wos$PY==years[i]]) ##could be good to put titles in here!
		count <-length(unlist(str_extract_all(pattern=terms, text)))
		year_count[i] <- count		
	}
	
	names(year_count) <- years
	
	return(year_count)
}



list_frequency_by_years_multiple <- function(terms, years, wos, plot=TRUE)	{
	##to run for many terms ....
	res=sapply(terms, list_frequency_by_years, years, wos)
	if (plot==TRUE)	{
		res_m<-melt.matrix(data=res, varnames=c('year', 'term'))
		q<-qplot(x=year,y= value, data=res_m, colour=term, geom='path')
		show(q)
	}
	return(res)
}



frequency_list_by_year <- function(wos, years, plot=TRUE, remove.stopword=TRUE, extra_stopwords = '', topcut=50)	{
	year_list <- data.frame()

	for (i in 1:length(years))	{
		text <- paste(wos$AB[wos$PY==years[i]]) ##could be good to put titles in here as well!
		fl <- frequency_list(text, remove.stopword, stopwords=c('elsevier', extra_stopwords))
		wordcount <- sum(fl)	#not sure whether this wordcount should be for all words including stopwords
		if( wordcount >0)	{		# take into count years when nothing is said!
			raw_count <- melt(head(fl, topcut))
			normalized_count <- round(raw_count$value/wordcount, 4)	# to express relative frequencies	
			this_year <- data.frame(years[i], raw_count, normalized_count)
			year_list<- rbind(year_list, this_year)
		}
	}
	year_list$binned_count <- cut(year_list[,4], 10)

	colnames(year_list) <- c('year', 'word', 'freq', 'normalized_freq', 'binned_count')	
	

	## reshape to get this in a spreadsheet format: quite a complicated function - R in a Nutshell is good on this ... 
	##year_list <-reshape(year_list, idvar='word', timevar='year', direction='wide')
	if (plot)	{
		freq_list_year_plot(year_list)
	}
	return(year_list)	
}

freq_list_year_plot <- function(year_list)	{
		cat('plotting ....\n')
		q <- ggplot(data=year_list, aes(x=word, y=normalized_freq, colour=sort(binned_count), fill=sort(binned_count)))
		q<-q+geom_bar() + opts(axis.text.x=theme_text(angle=90, vjust=0, hjust=1, size=9)) + facet_grid(year~.)
		q<- q + scale_fill_discrete()
		show(q)	
		return(q)
}
		



#######################################
#
# extract cited refs for a wos entry
#
#######################################

cited_refs <- function(wos, refs= 1:nrow(wos))	{
	cr <- tolower(wos$CR[refs])
	cr_s <- strsplit(cr, split=';', perl=TRUE)

	#could use a DOI resolver to get the XML details
	##extract all DOIs for each reference
	doi <- lapply(cr_s, FUN=function(x) {na.omit(str_extract(x, pattern='[[:digit:]]{2}.[[:digit:]]{4}/[[:graph:]]*'))})

	##check which DOIs are in the reference dataset
	#compare these doi with the pregiven data set
	doi_refs <-  wos$DI[wos$DI !='']
	doi_ref_found <- sapply(doi, match, doi_refs, USE.NAMES=TRUE)

	##construct matrix with of cross refs within the wos ids
	m<-matrix(data=0, nrow=length(refs), ncol=length(refs))
	for (i in 1:length(doi_ref_found))	{
 		m[i,na.omit(unlist(doi_ref_found[[i]]))] <- 1
	}
	return(m)

}
 
plot_publication_time_series <- function(wos, year_min, year_max){
  
#   year<- wos$PY
  ggplot(data=wos, aes(x=as.Date(as.character(PY), '%Y')), binwidth=1) + geom_freqpoly()
#     last_plot() + scale_x_date(limits=c(as.Date(paste(year_min, '-1-1', sep='')), as.Date(paste(year_max, '-12-31', sep=''))))
  
}

