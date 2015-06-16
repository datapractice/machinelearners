## preface

- vignettes from texas 97 calculator through manchester fieldwork, etc
- the sea and the escarpment; the trajectory - steel, coal, not the epicentre;
- there is a punishing level of technical specificity here. That will disinterest some people, and rightly so. Not everyone should have to do this. 
- highly literate machine learners will not find enough technical detail here - they should read for the outside; what about the others? focus on the diagrammatic ... 
- the choice of datasets -- deliberately limited; I've not gone searching for outside data, but stuck with the literature very closely in most cases; but the literature includes code;
- talk about the various meanings of 'into' : what is put in, a movement inwards, into as in like, a historical transition; link to James on conjunctions
- talking about unlearning  -- and what that might mean
- the look of this book -- it imitates its objects in certain ways -- typographically, diagrammatically, and infrastructurally ... 
- talk about the github site, and how to run the book
- the key datasets --- a set of 400k abstracts from all disciplines in the wos
- the typographic conventions used in this book -- follow Venables and Ripley


## ch introduction

- the feeling of agency, no matter how limited, comes from movement. This movement can take different forms -- it can be motoric, perceptual, affective, conceptual, animated, mechanised. But the point is that the feeling can then be concatenated, give rise to patterns of imitation, and to conflagrations and contagions that ignite or flow along faultlines and zones of slippage. We should not, according to Foucault begin from the vast strategic or even hegemonic monuments but from the local relations of force. 

## ch_praxis


- the fact that spark has mlib and its examples as the standard ones
- the github argument -- how it is changing the way in which these systems are put together
- add in McCloskey 2014 paper on the diagrammatic (in doc archive -- data_intensve)
- add in notes from Exeter paper about diagonalization; and perhaps start with the diagonal diagram from hastie;
- scientific papers form a substrate here; but they are entangled with software, with databases, with institutions, and with a widening circle of actors
- learning about learning --
    - the Literature - landecker and kelty on treating literature as the informant; examples such as Cover-Hart, Breiman, etc
- Michie, Spiegelhalter 1994 book has report on the Statlog project -- it tried to bring all method together; good that it mixes stats and computer scientists; managed by Daimler-Benz; shows that the problem of diversity of techniques has been discussed before; look at how they tried to bring  the methods together;
- the habit of recursive application of code to itself, or to something close by, without ever going too far -- I'll do that too -- use the algorithms to investigate the literature, to classify the examples, to see how things move; but I don't want to place too much weight on this recursion, as it is something that needs to be analsyed. See the recent Totaro article -- not recursion as an intrinsic formal property, but as a practice in certain domains that allows a form of movement.
- Cathy O'Neill writing about why big data is over -- doing one course is not enough ... 
- done? On the aridness of the textbooks and literature and what to do about that. 
- add Parisi quote about software cultures: '
>The epochal challenge of programming cultures is to venture into the infinity of incomputable probabilities (infinite discrete unities that are bigger than the totality of the whole sequence of algorithmic instructions) that lies beyond both the digital ground and interactive empiricism. 77
- the entwining of the models and the data with this text -- it can't be shown in this text, in the same way that it can't be easily shown in the world.  
- complain about all the vignettes and case studies in this area - Mayer-Schonberger, the podcasts, etcs

## ch vector


- the tables are not meant to be looked at -- cf. a typical report table; the quote from MF d&P is really relevant here -- present the contrast?
- the rows are sometimes called 'the observations' -- connect to MF on observation
- the response column is what has to be constructed -- it is added on 
- the basic functions and their transformation of the linear model into a non-linear one
- go straight into the data -- talk about how hastie and others do this;
- the thing about looking at patterns -- someone elses turkish carpet
- Beniger article on history of stats graphics; Marchese on tables;
- bring in `iris` discussion
- do library dependencies with datasets added; create map of datasets; add datasets from other sources; 
- pull apart some diagrams using inkscape -- use this to show what happens to the abstract spaces
- mention how things that don't seem to be vector spaces are put into vector spaces (e.g. market basket analysis)
- use the metaphor of the house architecture and real estate as a figure to help explain the diagramming
- reference history of tables -- e.g. downloaded chapter -- need to get from samsung laptop
- discuss problem of tables -- how they diagrammaticaly generate high D spaces that we then wrestle with, mightly and again diagrammatically -- fallacy of misplaced concreteness?
- see history of statistics in terms of plurality of attempts to deal with the diagramming of the table
- add Foucault on the appearance of deep order in life/language/labour -- this is a really important thread to draw through - in this case through the reconstruction of the _table_. 
- add quotes from Foucault on the table of space of order, and ask how he thought about quantity, etc; and what is happening to tables today.
- quotes from Wark on the vector
- measure of distance -- and its use in knn
- fitting a line -- the cost of the mode
- creation of volumes by multiplication 
- the dot product or inner product - creates the vector space
-  Knowledge as a 'mechanism of statements and visibilities'
-  generalization as what cannot be seen

## ch function


- add secondary refs from zotero on steepest descent
- comment on other optimisation algorithms -- EM; non-gradient-based; Newton-Raphson; etc
- more on SAheart example
- diagrams of the problem of classification

## ch allness

## ch dimensional


- vapnik and russia vs decision tree/random forest (Breiman; St Ives)
- what happens in code here -- the inner product; the recursive, the backprop algorithm ... 
- what happens to knowledge -- knowledge understood in Foucaultean sense as savoir;  the discursive practices that criss words and things
- the dispersion of techniques in domains suggests something like an enunciative function; at the same time, the techniques themselves are statements addressing a common problem around separating that which overlaps or blurs; 
- another form of dispersion -- the same techniques found in different fields under different names -- e.g. reinforcement rule learning

## ch genome

- spectacular indexicality is a key theme here -- need to massively strengthen this
- conclusion is still not right -- shorten it
- knn discussion is not properly integrated -- how to do that? Does the technique itself suggest a manner of moving? also, it's not of khan, golub, etc -- redo with Khan; add hclust dendrogram
- clustering, etc. not represented, but important -- use images for this
- quotes from fix are not here properly -- integrate them -- especially the one about non-parametric, blah, blah
- circo diagram of the disciplines and techniques?

## ch subject


- the programming of ml as the backpropagation and feed forward of machine learning as function finding into finding a function for machine learning 
- hinton -- backpropagation of error -- the 1986 nature paper uses examples of people
- 'generalization error is what we care about' [@Ng_2008f]
- deep neural nets [@Hassabis_2013] should appear here
- the Higgs Boson challenge
- MF in d&p writes about how the individual internalises the disciplinary mechanism -- we are all machine learners now?
- the masculinity of machine learning -- how to deal with that? some prominent women, but massively masculinist -- takes me back to 1996 publication - also use SI of angelaki on geophilosophy of masculinity. See zotero masculinity folder
- the people change alongside the data; their sense of the power of data has a cost for them too
- put in Perlich stuff about data leakage -- really important to focus on competition as a way of showing how people do things
- we finally reach people -- why so late? And so what?
- use Lazzarato here -- semiotics, etc
- MF from archaeology of knowledge on the subject in the discursive formation

## conclusion

- present what I've been doing as an account of a transformation in human-machine relations; something that transforms scale, agency, dispersion, etc;
- return to 'into' and 'out' of the data: so many attempts to get things out of the data; little effort to puts things into the data;
- what if this book was a model -- what kind of model would it be
- overview of the parts, and the chapters
- the media-science-government
- I use media as shorthand for media in general: they are things or infrastructures, which are also things, and things are media (Lash & Lury)
- why I haven't done critique of surveillance, etc? Or of the hype?
- what does it add to have this concrete account of abstraction?
- what does it add to have followed some of the infrastructures, implementations, etc 
- what happened to the affective/psychoanalytic/movement in thought?
- the praxiography -- writing code as practice that allows something about movement to be contoured and perhaps countered. 


## from toodledo


Buy trust in numbers
Could data science turn the tide in the fight against cybercrime?
Data You Can Believe In - NYTimes.com
Do data explore on clinical
Get 9 important statistics papers
Get data center book
Get john Johnston on ai
Get king science article to chapter 6
Get riding the wave report eu
Get schull on gambling
Go through history of infoviz
Guest Post: ROB TIBSHIRANI | Normal Deviate
How Twitter Found Its Money Mojo ﻗ°½ Backchannel ﻗ°½ Medium
How to balance false positive and negatives
Index of /yks/documents/classes/mlbook/pdf
Jeff Larson kills it at the Lede Program http://mathbabe.org/2014/08/22/jeff-larson-kills-it-at-the-lede-program/
O'Reilly Radar - News & Commentary
Part2: describe as modes of ordering
Proposal: book has simple theoretical argument
Proposal: highlight literature as data
Proposal: say why not doing visual
The curse of big data ﻗ°± AnalyticBridge
Web page not available
another mooc on ml
ch0.: Computational social science: Making the links
ch0:  use breiman to contrast statistics and machine learning
ch0: "Guest post: Rage against the algorithms" http://feedly.com/k/1b6WZCr
ch0: A List of Data Science and Machine Learning Resources | Conductrics
ch0: A chart of the big data ecosystem | matt turck
ch0: Gary king on social science
ch0: O'Reilly Radar - News & Commentary
ch0: Papers in Big Data  Mendeley Group
ch0: Scientists See Advances in Deep Learning, a Part of Artificial Intelligence - NYTimes.com
ch0: Twitter data crunching: The new crystal ball
ch0: add conditional random field work on video
ch0: add recent literature on algorithms - solon baroccas, etc
ch0: appadurai on calculation
ch0: expectation-maximisation algorithm
ch0: gane on empiricism
ch0: get strathern common knowledge 2011
ch0: introduce the ML literature
ch0: lury on amphibious
ch0: proposal: add Andrejevic 2013
ch0: put Marquard smith in
ch0: put order of things in
ch0: put some big data talk in from various books, media and technical
ch0: say why neural nets are important
ch0: titanic -- use this analysis
ch0: uhlman's point about the limits of machine learning
ch0: zest finance: example of big data in money
ch0:Big Data Is Great, but Donﻗ°ﻷt Forget Intuition - NYTimes.com
ch1 Programming: Pick up Python : Nature News & Comment
ch1 Python Gets a Big Data Boost From DARPA
ch1 p-value.info: Free Datascience books
ch1: Add diversity of factor, binning, merging in R
ch1: List methods to use in book
ch1: Make some big data
ch1: Programming tools: Adventures with R : Nature News & Comment
ch1: visualization as method - use Rose, Mitchell
ch2 add the constructible of the prediction column
ch2 put manhattan plot into list of graphics
ch2: Look at hastie glmnet datasets
ch2: add Malley on logistic regression
ch2: add olazaran perceptron articel
ch3: Why Generic Machine Learning Fails  Metamarkets
ch3: add Hinton 2006
ch3: add gradient descent history to ch
ch3: discuss vector space model
ch3: kinect for decision tree
ch3: neural networks as the bridge
ch3: put in transduction vapnik into
ch3: use graph of techniques to motivate choice of techniques
ch4  add Naive Bayes & Bayes Optimality
ch4: CamDavidsonPilon/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers ﺁ٧ GitHub
ch4: Get Warner & Toronto 1961
ch4: Obama Wins: How chicago's Data-Driven Campaign Triumphed  TIME.com
ch4: autonomy bayesian - put into bayes case study
ch4: check Mcnally on bayes
ch5 World's Top Data Scientists Open Doors To Big-Cash Contests - Forbes
ch5 data gotham videos as good source of speakers and examples
ch5: Claudia Perlich
ch5: In The Future, The Data Scientist Will be Replaced by Tools
ch5: Poseurs should not own the backlash against data science poseurs
ch5: Prize-based contests can provide solutions to computational biology problems : Nature Biotechnology : Nature Publishing Group
ch5: Put Nyt infographics into reality subjectivity chapter
ch5: Social Science Statistics Blog: Kaggle is going to take your job
ch5: Top technology gurus to design mobile phone game to speed up cancer cures : Cancer Research UK
ch5: courses:bigdata:start  CILVR Lab @ NYU
ch5: dataedge event speakers
ch5: knack approach to people analytics
ch5: people to put into subjectivity chapter - cathy  oneil, rachel schutt
ch5: winner of kaggle adzuna contest -- vlad minh
ch5:: Columbia Data Science course, week 7: Hunch.com, recommendation engines, SVD, alternating least squares, convexity, filter bubbles  mathbabe
ch5:: add Obama data guy
ch6 Add hansen lecture 3 to goldsmiths number paper
ch6 add h1n1 pubmed articles to h1n1
ch7 Genophen as example of ml
ch7 Put buffalo ms study into reality world
ch7: New big data firm to pioneer topological data analysis
ch7: Track machine learning in biology over 20 years
ch7: kaggles own analysis of its talent
ch7: rf-ace - multivariate machine learning with heterogeneous data - Google Project Hosting
ch7:The Mathematical Shape of Big Science Data | Simons Foundation
ch8 AI Software That Could Score You the Perfect Job | WIRED
ch8: sketch what book means for doing data
ch8: sketch what book means for researching social
ch8: sketch what book means for theories of social
check Dan Sperber's work
check David rokeby videos and peter campus
check HiveR package in R
check body in james
check descolla
check myers recent
check out hayles how we think
get import requests
look up eugene thacker's after life
m.guardian.co.uk
mastodonC and nhs prescriptions as case study
put Cleveland's data science article into my collections and also book outline
raltmet/R/stackexchange.r at master ﺁ٧ ropensci/raltmet ﺁ٧ GitHub
read desrosiers on ca
write why the focus on classification not regression
