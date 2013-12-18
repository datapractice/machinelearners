flach_machine_2012
The key question in machine learning is how to model the relationship between $X$ and $Y$. The statistician's approach is to assume that there is some underlying random proecess that generates the values for these variables, according to a well-defined but unknown probability distribution. We want to use the data to find out more about this distribution. 25

Likelihood function $P(X|Y)$ - the probability of an event we know has occurred ($X$), conditioned on somethign we don't know anything about ($Y$) 27

the Likelihood function plays an important role in statistical machine learning. It establishes what is called a _generative model_: a probabilistic model from which we can sample values of all variables involved. 29

_marginal Likelihoods_ 29

One might call the independence assumption that allows us to decompose joint likelihoods into a product of marginal likelihoods 'naive' -- which is exactly what machine learners do when they refer to this simplified Bayesian classifier as _naive Bayes_. 30 

We have some idea what a probabilistic model looks like, but how do we learn such a model? In many case this will be a matter of estimating the model parameters from data, which is usually achieved by straightforward counting.30                         

Discriminative probabilistic models: they model the posterior probability distribution $P(Y|X)$, where $Y$ is the target variable and $X$ are the features. Thatis, given $X$ they return a probability distribution over $Y$
The other main class of probabilistic models are called _generative_ models. They model the joint distribution $P(X,Y)$ of the target $Y$ and the feature vector $X$. Once we have access to this joint distribution we can derive any conditional or marginal distribution involving the same variables. 262

Such models are called 'generative' because we can sample from the joint distribution to obtain new data points together with their labels. 263

The key point is that _probabilities do not have to be interpreted as estimates of relative frequencies, but can carry the more general meaning of (possibly subject) degrees of belief. 265
