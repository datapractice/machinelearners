# %load_ext autoreload
# %autoreload 2


import pandas as pd
import re
import os
import matplotlib
import pickle
import datetime
import networkx as nx
import numpy as np
import operator

def load_records(dir):
	"""Return dataframe of all records, with new column of cited references as list"""

	# I saved all the WoS full records for 'machine learning'
	files =os.listdir(dir)
	df =pd.concat([pd.read_table(df, sep='\t',index_col = False) for df in [dir+f for f in files]])
	df = df.drop_duplicates()

	#fix index
	index = range(0, df.shape[0])
	df.index = index

	#to get all cited refs
	cited_refs = [set(re.split(pattern='; ', string=str(ref).lower().lstrip().rstrip())) for ref in df.CR]

	# add as column to dataframe
	df['cited_refs'] = cited_refs

	# normalise authors
	df.au = [str(au).lower().lstrip().rstrip() for au in df.AF]

	return df


def clean_topics(df):
	
	"""Wos.DE field has a mixture of topics and techniques.
	-------------------------------------
	Returns a cleaned-up, de-pluralised list version of all the topics and techniques
	"""

	df['topics'] = df.DE.dropna().str.lower().str.strip().str.replace('\(\\w+ \)', '').str.replace('($  )|(  )', ' ')
	# df.topics = df.topics.str.replace('s;', ';')
	# df.topics = df.topics.str.replace('s$', '')
	df.topics = df.topics.str.replace('svm', 'support vector machine')

	df.topics = df.topics.str.split('; ')
	return df


def manual_topic_classifier(df, existing_topic_classes, topic_counts_sorted, start = 0, count=100, ):
	
	"""Returns a dictionary with topics classified as techniques
	or not. Asks the user to classify them by hand, starting with the most frequent
	Parameters
	------------------
	count: how many to classify
	start: where in the list to start
	"""

	if existing_topic_classes is None:
		existing_topic_classes = dict()
	if topic_counts_sorted is None:
		de_all = [d for de in df.topics.dropna() for d in de]
		de_set = set(de_all)
		de_counts = {de:de_all.count(de) for de in de_set}
		topic_counts_sorted = sorted(de_counts.iteritems(), key = operator.itemgetter(1), reverse=True)
	topic_classes = {t:raw_input('\n' + t+ ' is technique? ') for t,v in topic_counts_sorted[start:start+count] if not existing_topic_classes.has_key(t)}
	existing_topic_classes.update(topic_classes)
	return existing_topic_classes


def discipline_techniques_graph(df):

	""" Constructs a bipartite graph from techniques to discipline_techniques_graph.
	It assumes that dataframe already has a cleaned up topics field.
	Preferably it has already been cut down just to techniques
	------------------------------
	Returns graph
	"""

	df['SC_l'] = df.SC.str.lower()

	tg = nx.DiGraph()
	[tg.add_edge(te, f) for t,f in zip(df.topics, df.SC_l) if t is not np.nan  for te in t]
	return tg

def trim_degrees(g, degree=1):
	g2 = g.copy()
	d = nx.degree(g2)
	[g2.remove_node(n) for n in g2.nodes() if d[n] <= degree]
	return g2

def sorted_map(map): return sorted(map.iteritems(), key=lambda (k,v): (-v,k))

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