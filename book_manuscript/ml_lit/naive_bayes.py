# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <markdowncell>

# # From Naive Bayes to ...

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
import graph_tool.all as gt
import itertools
import matplotlib.pyplot as plt
import numpy as np
import collections
import IPython.display
import seaborn
import ggplot

# <markdowncell>

# ## Loading the WoScience records
# 
# I downloaded from Thomson ISI Web of Science all the references returned by the query 'naive bayes.' I also downloaded the cited references. 
# 

# <codecell>

df = ml.load_records('data/naive_bayes_WOS/')
print('There are %s records in the dataset'%df.shape[0])

#clean topics
df = ml.clean_topics(df)
df = ml.clean_fields(df)

# <codecell>

print('%s topic fields are null'%sum(df.topics.isnull()))
print('%s abstract fields are null'%sum(df.AB.isnull()))
print('%s keywords Plus fields are null'%sum(df.ID.isnull()))
print('%s author fields are null'%sum(df.AF.isnull()))

# <codecell>

plt.figure(figsize=(8,4))
plt.title('Naive Bayes (Web of Science)')

df.PY.hist(bins=len(df.PY.unique()), color='g')
plt.box(on=False)

# <markdowncell>

# ## Fields of research in the 'naive bayes' literature

# <codecell>

all_fields = sorted([e  for el in df.fields.dropna() for e in el])
fields_set = set(all_fields)
field_counts = {e:all_fields.count(e) for e in fields_set}
print('%s different fields appear in the naive bayes literature'%len(fields_set))
field_counts_s = sorted(field_counts.iteritems(), key=lambda(k,v):(-v,k))
field_counts_s[0:30]

# <codecell>

## Citation practices

# <codecell>

df[['AU', 'TI', 'TC', 'PY', 'ID', 'DE']][df.TC>200].sort('TC', ascending=False)

# <markdowncell>

# ### Who has been cited most in the references cited by the naive bayes literature?

# <codecell>

all_refs = [ref for refs in df.cited_refs for ref in refs]
ref_collection = collections.Counter(all_refs)
ref_collection.most_common(n=50)

