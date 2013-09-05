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

df = ml.load_records('data/')
print('There are %s records in the dataset'%df.shape[0])

#clean topics
df = ml.clean_topics(df)

# <markdowncell>

# # Co-word analysis of the machine learning literature
# 

# <codecell>

#choose the set of keywords to use
de_all = [d for de in df.topics.dropna() for d in de]
de_set = set(de_all)
de_counts = {de:de_all.count(de) for de in de_set}
	#de_counts_sorted = sorted(de_counts.iteritems(), key = operator.itemgetter(1), reverse=True)

# <codecell>

	# choose top 500 keywords
keys = [t[0] for t in de_counts.items() if t[1] > 10]
print('there are %s keywords' % len(keys))

# <codecell>

# construct the coword matrix by counting how often keywords appear with each other
cow_df = ml.coword_matrix(df,keys)

# <markdowncell>

# For co-word analysis, calculate a matrix of equivalence scores and look for largest values. I'm drawing on Callon M, Courtial JP and Laville F (1991) Co-word analysis as a tool for describing the network of interactions between basic and technological research: The case of polymer chemsitry. Scientometrics, 22(1), 155–205 for this. 
# 
# They write:
# 
# > The calculation of all coefficients between all possible word pairs (even if the
# value of these coefficients is often equal to zero) generates a considerable number of
# links - far too many to able to represent graphically. This is why we have developed
# algorithms for generating sub-groups that can be more easily visualized and
# interpreted. 161
# 
# Much of their method is devoted to better ways of dealing with the proliferation of links. I'm not sure we have the same problem today, because of machine learning. 

# <codecell>

eqcow_df = ml.equivalence_matrix(cow_df, de_counts)
eq2 = eqcow_df.unstack().copy()
eq2.sort(ascending=False)
eq2[:100:2]

# <codecell>

eq2.hist(bins=500)

# <markdowncell>

# Classic coword analysis looks for clusters using thresholds. 

# <codecell>

eqnx = nx.from_numpy_matrix(eqcow_df.as_matrix())

# <codecell>

eqnx.number_of_nodes()
nx.draw_spring(eqnx)

# <markdowncell>

# ## Development analysis
# 
# The problem is that I'm keeping 25 years of research together. There is no chance of looking at development, or seeing relationships. 
# Before 1990, there are very few machine learning papers (less than 100). So the first snapshot could be 1990

# <codecell>

df_pre = df[df.PY <=1990]
print('There are %s papers by the end of 1990'%df_pre.shape[0])

# <codecell>


ml.keyword_counts(df_pre)

# <markdowncell>

# The problem is that most of the literature before 1990 have no keywords. They were not keyworded by anyone. 

# <codecell>

print('The number of pre-1990 references that have keyword: %s'%df_pre.topics.count())

# <markdowncell>

# How do things go after 1990?

# <codecell>

df_pre2 = df[(df.PY <= 1995) & (df.PY >1990)]
keys_90_95 = ml.keyword_counts(df_pre2)
print('There are %s keywords in the 1990-95 literature' % len(keys_90_95))

# <codecell>

cow_df2 = ml.coword_matrix(df_pre2,keys_90_95.keys())

# <codecell>

cow_df2.ix[1]

# <codecell>

eqcow_df2 = ml.equivalence_matrix(cow_df2, keys_90_95)
eq23 = eqcow_df2.unstack().copy()
eq23.sort(ascending=False)
eq23[:100:2]

# <markdowncell>

# TBC: look at the development of keywords over later years

# <codecell>


