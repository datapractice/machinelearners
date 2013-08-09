# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

%load_ext autoreload
%autoreload 2
import ml_lit_anal as ml
import re
import nltk
import pickle
import operator
import google_scholar_parser as gs
import pandas as pd
import networkx as nx
import itertools

# <markdowncell>

# ## A generative model of the machine learning literature
# 
# Let's build a generative model of the machine learning literature. 

# <markdowncell>

# ## Fields of research in the literature
# 
# Obviously dominated by computer science, but how does it move ouf that?

# <codecell>

df = ml.load_records('data/')
df.shape

#actually this is more about fields than topics
df['fields'] = df.SC.dropna().str.lower().str.split('; ')

all_fields = sorted([e  for el in df.fields.dropna() for e in el])
fields_set = set(all_fields)
field_counts = {e:all_fields.count(e) for e in fields_set}

# <codecell>

print('%s different fields'%len(fields_set))
field_counts

# <codecell>

#the problem is that computer science clutters everything -- get rid of it?

print df.field.value_counts().order(ascending=False)[0:20]

# <codecell>

topics_sans = topics.str.replace('(computer science; ?)|(engineering; ?)', '')
topics_sans = topics_sans.map(lambda x: re.split('; ', str(x))[0])
topics_sans.value_counts()


print topics_sans.value_counts()[0:50]
print(len(df.TI[(df.AB.str.contains(pat = 'supervised|unsupervise', case=False, na=False))]))
#print(df.TI[(df.AB.str.contains(pat = 'supervised|unsupervise', case=False, na=False))])
figure(figsize=(10,10))
subplot(1,2,2)

hist(df.PY, bins=100, alpha=0.6, label= 'Machine Learning Publications by Year')
subplot(1,2,1)
topics_sans.value_counts()[0:20].plot(kind='barh', alpha=0.5, grid=False)

# <markdowncell>

# ## Authors in ML literature
# 

# <codecell>

df.af = df.AF.dropna().str.lower().str.strip()
df.af = df.af.str.split('; ')
af_all = [d for de in df.af for d in de if d is not nan]
af_set = set(af_all)
print "There %s authors listed and unique authors number %s" % (len(af_all), len(af_set))

# <codecell>

af_counts = {de:af_all.count(de) for de in af_set}

# <codecell>

af_counts_sorted = sorted(af_counts.iteritems(), key = operator.itemgetter(1), reverse=True)
af_counts_sorted[0:50]

# these still need cleaning -- can see some duplicates

# <codecell>

#To check out some of these

sq =gs.ScholarQuerier(author = 'Ross D King', count=50)
sq.query('')
print({a['title']:a['num_citations'] for a in sq.articles})
{a['title']:a['url'] for a in sq.articles}

# <markdowncell>

# There are some interesting differences here:
# 
#    -  Klaus Mueller works on medical decisions
#    -  dzeroski works on induction
#    -  zhou, zhi-hua at nanjing works on facial recognition
#    - Ross King works on synthetic biology and proteins

# <markdowncell>

# ## The techniques and topics in the literature
# 
# This relies on the 'DE' in the Web of Science records

# <codecell>

# topics seem to be in the DE field
df['topics'] = df.DE.dropna().str.lower().str.strip()
df.topics = df.topics.str.replace('s;', ';')
df.topics = df.topics.str.replace('s$', '')
df.topics = df.topics.str.replace('svm', 'support vector machine')
df.topics = df.topics.str.split('; ')

de_all = [d for de in df.topics.dropna() for d in de]
# need to clean out plurals
de_set = set(de_all)
print "All topics has %s and unique topics number %s" % (len(de_all), len(de_set))

# <codecell>

de_counts = {de:de_all.count(de) for de in de_set}

# <codecell>

# to see how topics are distributed

de_counts_sorted = sorted(de_counts.iteritems(), key = operator.itemgetter(1), reverse=True)
de_counts_sorted[0:50]

# <markdowncell>

# # Linking fields and topics
# 
# Can we link topics to fields?
# 
# ## Idea A: use networks
# 
# 1. clean up fields so each publication has the most distinctive fields - remove 'computer science'
# 2. clean up topics so that each publication has the most distinctive topics -- remove 'machine learning'
# 3. create bimodal network of fields & topics?
# 
# ## Idea B: use association/correlations

# <codecell>

# to create distinctive topics, drop machine learning
ftdf = df[['fields', 'topics']]
ftdf.head()

# <codecell>

gr = nx.DiGraph()
gr.add_nodes_from(de_set)
gr.number_of_nodes()
#[i for i in itertools.combinations(de, 2) for de in df.topics[:100]]
gr.add_edges_from([i for de in df.topics.dropna()[0:200] for i in itertools.combinations(de,2)])

# <codecell>

gr.number_of_edges()
nx.average_degree_connectivity(gr)
#nx.draw_networkx(gr)

# <codecell>

gr.remove_node('machine learning')

# <codecell>

deg=nx.degree(gr)

# <codecell>

deg['support vector machine']
deg_sorted = sorted(deg.iteritems(), key=lambda(k,v):(-v,k))
deg.values()[:50]

# <codecell>

deg_sorted[0:10]

# <codecell>

h=hist(deg.values(), 100)
loglog(h[1][1:], h[0])

# <codecell>

#remove 1-degree nodes

g2 = gr.copy()
d = nx.degree(g2)
remove = 10
[g2.remove_node(n) for n in g2.nodes() if d[n] <= remove]
g2.size()

# <codecell>

figure(figsize=(10,10))

nx.draw_networkx(g2, alpha=0.8)
nx.

# <markdowncell>

# ## Retrieving further literature if needed from WoS

# <codecell>


# <codecell>


# <codecell>


# <codecell>


# <codecell>

## generate searches that can be run back against WoS

'"'+'" or "'.join([de for de,val in de_counts_sorted if val > 90 and val < 200]) + '"'

# <markdowncell>

# ## Building a topic model

# <codecell>

# <markdowncell>

# # The corpus of ML

# <codecell>

ti_ab = df.TI + df.AB
mlt = nltk.TextCollection([nltk.tokenize.word_tokenize(t) for t in ti_ab.dropna()])

# <markdowncell>
mlt.tokens[0:20]

# <markdowncell>

# ## The cited references

# <codecell>

df.NR.value_counts()

