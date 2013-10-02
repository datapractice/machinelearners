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
import collections

# <markdowncell>

# ## A generative model of the machine learning literature
# 
# "Let's build a generative model of the machine learning literature" Andrew Ng, lecture on GDA and Naive Bayes
# 
# The idea of this analysis is to show how machine learning relates to various scientific and technical fields. In its treatment of the literature, it draws both on citation analysis techniques developed  in various fields, as well as text mining, social netowrk analysis and indeed machine learning itself to explore this rather large literature. 
# 
# ### Loading the literature and cleaning the topics

# <codecell>

df = ml.load_records('data/machine_learning_WOS/')
print('There are %s records in the dataset'%df.shape[0])

#clean topics
df = ml.clean_topics(df)
df = ml.clean_fields(df)

# <codecell>

print('%s topic fields are null'%sum(df.topics.isnull()))
print('%s abstract fields are null'%sum(df.AB.isnull()))
print('%s keywords Plus fields are null'%sum(df.ID.isnull()))

# <markdowncell>

# The publication years profile is typical in some ways but shows enormous growth from the late 1980s onwards. Was this around the time that artificial intelligence started to seem unpopular?

# <codecell>

df.PY.hist(bins=len(df.PY.unique()))

# <markdowncell>

# There are a lot of missing keywords (the WoS DE field). It should be possible to fill in some of the missing topic fields by using keywords from the abstracts. I'll attempt this a bit later. 

# <markdowncell>

# ## Fields of research in the literature
# 
# I downloaded from Thomson ISI Web of Science all the references returned by the query 'machine learning.' I also downloaded the cited references. 
# 
# Other possible queries such as 'data mining' return too many references to handle -- over 2 million, so I stuck with machine learning, which return aroudn 25,000 references.

# <codecell>

#actually this is more about fields than topics

all_fields = sorted([e  for el in df.fields.dropna() for e in el])
fields_set = set(all_fields)
field_counts = {e:all_fields.count(e) for e in fields_set}

# <markdowncell>

# Many different fields of research or disciplines are included in the results, and they help make sense of the multi-disciplinary nature of machine learning techniques. 

# <codecell>

print('%s different fields appear in the machine learning literature'%len(fields_set))
field_counts_s = sorted(field_counts.iteritems(), key=lambda(k,v):(-v,k))
field_counts_s[0:30]

# <markdowncell>

# The literature does reach back into the 1950s, but the real growth is in the 1990s-2000s. From 2005 onwards, several thousand publications a year appear.
# 
# We can see also the distribution of fields. Computer science totally dominates the fields. That only goes to show perhaps that machine learning is a computer science-driven set of techniques. But other fields such as automation and control systems,  biochemistry/molecular biology, management science, robotics, telecommunications and imaging science are important components. This already shows something of the wide dissemination of machine learning techniques. 

# <codecell>

#the problem is that computer science clutters everything -- get rid of it?

figure = plt.figure(figsize=(16,12))
sp1 = figure.add_subplot(1,2,2)

sp1.hist(df.PY.dropna(), bins=80, alpha=0.6, label= 'Machine Learning Publications by Year')
sp2 = figure.add_subplot(1,2,1)
#this doesn't work -- TBA
major_fields = {f:v for f,v in field_counts.iteritems() if v > 3 or f is not 'computer science'}
print(len(field_counts), len(major_fields))
heights = major_fields.values()
ind= np.arange(len(heights))
sp2.barh(ind, heights)
width =0.2
plt.title('Machine Learning Publications by Discipline')
xticks = plt.yticks(ind+width/2., major_fields.keys() )

# <markdowncell>

# ### Some network exploration could be useful for the relation between the disciplines
# 
# What disciplines connect the others up?

# <codecell>

def sorted_map(map): return sorted(map.iteritems(), key=lambda (k,v): (-v,k))

# <codecell>

df = ml.clean_fields(df)
gr_f = nx.Graph()
gr_f.add_edges_from([i for de in df.fields.dropna() for i in itertools.combinations(de,2)])

# <codecell>

core = ml.trim_degrees(gr_f, 16)
#core = ml.trim_edges(core, 3)
len(core)

plt.figure(figsize=(18,12))
plt.title('Fields and their relations in machine learning literature', fontsize=18)
nx.draw_graphviz(core, width=0.4,
                 font_size=9,
                 alpha = 0.7,
                 node_size = [s*5000 for s in nx.degree_centrality(core).values()],
                 node_color = [s for s in nx.degree(core).values()])

# <codecell>

degree_c = nx.degree_centrality(core)
degree_cs = sorted_map(degree_c)
degree_cs

# <codecell>


closeness_c = nx.closeness_centrality(core)
closeness_cs = sorted_map(closeness_c)
closeness_cs

# <codecell>

between_c = nx.betweenness_centrality(core)
between_cs = sorted_map(between_c)
between_cs

# <codecell>

eigen_c = nx.eigenvector_centrality(core)
eigen_cs = ml.sorted_map(eigen_c)
eigen_cs

# <codecell>

pr = nx.pagerank(core)
pr_s = ml.sorted_map(pr)
pr_s

# <codecell>

n1 = {x[0] for x in degree_cs[:10]}
n2 = {x[0] for x in closeness_cs[:10]}
n3 = {x[0] for x in between_cs[:10]}
n4 = {x[0] for x in eigen_cs[:10]}
n5 = {x[0] for x in pr_s[:10]}
names = n1 | n2 | n3 | n4 | n5
table =[[name, degree_c[name], closeness_c[name], between_c[name], eigen_c[name], pr[name]] for name in names]
elite_group = pd.DataFrame(data = table, columns = ['field','degree', 'closeness', 'betweenness', 'eigenvector', 'pagerank'])
elite_group = elite_group.set_index('field')
elite_group

# <codecell>

fig = plt.figure(figsize = (10,10))
#labels = elite_group['field']
#sp1=fig.add_subplot(1,4,1)
#sp1.plot(x=elite_group.field, y= elite_group.degree)
elite_group[['degree', 'closeness', 'betweenness', 'eigenvector', 'pagerank']].plot(kind='barh',  figsize=(10,10))

# <markdowncell>

# Pagerank represents a flow of trust/influence

# <codecell>

elite_group[['degree','betweenness', 'eigenvector']].plot(kind='barh')

# <markdowncell>

# Boundary spanners have low degree, high betweenness (bottlenecks or bridges) and high eigenvector centrality (actor connected to many actors who are connected). Here it looks mathematics and psychology could be playing something of these roles. Molecular biology and automation and control systems have spanning type positions too. 

# <markdowncell>

# ## Authors in ML literature
# 

# <codecell>

df.af = df.AF.dropna().str.lower().str.strip()
df.af = df.af.str.split('; ')
af_all = [d for de in df.af for d in de if d is not nan]
af_set = set(af_all)
print "There %s authors listed and unique authors number %s" % (len(af_all), len(af_set))
af_counts = {de:af_all.count(de) for de in af_set}
af_counts_sorted = sorted(af_counts.iteritems(), key = operator.itemgetter(1), reverse=True)
af_counts_sorted[0:50]

# <codecell>

# these still need cleaning -- can see some duplicates
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
#    - Ross King works on synthetic biology and proteins, and in particular, the automation of science using AI

# <markdowncell>

# ## Who has been cited most in the machine learning literature?
# 
# Within the machine learning references, we can look just at the times cited field provided by Web of Science.  It seems that Breiman's RandomForests paper is the most important, followed by a wireless paper, then two papers in ecology, a methods paper, then the newer technique of Gaussian processes, followed by a text categorisation paper, then molecular biology paper, then three more methods papers, followed by some face detection articles and cancer-related papers. 

# <codecell>

df[['AU', 'TI', 'TC', 'PY', 'ID', 'DE']][df.TC>500].sort('TC', ascending=False)

# <codecell>

df.ix[df.TC.idxmax(), 51:]

# <markdowncell>

# But this doesn't say who has been cited most  in the literature. There are around 350,000 unique references cited in these papers, amongst 650,000 total citations. 

# <codecell>

all_refs = [ref for refs in df.cited_refs for ref in refs]
ref_collection = collections.Counter(all_refs)
ref_collection.most_common(n=20)

# <codecell>


sq =gs.ScholarQuerier(author = 'Ross J Quinlan', count=50)
sq.query('')
print(ml.sorted_map({a['title']:a['num_citations'] for a in sq.articles}))
{a['title']:a['url'] for a in sq.articles}

# <markdowncell>

# ## The techniques and topics in the literature
# 
# This relies on the 'DE' in the Web of Science records

# <codecell>

# topics seem to be in the DE field


de_all = [d for de in df.topics.dropna() for d in de]

de_set = set(de_all)
print "All topics has %s and unique topics number %s" % (len(de_all), len(de_set))

# <codecell>

de_counts = {de:de_all.count(de) for de in de_set}

# <markdowncell>

# The problem is that the topics mix techniques and application: principal component analysis stands alongside face recognition. So we need to sort those out first.
# I've only considered a manual way to do this. 

# <codecell>

# to see how topics are distributed

de_counts_sorted = sorted(de_counts.iteritems(), key = operator.itemgetter(1), reverse=True)
de_counts_sorted[0:50]

# <markdowncell>

# The most frequent ones are techniques, but there are also lots of applications here - text classification, computer vision, intrusion detection, etc. To sort out the techniques, I classified by the hand the top 1000

# <codecell>

techniques_domains = pickle.load(open('technique_classification.pyd', 'r'))

# <codecell>

tech_s = sorted([tech for tech, cl in techniques_domains.iteritems() if cl == 'y'])

print(len(tech_s))
tech_cleaned = [re.sub('\(.+\)', '',t) for t in tech_s]

tech_cleaned[:30]
tech_cleaned.remove('artificial intelligence')
tech_cleaned.remove('machine learning')
tech_cleaned.remove('data mining')
tech_cleaned.remove('pattern recognition')

print('Number of different techniques in the literature: %d'%len(set(tech_cleaned)))
tech_cleaned[0:30]
#tech_cleaned.count('decision tree')

# <markdowncell>

# ### Domains
# 
# If techniques are removed, we are left with domains

# <codecell>

domains = sorted([tech for tech, cl in techniques_domains.iteritems() if cl == 'n'])
domains[:40]

# <markdowncell>

# # A network of techniques
# 
# The idea here is to see how techniques are connected to each other. There are roughly 500 techniques across 23000 references. Some of these references have multiple techniques. Not all techniques are techniques. Some name problems. So as well as removing domains, we need to remove problems. 

# <codecell>

# classify references by techniques
tech_gr = nx.DiGraph()

#construct technique edge list 

# find techniques in a reference and add co-present techniques
# as edges to graph

tech_cleaned.append('nn classifier')
for topics in df.topics.dropna():
    techs = [t for t in topics if tech_cleaned.count(t) > 0]
    edges = [c for c in itertools.combinations(techs,2)]
    for subject_id, object_id in edges:
        if tech_gr.has_edge(subject_id, object_id):
            tech_gr[subject_id][object_id]['weight'] += 1
        else:
            tech_gr.add_edge(subject_id, object_id, weight=1)

tech_gr.size()    

# <codecell>

tech_core = ml.trim_degrees(tech_gr,13 )
tech_core= ml.trim_edges(tech_core, 10)
print tech_core.size()

nx.draw_spring(tech_core, k=0.4,width = 0.2,alph=0.5, figsize=(10,10))

# <codecell>

tech_degree_c = nx.degree_centrality(tech_core)
tech_degree_cs = ml.sorted_map(tech_degree_c)
tech_degree_cs[:10]

# <codecell>

tech_closeness_c = nx.closeness_centrality(tech_core)
tech_closeness_cs = sorted_map(tech_closeness_c)
tech_closeness_cs[:10]

# <codecell>

tech_between_c = nx.betweenness_centrality(tech_core)
tech_between_cs = sorted_map(tech_between_c)
tech_between_cs[:10]

# <codecell>

tech_eigen_c = nx.eigenvector_centrality(tech_core)
tech_eigen_cs = sorted_map(tech_eigen_c)
tech_eigen_cs[:10]

# <codecell>

tech_pr = nx.pagerank(tech_core)
tech_pr_s = sorted_map(tech_pr)

# <codecell>

n1 = {x[0] for x in tech_degree_cs[:10]}
n2 = {x[0] for x in tech_closeness_cs[:10]}
n3 = {x[0] for x in tech_between_cs[:10]}
n4 = {x[0] for x in tech_eigen_cs[:10]}
n5 = {x[0] for x in tech_pr_s[:10]}
names = n1 | n2 | n3 | n4 | n5
table =[[name, tech_degree_c[name], tech_closeness_c[name], tech_between_c[name], tech_eigen_c[name], tech_pr[name]] for name in names]
tech_group = pd.DataFrame(data = table, columns = ['technique','degree', 'closeness', 'betweenness', 'eigenvector', 'pagerank'])
tech_group = tech_group.set_index('technique')
tech_group

# <codecell>

tech_group[['degree', 'betweenness', 'closeness', 'eigenvector', 'pagerank']].plot(kind='barh',figsize=(10,10))

# <markdowncell>

# The highest degree centralities are machine learning, classification, support vector machine and data-mining. There is a bit of mixture here - machine learning or data mining are whole areas of technique, whereas support bector machine or neural network are particular techniques. If these were taken out, the network starts to look at bit different. Also some techniques are almost synonous -- feature selection and feature extraction are almost the same thing. If they were added together, their closeness centrality would be greater than many of the others. 
# 
# It is really striking how important support vector machines, as well as neural networks and decision trees. They figure heavily.
# 
# Classification is really important -- it is second to machine learning on most measures of centrality. 
# 
# In terms of boundary spanning, it seems that feature extraction, feature selection suddenly figure more in the eigenvector measure -- does that mean that they are linking different subgraphs more?
# 
#  

# <markdowncell>

# ## Cliques and clusters in the techniques
# 

# <codecell>

print(len(tech_gr))
len(nx.connected_component_subgraphs(tech_gr.to_undirected()))

# <markdowncell>

# As it looks from above, this is one hairball of a graph of techniques

# <codecell>

svm = nx.ego_graph(tech_gr.to_undirected(), 'support vector machine', radius=2)
nx.average_clustering(svm)

# <codecell>

neural = nx.ego_graph(tech_gr.to_undirected(), 'neural network', radius=2)
print(len(neural))
nx.average_clustering(neural)

# <markdowncell>

# ### Trim the edges based on weights

# <codecell>

def trim_edges(g, weight=1):
    g2 = nx.Graph()
    [g2.add_edge(f,to, edata) for f, to, edata in g.edges(data=True) if edata['weight']>weight]
    return g2

def island_method(g, iterations=5):
    weights = [edata['weight'] for f, to, edata in g.edges(data=True)]
    mn = int(min(weights))
    mx = int(max(weights))
    step = int((mx-mn)/iterations)
    return [[threshold, trim_edges(g, threshold)] for threshold in range(mn,mx,step)]

# <codecell>

islands = island_method(tech_gr)
len(islands)
for i in islands:
    print i[0], len(i[1]), len(nx.connected_component_subgraphs(i[1]))

# <codecell>

l = nx.fruchterman_reingold_layout(islands[1][1], k=0.4)
nx.draw_spring(islands[1][1], layout = l, alpha=0.7)

# <codecell>

nx.draw_spring(islands[2][1], k=0.3,alpha=0.7)

# <markdowncell>

# This is produced used the island method of splitting giant components in to smaller areas of stronger relationality. In this case, there are only two connected subgraphs, so it is not possible to raise the water level much. 
# 
# No real surprises here, but it is interesting that pattern recognition survives alongside classification and feature selection. As usual, the only 2 techniques are neural network and support vector machine. It would be interesting perhaps to see what happens if take the fields such as data mining and artificial intelligence out. 

# <codecell>

len(nx.connected_component_subgraphs(tech_gr.to_undirected()))

# <codecell>

tech_trimmed = trim_edges(tech_gr,1)
len(tech_trimmed)
gs=nx.connected_component_subgraphs(tech_trimmed)
gs[0].size()
tech_gr.size()
sorted(tech_gr.edges(data=True))

# <codecell>

classi =nx.ego_graph(tech_trimmed, 'logistic regression')
classi.size()

# <codecell>

layout = nx.fruchterman_reingold_layout(classi, k=0.5, weight= 'weight')
nx.draw(classi, layout, figsize(10,10))

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
print(ftdf.shape)
ftdf.head()

# <codecell>

gr = nx.Graph()

#[i for i in itertools.combinations(de, 2) for de in df.topics[:100]]
gr.add_edges_from([i for de in df.topics.dropna()[0:200] for i in itertools.combinations(de,2)])

# <codecell>

gr2 = nx.Graph()
[gr2.add_edge(f[0],t[0]) for f,t in zip(ftdf.fields, ftdf.topics) if f is not NaN and t is not NaN]
gr2.size()

# <codecell>

print('topics network has %s edges and %s nodes'%(gr.number_of_edges(), gr.number_of_nodes()))
nx.average_degree_connectivity(gr)
#nx.draw_networkx(gr)

# <codecell>

gr.remove_node('machine learning')

# <codecell>

deg=nx.degree(gr)

# <codecell>

deg['support vector machine']
deg_sorted = sorted(deg.iteritems(), key=lambda(k,v):(-v,k))
deg_sorted[:50]

# <codecell>

h=hist(deg.values(), 100)
loglog(h[1][1:], h[0])

# <codecell>

#remove 1-degree nodes

g2 = gr.copy()
d = nx.degree(g2)
remove = 10
[g2.remove_node(n) for n in g2.nodes() if d[n] <= remove]
print g2.size()

nsizes = [n*10 for n in d.values() if n >remove]

# <codecell>

f = plt.figure(figsize=(10,10))

nx.draw_graphviz(g2, alpha=0.6, k=0.6,node_sizes = nsizes)

# <markdowncell>

# # 2 mode networks: disciplines and techniques

# <codecell>

from networkx.algorithms import bipartite as bi

# <codecell>

tx = ml.discipline_techniques_graph(df)

# <codecell>

tx.size()
disciplines = df.SC_l.unique()
techniques = {det  for de in df.topics if de is not nan for det in de}

# <codecell>

df.SC_l

# <codecell>

len(techniques)

# <codecell>

disc = bi.projected_graph(tx, g2.nodes())

# <codecell>

sorted(disc.degree().iteritems(), key= operator.itemgetter(1))

# <markdowncell>

# ## Retrieving further literature if needed from WoS

# <codecell>

## generate searches that can be run back against WoS - it says it will take up to 5000 terms!

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

df.NR.hist(bins=200)

# <markdowncell>

# # Keywords of interest

# <codecell>

plt.figure(figsize=(14,6))

key1 = 'generalization'
k1 = ml.keyword_years(df, key1)
plt.subplot(141)
plt.hist(k1.PY, bins=20)
plt.title(key1)

key2 = 'error'
k2 = ml.keyword_years(df, key2)
plt.subplot(142)
plt.hist(k2.PY, bins=20)
plt.title(key2)

key3 = 'bootstrap'
k3 = ml.keyword_years(df, key3)
plt.subplot(143)
plt.hist(k3.PY, bins=20)
plt.title(key3)

key4 = 'bagging'
k4 = ml.keyword_years(df, key4)
plt.subplot(144)
plt.hist(k4.PY, bins=20)
plt.title(key4)

