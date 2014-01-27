# ch_7_notes
Optimising and competing: the lives of machine learners
'Wonderful people': programmers in the regime of anticipation

## from the proposal

#### Key examples: spam filter; Kaggle facebook retention; Kaggle R recommendation engine; TopCoder; Sage Bionetworks
#### Key techniques: ensembles, RandomForests

 - selfhood in Kaggle and Google compute - random forest; aggression, competition, and optimisation in the algorithmic

The chapter focuses on the forms of subjectivity associated with contemporary data practice, situated within plural data and knowledge economies. Software developers, hackers, statisticians, 'data scientists,' as well as social scientists, are changed by forms of data thought. The case study in this chapter is data prediction contests run by the [Kaggle.com](kaggle.com) as well as academic-based competitions. In these competitions, competitors from diverse technical and geographic backgrounds compete to construct predictive models for specific datasets -- the Netflix recommendation competition; the Facebook 'find a friend' competition; or the Titanic survivor problem -- using whatever machine learning techniques they can bring to bear. These competitions, conducted on web-based platforms, are useful ways to track contemporary data practices. Combined with some examples of presentations by academic researchers (for instance, Stanford University's Andrew Ng whose YouTube lectures haved attracted 100,000s of views), industry conferences (for instance, at the annual Predictive Analytics World events), this chapter will track the kinds of technical and affective investment associated with popular data modelling techniques such as Random Forest. It is possible, I will suggest, to read a technique as a partial subjectification, in that it affects how they experience and materially engage with data. In order to apprehend the character and texture of these subjectifications, the chapter links university research, commercial and non-commercial adoption, and flows of technical expertise. Again, this chapter has some auto-ethnographic vignettes, as the author has participated in some of these competitions.



## todo

- include the algorithms as subjects
- cruel optimisation and maximising expectation - EM algorithm
- the really important issue of the politics of algorithms: competition, optimisation, knowledge economy
- the Adzuna dataset: nicely recursive example
- interview the Adzuna winner 
- the McKinsey report and its citation; the google guy
- the role of competition -- how it is inherent in the models (loss function), how it structures the practice (getting an edge -- see Cathy O'Neill on this; as well as Kaggle CEO talks; on the rate of profit); 
- think how the EM algorithm could be a figure for competitiveness?
- not sure much the productivity of labour but its predictivity, and the need for excess labour power;
- arvidsson on reputation

## Examples

### Adzuna job descriptions -- Kaggle competition data - 2013

Nice thing about this example is that it is about work!
- Adzuna data is largely textual, but also geographical locations, and numerical values.

```{r echo=FALSE} 
	
	adzuna <-read.csv('../kaggle/adzuna/data/Valid.csv')
	xtab <- xtable(adzuna[1:5,-3])
	print(xtab, rotate.colnames=TRUE,comment=FALSE)
	
	#print(xtab, floating.environment='sidewaystable')

```
### http://docs.prediction.io/current/

>PredictionIO is an open source Machine Learning Server. It empowers programmers and data engineers to build smart applications. With PredictionIO, you can add the following features to your apps instantly:

    predict user behaviors
    offer personalized video, news, deals, ads and job openings
    help users to discover interesting events, documents, apps and restaurants
    provide impressive match-making services
    and more....

PredictionIO is built on top of solid open source technology. We support Hadoop, Mahout, Cascading and Scalding natively.

- predictionio -- for how it tries to get people to use it -- see also chapter of datamining book on this with analysis of recommendation engine; Simon Chan + blog examples of what to predict/recommend

Olivier Grisel -- won Adzuna contest(?); works on scikit-learn

### linked-in
Pete Skomoroch LinkedIn talk   on http://datawrangling.com/skills-reputation-search-lucene: 401k world -- open source - 'connect the worlds professionals'; a flywheel of data and value
	 'data amplifies desire' -- the LinkedIn motto - a flywheel of data and value -- let's say you work at google; it's the web of all the other information that will help us; trying to do for economics of skills what Facebook does for socialgraph or wikipedia does for topics; "we're doing it for this economic graph"

### hilary mason talking about her own images on google

http://www.lucenerevolution.org/2013/Keynote-Search-is-not-a-solved-problem

## Quotes to use

Cruel optimism is the condition of maintaining an attachment to a problematic object in advance of its loss. ... One makes affective bargains about the costliness of one’s attachments, usually unconscious ones, most of which keep one in proximity to the scene of desire/attrition (Lauren Berlant, _Cruel Optimism_, 2007, 21) 


Lazzarato on Tarde
C’est dans les métamorphoses et les variations de l’action de subjectivation et non les métamorphoese et les variations of valuer qu’il faut chercher la dynamique immanente du capitalisme 142
> Look for metamorphoses and variations in the action of subjectification rather than of value that need to examine in order to find out about capitalism. 142, Lazzarato

Labour as intermediate between routine and invention 255

> Important passage on distinction between living and dead labour, and how Tarde reconfigures it.  -  as living machine.  - there are automatisms in human and virtualities in the machine 265-6



## Abstract

> It has been argued that we increasingly live in a regime of anticipation [@adams_anticipation_2009] in which likelihoods and probabilistic outcomes prevail. Many settings, ranging across finance, social media, biomedical science and military planning, rely on a semi-automated form of statistics - sometimes called 'machine learning' - to generate the predictions on which anticipation relies. Anticipation takes hold as these settings incorporate _predictivity_ focused on the attributes of populations and individuals. What kinds of subjects live in the regime of anticipation? Shifts in predictive practice directly index the re-shaping of subjectivity in anticipation. Exploring the use of machine learning in social media, this paper examines predictive practice of anticipation. It shows how software developers and programmers not only become agents of anticipation, but internalise  regimes of anticipation through technical practices. Shifts in programming practice hint at what it is like to be an agent of anticipation.

