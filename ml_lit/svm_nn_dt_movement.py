# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

%load_ext autoreload
%autoreload 2

# <codecell>

import ml_lit_anal as ml
import re
import nltk
import pickle
import operator
import google_scholar_parser as gs
import pandas as pd
import networkx as nx
import itertools
import matplotlib.pyplot as plt
import numpy as np

# <codecell>

df = ml.load_records('data/machine_learning_WOS/')
print('There are %s records in the dataset'%df.shape[0])

#clean topics
df = ml.clean_topics(df)

# <markdowncell>

# # Analysis of decision tree, random forest, neural network and support vector machine 
# 
# The 'motivating intuition' here is that every major technique entails a manner of movement, handling and shaping of data _and_ this manner of movement affects how the technique itself travels or moves around. 

# <codecell>

# loads my handcurated list of techniques
techniques_domains = pickle.load(open('technique_classification.pyd', 'r'))

# <markdowncell>

# ## Decision tree analysis
# 
# Hopefully I can do the analysis for decision trees, then just automate it for all the other techniques.
# 
# First of all, just check how they fit with related terms:

# <codecell>

# get the records that keyword decision tree
dt = ml.keyword_years(df, 'decision tree')
print('decision tree: %d'%dt.shape[0])
## get the records that keyword CART
cart = ml.keyword_years(df, 'cart|classification and regression tree')
print('CART: %d'%cart.shape[0])
# get the records that keyword C4.5
c45 = ml.keyword_years(df, 'C4.5')
print('C4.5: %d'%c45.shape[0])

# <codecell>

#the intersection between these?
indexes = set(dt.index)
indexes.intersection(cart.index)
# very little intersection it seems

# <markdowncell>

# Seems like only a few records overlap.
# 
# ## How do decision tree topics appear over time?
# 

# <codecell>

fig=plt.figure(figsize=(10,10))
plt.hist(dt.PY, bins=20, alpha=0.4)
plt.hist(cart.PY, bins=20)
plt.title('Decision tree papers in machine learning literature')
plt.show()
df.PY.hist(bins=len(df.PY.unique()))

# <markdowncell>

# This doesn't mean that there were no decision tree papers before 1990. They have been around longer, but were not presented as part of machine learning until then. And indeed the machine learning literature in general does not take shape until around then. (See the second plot).
# 
# So, did a WoS search just on decision trees and save the 3000 top-cited references. There were around 10,000 returned.  The problem with this search is that it is hard to know whether the decision tree is actually a software or algorithmic decision tree. That is, it might be a medical decision tree. 

# <codecell>

dec_tree_df = ml.load_records('data/decision_tree_WOS/')

# <codecell>

dec_tree_df.PY.hist(bins=dec_tree_df.PY.max()-dec_tree_df.PY.min())

# <markdowncell>

# OK, this gives a different picture. Now the decision trees are much more numerous, and they span 1965 onwards. They were not developing only in the machine learning literature. They were going elsewhere.

# <codecell>

dec_tree_df[['TI','PY', 'AF', 'TC']][(dec_tree_df.PY<1986) & (dec_tree_df.PY>=1977)]

# <markdowncell>

# Still problems here. Important people like Friedman and Breiman don't appear here. Why not? How are they keyworded? Not by decision tree it seems.
# 
# Might be worth tracking in by different routes. 
# 
# 1. The Morgan-Sonquist citations -- who cited them?
# 2. The Cover-Hart nearest neighbour work -- how does it allow the technique to be renovated?

# <codecell>

morgan_df = ml.load_records('data/morgan_sonquist_WOS/')
plt.hist(morgan_df.PY, bins=morgan_df.PY.max()-morgan_df.PY.min())
plt.title('Citations of Morgan and Sonquist 1963')

# <codecell>

cover_df = ml.load_records('data/cover_hart_WOS/')
plt.hist(cover_df.PY, bins=cover_df.PY.max()-cover_df.PY.min())
plt.title('Citation of Cover-Hart, 1967')

# <markdowncell>

# Both Morgan-Sonquist and Cover-Hart show a huge increase in the last decade or so. It would be interesting to see how they intersect.

# <markdowncell>

# I'd like to see what was happening with the topics and applications of decision trees between 1990-2012. Maybe this is already too late, given that the work on decision trees had been done much earlier. But it is a starting point.

# <codecell>

# get all the techniques from my list of techniques 
techniques = [key for key, value in techniques_domains.iteritems() if value == 'y']

# find all the domains/topics in the list of decision tree topics that are not techniques
dt_topics = df.topics.ix[dt.index]

def remove_techniques(x):
    return [top for top in x if top not in techniques]
dt_topics = dt_topics.apply(remove_techniques)
dt_df = df.ix[dt_topics.index].groupby(df['PY'])
dt_df


# <codecell>

dt_df.head(5)

