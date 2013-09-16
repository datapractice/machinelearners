# %load_ext autoreload
# %autoreload 2


import pandas as pd
import re
import os
import networkx as nx
import numpy as np
import operator
    

def load_records(data_dir):
    """Return dataframe of all records, 
    with new column of cited references as list"""

    # I saved all the WoS full records for 'machine learning'
    files = os.listdir(data_dir)
    wos_df  = pd.concat([pd.read_table(wos_df, sep='\t', index_col = False) 
        for wos_df in [data_dir+f for f in files if f.count('.txt')>0]])
    wos_df  =  wos_df.drop_duplicates()

    #fix index
    index = range(0, wos_df.shape[0])
    wos_df.index = index

    #to get all cited refs
    cited_refs = [set(re.split(pattern='; ', 
        string=str(ref).lower().lstrip().rstrip())) for ref in wos_df.CR]

    # add as column to dataframe
    wos_df['cited_refs'] = cited_refs

    # normalise authors
    wos_df.au = [str(au).lower().lstrip().rstrip() for au in wos_df.AF]

    return wos_df


def clean_topics(wos_df):
    
    """Wos.DE field has a mixture of topics and techniques.
    -------------------------------------
    Returns a cleaned-up, de-pluralised list version of all the topics and techniques
    """

    wos_df['topics'] = wos_df.DE.dropna().str.lower().str.strip().str.replace('\(\\w+ \)', '').str.replace('($  )|(  )', ' ')
    # wos_df.topics = wos_df.topics.str.replace('s;', ';')
    # wos_df.topics = wos_df.topics.str.replace('s$', '')
    wos_df.topics  = wos_df.topics.str.replace('svm', 'support vector machine')
    wos_df.topics  = wos_df.topics.str.replace('\(support vector machine\)', 
        'support vector machine')
    wos_df.topics  = wos_df.topics.str.replace('support vector machine(\w*)', 
        'support vector machine')
    wos_df.topics = wos_df.topics.str.replace('artificial neural network', 
        'neural network')
    wos_df.topics = wos_df.topics.str.replace('neural net\b', 
        'neural network')
    wos_df.topics = wos_df.topics.str.replace('decision tree(.*)', 'decision tree')

    wos_df.topics = wos_df.topics.str.split('; ')
    return wos_df

def keyword_counts(wos_df):

    """ Returns a dictionary with keyword counts"""
    
    de_all = [d for de in wos_df.topics.dropna() for d in de]
    de_set = set(de_all)
    de_counts = {de:de_all.count(de) for de in de_set}
    return de_counts


def manual_topic_classifier(wos_df, existing_topic_classes, topic_counts_sorted, start = 0, count=100, ):
    
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
        de_all = [d for de in wos_df.topics.dropna() for d in de]
        de_set = set(de_all)
        de_counts = {de:de_all.count(de) for de in de_set}
        topic_counts_sorted = sorted(de_counts.iteritems(), 
            key = operator.itemgetter(1), reverse=True)
    topic_classes = {t:raw_input('\n' + t+ ' is technique? ')  for t, v in 
        topic_counts_sorted[start:start+count] if not existing_topic_classes.has_key(t)}
    existing_topic_classes.update(topic_classes)
    return existing_topic_classes


def coword_matrix_years(wos_df, start_year, end_year, keys):

    """

    """
    wos_df_delim = wos_df[(wos_df.PY>= start_year) & (wos_df.PY <= end_year)]
    coword_m = coword_matrix(wos_df_delim, keys)
    return coword_m

def coword_matrix(wos_df, keys):

    """ Implementation of Callon style co-word analysis of  the 
    Wos DE field -- the keywords field in the database
    
    Parameters
    ------------------------------------------------
    wos_df: the WoS literature DataFrame
    keys: keywords to use
    """

    topics = wos_df.topics
    # create document term matrix of keywords
    topics = topics.dropna()
    cow = np.zeros((len(topics), len(keys)))

    # hate doing these nested for loops but 
    #I couldn't get the list comprehensions working properly
    
    for row in range(0, len(topics)):
        top = topics.iget(row)
        hits = list()
        for topic in top:
            if keys.count(topic) >0:
                hits.append(keys.index(topic))
        cow[row, hits] = 1
    
    #to create coword matrix, use matrix dot product
    cow_m = np.dot(np.transpose(cow), cow)
    cow_wos_df = pd.DataFrame(cow_m, columns=keys, index=keys)
    return cow_wos_df

def inclusion_score(cow_wos_df, key1, key2, de_counts):
    """ Calculates  the inclusion score (conditional probability?) of key1
    given the presence of key2 (or vice versa)"""

    c_ij = cow_wos_df[key1][key2]
    I_ij = c_ij/min(de_counts[key1],  de_counts[key2])
    return I_ij

def proximity_score(cow_wos_df, key1, key2, de_counts, article_count):
    """ Calculates  the equivalence score (mutual inclusion) of key1
    given the presence of key2 (or vice versa)"""

    c_ij = cow_wos_df[key1][key2]
    p_ij = c_ij/(de_counts[key1] * de_counts[key2]) * article_count
    return p_ij

def equivalence_score(cow_wos_df, key1, key2, de_counts):
    """ Calculates  the equivalence score (mutual inclusion) of key1
    given the presence of key2 (or vice versa)"""   

    c_ij = cow_wos_df[key1][key2]
    Equiv_ij  = c_ij**2/(de_counts[key1] * de_counts[key2])
    return Equiv_ij

def equivalence_matrix(cow_wos_df, de_counts):
    """ Constructs the equivalence matrix for all combinations of key words; 
    This is following (Callon, 1991).

    Parameters
    ---------------------------------------------------------------- 
    cow_wos_df: the matrix of co-word counts
    de_counts: the list of keyword counts
    """

    keys = cow_wos_df.columns.tolist()
    key_combinations = [(k1, k2) for k1 in 
        cow_wos_df.columns for k2 in cow_wos_df.index if k1 != k2]
    ecow = np.zeros(cow_wos_df.shape)
    for key1_key2 in key_combinations:
        key1, key2 = key1_key2
        index1 = keys.index(key1)
        index2 = keys.index(key2)
        escore = equivalence_score(cow_wos_df, key1, key2, de_counts)
        ecow[index1, index2] = escore

    eqcow_wos_df = pd.DataFrame(ecow, 
        columns=cow_wos_df.columns, index = cow_wos_df.index)
    return eqcow_wos_df

def discipline_techniques_graph(wos_df):

    """ Constructs a bipartite graph from techniques 
    to discipline_techniques_graph.
    It assumes that dataframe already has a cleaned up topics field.
    Preferably it has already been cut down just to techniques
    ------------------------------
    Returns graph
    """

    wos_df['SC_l'] = wos_df.SC.str.lower()
    techn_graph = nx.DiGraph()
    [techn_graph.add_edge(te, f) for t,f in zip(wos_df.topics, wos_df.SC_l) if t is not np.nan  for te in t]
    return techn_graph

def trim_degrees(graph, degree=1):

    """ Trims all nodes with degree less than the parameter.
    Returns the trimmed graph 
    """
    graph_trimmed = graph.copy()
    degrees = nx.degree(graph_trimmed)
    [graph_trimmed.remove_node(n) for n in graph_trimmed.nodes() if degrees[n] <= degree]
    return graph_trimmed

def sorted_map(keyval): 

    """ Takes a key-value dictionary and 
    sorts it according to value counts
    Returns a list of key-value tuples
    """
    map_sorted = sorted(keyval.iteritems(), key=lambda (k, v): (-v, k))
    return map_sorted

def trim_edges(graph, weight=1):

    """ Trims all edges with degree less than the parameter.
    Returns the trimmed graph 
    """
    graph_trimmed = nx.Graph()
    [graph_trimmed.add_edge(f,to, edata) for f, to, edata in graph.edges(data=True) if edata['weight']>weight]
    return graph_trimmed

def island_method(graph, iterations=5):
    """ 
    This comes the SNA book -- a way to show only those bits of the network
    that are strongly connected

    """

    weights = [edata['weight'] for f, to, edata in graph.edges(data=True)]
    mn = int(min(weights))
    mx = int(max(weights))
    step = int((mx-mn)/iterations)
    return [[threshold, trim_edges(graph, threshold)] for threshold in range(mn, mx, step)]

def keyword_years(wos_df, keyword):

    """ Returns a DataFrame with publication years and 
    records containing the keyword
    
    Parameters
    -------------------------------
    wos_df: WoS references
    keyword: the one sought

    """
    keyword = keyword + '(s)?'
    top_py_wos_df = wos_df[['topics', 'PY', 'DE']].dropna()
    key_wos_df = top_py_wos_df[top_py_wos_df.DE.str.contains(keyword, 
        case=False)]
    return key_wos_df
