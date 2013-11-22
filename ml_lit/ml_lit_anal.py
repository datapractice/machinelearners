# %load_ext autoreload
# %autoreload 2

import pandas as pd
import re
import os
import networkx as nx
import numpy as np
import operator
import collections
import math
import itertools
import matplotlib.pyplot as plt
import requests
from lxml import etree
import graph_tool.all as gt
import sqlite3


def load_records(data_dir):
    """Return dataframe of all records,
    with new column of cited references as list"""

    # I saved all the WoS full records for the search term in this directory
    files = os.listdir(data_dir)
    wos_df = pd.concat([pd.read_table(wos_df, sep='\t', index_col=False)
                        for wos_df in [data_dir+f for f in files
                        if f.count('.txt') > 0]])
    wos_df = wos_df.drop_duplicates()

    #fix index
    index = range(0, wos_df.shape[0])
    wos_df.index = index

    #to get all cited refs
    if wos_df.columns.tolist().count('CR') > 0:
        cited_refs = [list(re.split(pattern='; ',
                                    string=str(ref).lower().lstrip().rstrip()))
                                    for ref in wos_df.CR]
        # add as column to dataframe
        wos_df['cited_refs'] = cited_refs

    # normalise authors
    if wos_df.columns.tolist().count('AF') > 0:
        wos_df.au = [str(au).lower().lstrip().rstrip() for au in wos_df.AF]

    return wos_df


def clean_fields(wos_df):

    """ Returns dataframe with a new field 'field' that lists
    the fields for each reference"""

    wos_df['fields'] = wos_df.SC.dropna().str.lower().str.split('; ')
    return wos_df


def clean_topics(wos_df):
    """Wos.DE field has a mixture of topics and techniques.
    -------------------------------------
    Returns a cleaned-up, de-pluralised list version of all the topics and techniques
    """

    wos_df['topics'] = wos_df.DE.dropna().str.lower().str.strip().str.replace('\(\w+ \)', '').str.replace('($  )|(  )', ' ')
    # wos_df['topics'] = wos_df.topics.str.replace("[\(\](\w+ ?)+[\)\]]\W*",  '')
    wos_df.topics = wos_df.topics.str.replace('svm', 'support vector machine')
    wos_df.topics = wos_df.topics.str.replace('support vector machine(\w*)',
                                            'support vector machine')
    wos_df.topics = wos_df.topics.str.replace('(artificial neural network)|(neural networks)|(neural net\b)',
                                            'neural network')
    wos_df.topics = wos_df.topics.str.replace('decision tree(.*)', 'decision tree')
    wos_df.topics = wos_df.topics.str.replace('random forest(\w+)', 'random forest')
    # Web of science topics often have  a bracket expansion
    wos_df['topics'] = wos_df.topics.str.replace("(\w+)\W*[\[\(].+[\)\]]\W*", '\\1 ')
    wos_df.topics = wos_df.topics.str.split('; ')
    return wos_df


def impute_topics(df):
    """ TBA: Many wos records have no topics -- especially for older papers.
    Construct possible topics by matching title
    words to the overall list of topics.
    Returns
    --------------------------
    df: with all topics fields having some value
    """

    de_all = [d for de in df.topics.dropna() for d in de]
    de_counts = collections.Counter(de_all)
    return de_counts


def keyword_counts(wos_df):
    """ Returns a dictionary with keyword counts"""
    de_all = [d for de in wos_df.topics.dropna() for d in de]
    key_counts = collections.Counter(de_all)
    return key_counts


def citation_counts(wos_df):
    """Returns a dictionary with citations in the cited references counted"""
    all_refs = [ref for refs in wos_df.cited_refs for ref in refs]
    ref_collection = collections.Counter(all_refs)
    return ref_collection


def manual_topic_classifier(wos_df, existing_topic_classes=None, 
                            topic_counts_sorted=None, start = 0, count=100):
    """Returns a dictionary with topics classified as techniques
    or not. Asks the user to classify them by hand,
    starting with the most frequent.

    Parameters
    ------------------
    existing_topic_classes: topics that have already done
    count: how many to classify
    start: where in the list to start
    """

    if existing_topic_classes is None:
        existing_topic_classes = dict()
    if topic_counts_sorted is None:
        topic_counts_sorted = keyword_counts(wos_df)
        de_all = [d for de in wos_df.topics.dropna() for d in de]
        de_set = set(de_all)
        de_counts = {de: de_all.count(de) for de in de_set}
        topic_counts_sorted = sorted(de_counts.iteritems(),
                                                    key=operator.itemgetter(1), reverse=True)
    topic_classes = {t:raw_input('\n' + t+ ' is technique(t)/material(m)/field(f)/organism(o)/application(a)/biological process(b)? ')  for t, v in 
        topic_counts_sorted[start:start+count] if t not  in existing_topic_classes.keys()}
    existing_topic_classes.update(topic_classes)
    return existing_topic_classes

"""
Coword analysis functions
"""


def coword_matrix_years(wos_df, start_year, end_year, keys):
    """
    Return the coword matrix for a year range for the given set of keys

    Parameters
    ---------------------------------
    wos_df: references dataframe
    start_year: include references starting from this year
    end_year: references up to but including this year
    keys: list of keys to include in the matrix

    """
    wos_df_delim = wos_df[(wos_df.PY>= start_year) & (wos_df.PY<end_year)]
    coword_m = coword_matrix(wos_df_delim, keys)
    return coword_m


def coword_matrix(wos_df, keys):

    """ Implementation of Callon style co-word analysis of  the keywords field
    
    Parameters
    ------------------------------------------------
    wos_df: the  literature DataFrame -- doesn't need to be WoS, as long as it has the right fields
    keys: list of keys to count
    """

    # create reference-topic matrix
    topics = wos_df.topics
    #drop references that have no topics
    topics = topics.dropna()
    doc_count = len(topics)
    dropped_count  =  wos_df.shape[0] - doc_count
    dtm = np.zeros((doc_count, len(keys)))
    print('Dropped %s document of the total %s because they had no topic field'
                        %(dropped_count, wos_df.shape[0]))

    #nested loops here but
    #I couldn't get the list comprehensions working properly
    
    for row in range(0, doc_count):
        top = topics.iget(row)
        for topic in top:
            if keys.count(topic) > 0:
                # set all the topics found for this reference to 1
                dtm[row, keys.index(topic)] = 1

    #to create coword matrix, use matrix dot product
    cow_m = np.dot(np.transpose(dtm), dtm)
    #the diagonal should be zero!
    np.fill_diagonal(cow_m, 0)
    cow_wos_df = pd.DataFrame(cow_m, columns=keys, index=keys)
    return cow_wos_df


def coword_network(mesh_df, start, end,topic_count=0): 
        """
        constructs a coword network for the years supplied;
        nodes will be labelled by topic, have a 'weight' of co-occurrence,
        a 'start_year' attribute,
        and an 'end_year' attribute which is the end year of the search
        
        Parameters
        ----------------
        mesh_df: a dataframe with at least the topics and years columns
        start: start year
        end: end year
        topic_count: the number of the topics to use
        (not too big, otherwise coword matrix will be huge
        """

        # determine the number of topics to count
        all_topics = [t for top in mesh_df.topics.dropna() for t in top]
        topic_collection = collections.Counter(all_topics)
        if topic_count > 0 and topic_count < len(topic_collection):
            common_topics = [k[0] for k in topic_collection.most_common(topic_count)]
        else:
            common_topics = sorted(topic_collection.keys())

        cow_df = coword_matrix_years(mesh_df, start, end, common_topics)
        cow_nx = nx.from_numpy_matrix(cow_df.as_matrix())
        col_names = cow_df.columns.tolist()
        labels = {col_names.index(l): l for l in col_names}
        start_year = {i: end for i in range(0, len(col_names))}
        end_year = {i: start for i in range(0, len(col_names))}
        nx.set_node_attributes(cow_nx, 'start_year', start_year)
        nx.set_node_attributes(cow_nx, 'end_year', end_year)
        nx.relabel_nodes(cow_nx, labels, copy=False)
        return cow_nx


def coword_network_fast(mesh_df, start, end,topic_count=0): 
        """
        constructs a coword network for the years and topic count
        Uses graph-tool, a much faster graph library for Python
        
        Parameters
        ----------------
        mesh_df: a dataframe with at least the topics and years columns
        start: start year
        end: end year
        topic_count: the number of the topics to use (not too big, otherwise coword matrix will be huge
        """

        # determine the number of topics to count
        all_topics = [t for top in mesh_df.topics.dropna() for t in top]
        topic_collection = collections.Counter(all_topics)
        if topic_count > 0 and topic_count < len(topic_collection):
            common_topics = [k[0] for k in topic_collection.most_common(topic_count)]
        else:
            #use all the topics
            common_topics = sorted(topic_collection.keys())
            topic_count = len(common_topics)

        cow_df = coword_matrix_years(mesh_df, start, end, common_topics)
        cow_m = cow_df.as_matrix()
        # construct graph
        
        g = gt.Graph(directed=False)
        g.add_vertex(topic_count)
        v_topic = g.new_vertex_property('string')
        g.vertex_properties['topic'] = v_topic

        # add topics to vertices
        for i in range(0, topic_count):
            v = g.vertex(i)
            v_topic[v] = common_topics[i]

        # add edges
        for source in range(0, topic_count):
            for target in range(0, topic_count):
                if cow_m[source, target] > 0:
                    e = g.add_edge(g.vertex(source), g.vertex(target))
                    e_occ[e] = cow_m[source, target]

        g.edge_properties['co-occurrence'] =  e_occ
        return g


def cofield_matrix(wos_df, fields):
    """ Implementation of Callon style co-word analysis of  the 
    Wos DE field -- the keywords field in the database.
    Returns a DataFrame of the field cooccurrence with fields 
    as column names
    
    Parameters
    ------------------------------------------------
    wos_df: the WoS literature DataFrame
    fields: list of fields to use
    """

    # assumes that WoS fields have already been cleaned and split into
    # list of fields per publication
    fields_all = wos_df.fields
    # create document term matrix of keywords
    fields_all = fields_all.dropna()
    cofield = np.zeros((len(fields_all), len(fields)))

    # hate doing these nested for loops but 
    #I couldn't get the list comprehensions working properly
    
    for row in range(0, len(fields_all)):
        top = fields_all.iget(row)
        for topic in top:
            if fields.count(topic) > 0:
                cofield[row, fields.index(topic)] = 1
    
    #to create cofield matrix, use matrix dot product
    print('finished matrix ... ')
    cofield_m = np.dot(np.transpose(cofield), cofield)
    np.fill_diagonal(cofield_m, 0)
    cofield_wos_df = pd.DataFrame(cofield_m, columns=fields, index=fields)
    return cofield_wos_df


def inclusion_score(cow_wos_df, key1, key2, key_counts):
    """ Calculates  the inclusion score (conditional probability?) of key1
    given the presence of key2 (or vice versa)"""

    c_ij = cow_wos_df[key1][key2]
    I_ij = c_ij/min(key_counts[key1],  key_counts[key2])
    return I_ij


def inclusion_matrix(cow_m):
    """ Calculates  the inclusion matrix for a coword matrix. 
    Inclusion score is conditional probability of key1
    given the presence of key2 (or vice versa)"""

    keycounts = cow_m.diagonal().tolist()[0]
    # print(len(keycounts))
    # print(cow_m.shape)
    minimum_matrix = [min(p,q) for p,q in itertools.product(keycounts, repeat=2)]
    print(len(minimum_matrix))
    minimum_matrix = np.array(minimum_matrix, dtype=np.float16).reshape(cow_m.shape)
    I_ij = cow_m/minimum_matrix
    return I_ij


def inclusion_matrix_to_edge_weights(I_ij):
    """ Reshapes an inclusion matrix to 
    the tuple-value dictionary needed by networkx
    """
    return {(x,y):I_ij[x,y]   for x in range(0,I_ij.shape[0]) for y in range(0, I_ij.shape[1]) if I_ij[x,y] > 0}


def proximity_score(cow_wos_df, key1, key2, key_counts, article_count):
    """ Calculates  the proximity score  of key1
    given the presence of key2 (or vice versa); 
    The mediator and peripheral keywords pulled
    out by Pg represent minor but potentially growing areas."""

    c_ij = cow_wos_df[key1][key2]
    p_ij = c_ij/(key_counts[key1] * key_counts[key2]) * article_count
    return p_ij


def proximity_matrix(cow_m):
    """ Calculates  the proximity score  of key1
    given the presence of key2 (or vice versa); 
    The mediator and peripheral keywords pulled
    out by Pg represent minor but potentially growing areas."""

    return 'tba'


def equivalence_score(cow_wos_df, key1, key2, key_counts):
    """ Calculates  the equivalence score (mutual inclusion) of key1
    given the presence of key2 (or vice versa); Eghas a value between 0 and 1. Similar to ( l ) E
    measures the probability of word i appearing 
    simultaneously in a document set indexed by word j
    and, inversely, the probability of word j ifword i appears, given the respec-
    tive collection frequencies of the two words."""   

    c_ij = cow_wos_df[key1][key2]
    Equiv_ij  = c_ij**2/(key_counts[key1] * key_counts[key2])
    return Equiv_ij


def fast_equivalence_matrix(cow_m):
    """ Constructs the equivalence matrix for all combinations of key words; 
    This is following (Callon, 1991).
    Parameters
    ------------------------------------------------ 
    cow_m: the matrix of co-word counts
"""

    ecow = cow_m**2
    colsums = cow_m.diagonal()
    for i in range(0, cow_m.shape[0]):
        for j in range(0, cow_m.shape[1]):
            ecow[i,j] = ecow[i, j]/(colsums[i]*colsums[j])
   
    # replace NaN with zero -- this happens
    # because all topics are used in topic list,
    # but particular years may not have that topic
    isnan = np.isnan(ecow)
    ecow[isnan] = 0

    return ecow       


def equivalence_matrix(cow_wos_df, key_counts):
    """ Constructs the equivalence matrix for all combinations of key words; 
    This is following (Callon, 1991).

    Parameters
    --------------------------------------------------- 
    cow_wos_df: the matrix of co-word counts
    key_counts: the list of keyword counts
    """

    keys = cow_wos_df.columns.tolist()
    key_combinations = [(k1, k2) for k1 in 
        cow_wos_df.columns for k2 in cow_wos_df.index if k1 != k2]
    ecow = np.zeros(cow_wos_df.shape)
    for key1_key2 in key_combinations:
        key1, key2 = key1_key2
        if (keys.count(key1) > 0) & (keys.count(key2) > 0):
            index1 = keys.index(key1)
            index2 = keys.index(key2)
            escore = equivalence_score(cow_wos_df, key1, key2, key_counts)
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
    techn_graph = nx.Graph()
    [techn_graph.add_edge(te, f) for t,f in zip(wos_df.topics, wos_df.SC_l) if t is not np.nan  for te in t]
    return techn_graph


def sorted_map(keyval): 

    """ Takes a key-value dictionary and 
    sorts it according to value counts
    Returns a list of key-value tuples
    """
    map_sorted = sorted(keyval.iteritems(), key=lambda (k, v): (-v, k))
    return map_sorted


def trim_edges(graph, weight=1):

    """ Trims all edges with degree less than the parameter.
    Parameters
    -----------------------------
    graph: this graph will have edges taken from it
    weight: remove edges with weight less than this
    """

    [graph.remove_edge(f,to) for f, to, edata in graph.edges(data=True) if edata['weight']<weight]
    print ("%s edges in graph" %graph.number_of_edges())
    print ("%s nodes in graph" %graph.number_of_nodes())
    return graph


def  trim_nodes(graph, degree = 1):

    """ Trims all nodes with degree less than the parameter.
    Parameters
    -----------------------------
    graph: this graph will have edges taken from it
    degree: remove nodes with degree less than this
    """
    graph1 = graph.copy()
    [graph1.remove_node(n) for n in graph1.nodes( ) if nx.degree(graph1, n) <= degree]
    print ("%s nodes in graph" %graph1.number_of_nodes())
    print ("%s edges in graph" %graph1.number_of_edges())

    return graph1


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
    wos_df: WoS or PMC references
    keyword: the one sought

    """

    #check if this is a PMC dataframe, and if so, construct the DE column
    if 'DE' not in wos_df.columns:
        wos_df['DE']  = [';'.join(top).lower() for top in wos_df.topics]

    keyword = keyword + '(s)?'
    top_py_wos_df = wos_df[['topics', 'PY', 'DE']].dropna()
    key_wos_df = top_py_wos_df[top_py_wos_df.DE.str.contains(keyword, 
        case=False)]
    return key_wos_df


def field_years_wos(wos_df, field):

    """ For Web of Science records only,
    Returns a DataFrame with publication years and 
    records containing the field
    
    Parameters
    -------------------------------
    wos_df: WoS or PMC references
    field: the one sought

    """

    field = field + '(s)?'
    top_py_wos_df = wos_df[['fields', 'PY', '']].dropna()
    field_wos_df = top_py_wos_df[top_py_wos_df.SC.str.contains(field, 
        case=False)]
    return field_wos_df


def find_author(wos_df, author):

    """ Return WoS records that include that author somewhere
    in the author field.

    Parameters
    -------------------------------
   wos_df: WoS references
   author:
    """
    au = wos_df.AU.dropna()
    found= au[au.str.contains(author, case=False)==True].index
    return wos_df.ix[found]


def find_citation(wos_df, ref):
    
    """ Returns all the records that cite the reference

    Parameters
    -------------------------
    wos_df: WoS references
    ref: the cited reference expected in 'author year' format
    """
    
    ref = ref.lower()
    ref_parts = ref.split(' ')
    ref_auth = ref_parts[0]
    ref_year  = ref_parts[1]
    ref_other = ''
    if len(ref_parts)  > 2:
        ref_other = ref_parts[2]
    citing_refs = [ut for (refs,ut) in zip(wos_df['cited_refs'], wos_df.index.tolist()) for r in refs if  (ref_auth in r) & (ref_year in r) & (ref_other in r) ]
    return wos_df.ix[citing_refs]


def draw_network_by_years(df, start_year, end_year, trim):

    """ Constructs and draws the co-word networks for the years
    Parameters
    -----------------------------------------
    df: WoS references
    start_year:
    end_year:
    trim: degree of nodes to include in the graph

    Returns
    ----------------------------------
    coword networkx object
    """

    df_sub = df[(df.PY> start_year) & (df.PY <= end_year)]
    keys = keyword_counts(df_sub)
    
    print('Calculating co-word matrix')
    coword_df = coword_matrix(df_sub,keys.keys())
    
    coword_array = coword_df.as_matrix()
    np.fill_diagonal(coword_array, 0)
    coword_net  = nx.from_numpy_matrix(coword_array)
    col_names = coword_df.columns.tolist()
    labels = {col_names.index(l):l for l in col_names}
    nx.set_node_attributes(coword_net, 'keyword', labels)
    nx.set_node_attributes(coword_net, 'between_central', nx.betweenness_centrality(coword_net))
    if trim > 0:
        coword_net = trim_nodes(coword_net, trim)
        labels = {n:labels[n] for n in coword_net.nodes()}
   
    return coword_net


def trim_draw_network(coword_net, trim):

    """ Trims and draws the co-word networks for the years
    
    Parameters
    -----------------------------------------
    coword_net: networkx coword Graph
    trim: degree of nodes to include in the graph

    Returns
    ----------------------------------
    coword networkx object
    """
    coword_net = trim_nodes(coword_net, trim)
    labels = nx.get_node_attributes(coword_net, 'keyword')
    pos = nx.spring_layout(coword_net)
    fig = plt.gcf()
    fig.set_size_inches(12.5,12.5)
    print('drawing the network .... ')
    nx.draw(coword_net, pos=pos, alpha=0.5, 
        node_size={n:math.log1p(5000*bc) for n,bc in nx.get_node_attributes(coword_net, 'between_central').iteritems()}, 
        with_labels=True, labels=labels)
    fig.show()
    return coword_net



def plot_co_x(cox, start, end, size = (20,20), title = '', weighted=False, weight_threshold=10):
        
        """ Plotting function for keyword graphs

        Parameters
        --------------------
        cox: the coword networkx graph; assumes that nodes have attribute 'topic'
        start: start year
        end: end year
        """

        plt.figure(figsize=size)
        plt.title(title +' %s - %s'%(start,end), fontsize=18)
        if weighted:
            elarge=[(u,v) for (u,v,d) in cox.edges(data=True) if d['weight'] >weight_threshold]
            esmall=[(u,v) for (u,v,d) in cox.edges(data=True) if d['weight'] <=weight_threshold]
            pos=nx.graphviz_layout(cox) # positions for all nodes
            nx.draw_networkx_nodes(cox,pos,
                node_color= [s*4500 for s in nx.eigenvector_centrality(cox).values()],
                node_size = [s*6+20  for s in nx.degree(cox).values()],
                alpha=0.7)
            # edges
            nx.draw_networkx_edges(cox,pos,edgelist=elarge,
                                width=1, alpha=0.5, edge_color='black') #, edge_cmap=plt.cm.Blues
            nx.draw_networkx_edges(cox,pos,edgelist=esmall,
                                width=0.3,alpha=0.5,edge_color='yellow',style='dotted')
            # labels
            nx.draw_networkx_labels(cox,pos,font_size=10,font_family='sans-serif')
            plt.axis('off')
        else:
            nx.draw_graphviz(cox, with_labels=True, 
                         alpha = 0.8, width=0.1,
                         fontsize=9,
                         node_color = [s*4 for s in nx.eigenvector_centrality(cox).values()],
                         node_size = [s*6+20 for s in nx.degree(cox).values()])



def term_year_network(df, topic, start, end, size = (18,18), plot=True, weight_threshold=8):

    """ Constructs, plots and returns a network for the given term during the given years

    Parameters
    --------------------------------------
    df: references dataframe with a 'topics' field
    topic: the keyword
    start: start year
    end: end year -- not included
    size: size in inches of the plot
    """
    svm_nx = coword_network(df, start, end)

    topic_nx = nx.ego_graph(svm_nx, topic, undirected=True, radius=10)

    if plot:
        plot_co_x(topic_nx, start, end, size, title = topic, weighted=True, weight_threshold= weight_threshold)
    return topic_nx


def nxkey_for_topic(topic, topics):

    """ helper function to look up the node number
    for a given topic in the list of topics as ordered
    in a networkx graph
    """

    return [k[0] for k in topics.items() if k[1] == topic][0]


"""
Functions below here all help clean up or process
PubmedCentral records so that they look
the same way as Web of Science records
"""


def  pmc_year_column(pmc_df):

    """ Adds a PY - publication year -- column to a EuroPMC dataframe. PMC doesn't return the publication
    year explicitly in the core fields.
    """
    years = pmc_df.journalInfo.map(lambda x: x['yearOfPublication'])
    pmc_df['PY'] = years
    return pmc_df


def pmc_topics_column(pmc_df):
    """ Adds a topics column to a EuroPMC dataframe based on the MESH headings.
    """
    pmc_df['topics'] = pmc_df.meshHeadingList.dropna().map(lambda x: [y['descriptorName'] for y in x['meshHeading']])
    if 'DE' not in pmc_df.columns:
        pmc_df['DE']  = [';'.join(top).lower() for top in pmc_df.topics]
    return pmc_df


def pmc_mesh_qualifier(pmc_df):
    """MESH terms often have a qualifier that might help locating methods or fields. 
    At the moment, this only gets the first one  -- that's not enough, but is ok for illustration
    Returns
    --------------------
    dictionary of pmid: mesh qualifier
    """
    mesh = pmc_df.meshHeadingList
    qualifiers = {k:d['meshQualifierList']['meshQualifier'][0]['qualifierName'] 
            if d.has_key('meshQualifierList') else 'none' 
            for k,p in mesh.iterkv() for d in p['meshHeading']}
    return qualifiers


def pmc_clean_construct(pmc_df):
    """ Takes a PMC data frame, cleans out none-PMC type references,
    adds a topic column (using MESH terms), and a PY (publication year) column
    """

    pmc_df = clean_pmc_refs(pmc_df)
    pmc_df = pmc_topics_column(pmc_df)
    pmc_df = pmc_year_column(pmc_df)
    return pmc_df


def PMC_QueryHitCount(term, years = (1990, 2012)):

    """  Run query against europepmc  and return hitcounts for each year in a dictionary.

    Parameters
    -------------------------------------------------------
    term: search query term
    years: range of years (tuple)
    """

    hc = {}

    query_init ='http://www.ebi.ac.uk/europepmc/webservices/rest/search/query='
    query_suffix = '&format=json'

    for yr in range(years[0], years[1]):
        query_b = term +"  PUB_YEAR:"+str(yr)
        query_full = query_init + query_b + query_suffix
        req = requests.request('GET', query_full)
        hitCount = req.json()['hitCount']
        hc[yr] = hitCount
    return hc


def getPMC_ReferencesQuery(query, full=True, limit=0, random = False):

    """  Run query against europepmc  and return results in a dataframe.

    Parameters
    -------------------------------------------------------
    query: search query (with no more than about 25 terms)
    full:  get all the available metadata, including abstract and MESH terms
    limit: total number of references; O means all of them
    random: if True, sample pages from the overall hitcount
    """

    query_init ='http://www.ebi.ac.uk/europepmc/webservices/rest/search/query='+query
    if full:
        query_suffix = '&resulttype=core&format=json'
    else:
        query_suffix = '&format=json'
    query_init = query_init + query_suffix

    # print('query:' + query_init)

    req = requests.request('GET', query_init)
    hitCount = req.json()['hitCount']

    # PMC will only return 100,000 results so need to adjust for that. 
    if hitCount > 100000:
        hitCount = 100000

    page_count = hitCount/25

    if random and limit > 0:
        page_list= np.random.randint(1, page_count, limit/25)
    else:
        page_list= range(1, page_count)

    # print(page_list)
    # print('Fetching  %s  of %s references'%(min([hitCount, limit]), hitCount))
    # EuroPMC returns 25 items/page
    refs=[]
    for page in page_list:
        # print(page)
        page_query = query_init+'&page='+str(page)
        req = requests.request('GET', 
            page_query)
        res = req.json()
        [refs.append(r) for r in res['resultList']['result']]
        # print('fetched page %s so now have %s refs'%(page, len(refs)))

        if limit !=0 and len(refs) > limit: break

    df=pd.DataFrame.from_dict(refs)
    return df



"""
References --- only seem to come in XML

<id>18784104</id><source>MED</source><citationType>JOURNAL ARTICLE</citationType><title>Recent advances in head and neck cancer.</title><authorString>Haddad RI, Shin DM.</authorString><journalAbbreviation>N. Engl. J. Med.</journalAbbreviation><issue>11</issue><pubYear>2008</pubYear><volume>359</volume><ISSN>0028-4793</ISSN><ESSN>1533-4406</ESSN><pageInfo>1143-1154</pageInfo><citedOrder>1</citedOrder><match>Y</match>
"""


def getPMC_References(df_all):

    """ Return a pandas Panel with all the cited references available from europepmc
    for a list of pmids.
    The panel is 3 D object whose axes are
    1. The ids of the references
    2. The  references cited by each id
    3. The metadata for the cited references

    Parameters
    -----------------------------------
    df_all: DataFrame whose 'id' column will be used to get references
    """

    ids =df_all.id[df_all.hasReferences=='Y']
    columns = ['id', 'source', 'citationType', 'title', 'authors', 'journal', 'issue', 'year', 'vol', 'issn', 'essn', 'pages', 'citedOrder', 'match']
    id_refs = dict()
    for id_ex in ids:
        refs =  []
        ref_query = 'http://www.ebi.ac.uk/europepmc/webservices/rest/MED/'+id_ex + '/references'
        root = etree.parse(ref_query)
        root = etree.parse(ref_query)
        [refs.append([i.text for i in r.getchildren()[0:11]]) for r in root.xpath('//referenceList/reference')]
        #check how many pages
        hit_count = int(root.find('hitCount').text)
        page_count = hit_count/25

        #to get the extra references
        remainder = hit_count % 25
        if remainder > 0:
            page_count = page_count + 1

        print(' fetch %s references'%hit_count)

        for page in range(2, page_count):
            ref_query = 'http://www.ebi.ac.uk/europepmc/webservices/rest/MED/'  + id_ex + '/references&page='+ str(page)
            print(ref_query)
            root = etree.parse(ref_query)
            [refs.append([i.text for i in r.getchildren()[0:11]]) for r in root.xpath('//referenceList/reference')]
            print('fetched page %s so now have %s refs'%(page, len(refs)))
        
        if len(refs) > 0:
            id_refs[int(id_ex)] = pd.DataFrame(refs, columns=columns[0:11])

    ref_panel = pd.Panel(id_refs)
    return ref_panel


def clean_pmc_refs(df_full):
        """
        De-dups, re-indexes, and chooses references that have journal
        and mesh info
        """
        df_full = df_full.drop_duplicates(cols = ['id', 'title'])
        df_full.reset_index(inplace=True)
        df_full = df_full.dropna(subset=['meshHeadingList'])
        df_full = df_full.dropna(subset=['journalInfo'])
        df_full = df_full.set_index('pmid')
        print("There are %s references with %s fields in the reference list"%df_full.shape)
        return df_full


def term_yr_hist(mesh_df, term, years):
    """
    Helper for the plotting function above

    Returns
    -----------------------------
    vals, bins: the counts and bins for the term over years

    """
    term_yr = keyword_years(mesh_df, term)
    year_count = years[1]-years[0]
    vals, bins = np.histogram(term_yr.PY, bins=year_count, range=years)
    return (vals, bins[1:])


def keyword_plot(df, terms, years, title='', size=(14, 8)):

    """
    Draws line plots of publication counts for all the terms
    over the year range

    Parameters
    ---------------------------------------
    df: publication dataframe with PY and topics
    terms: list of the terms to plot
    years: range of years
    """
    plt.figure(figsize=size)
    start, end = years
    for t in terms:
        v, b = term_yr_hist(df, t, years)
        plt.plot(b, v, label=t, linewidth=4)
    plt.legend()
    plt.title('Key terms in the %s literature: %s-%s'%(title, start, end), fontsize=15)
    plt.legend(loc='upper left')
    plt.box(on=False)


def pmc_author_graph(pmcdf):
    """ Takes the authorString from PMC and returns a coauthorship
    graph as graph_tool graph"""
    
    authors = pmcdf.authorString.str.encode('utf-8')
    author_set = {a for au in authors.str.split(', ') for a in au}
    aul = list(author_set)

    aug = gt.Graph(directed=False)
    # add authors as nodes
    aug.add_vertex(len(aul))
    v_au = aug.new_vertex_property('string')
    for i in range(0, len(aul)):
        v = aug.vertex(i)
        v_au[v] = aul[i]

    aug.vertex_properties['au'] = v_au

    ## add coauthors as edges, as well as a count of how often they coauthor
    au_edges = [(a,b) for al in authors.str.split(', ') for a, b in itertools.combinations(al, 2) ]

    el = []

    for coau in au_edges:
        # print(coau)
        s = aul.index(coau[0])
        t = aul.index(coau[1])
        e = aug.add_edge(aug.vertex(s), aug.vertex(t))
        el.append(e)
    
    print('Author graph has %s authors and %s co-author connects'
        % (aug.num_vertices(), aug.num_edges()))
    return aug


def wos_author_graph(wosdf):
    """ Takes the authorString from PMC and returns a coauthorship
    graph as graph_tool graph"""
    
    authors = wosdf.AU.dropna().str.encode('utf-8').str.lower()
    author_set = {a for au in authors.str.split(', ') for a in au}
    aul = list(author_set)

    print('Adding nodes for authors ... ')
    aug = gt.Graph(directed=False)
    # add authors as nodes
    aug.add_vertex(len(aul))
    v_au = aug.new_vertex_property('string')
    for i in range(0, len(aul)):
        v = aug.vertex(i)
        v_au[v] = aul[i]

    aug.vertex_properties['au'] = v_au

    ## add coauthors as edges, as well as a count of how often they coauthor
    au_edges = [(a, b) for al in authors.str.split(', ') for a, b in itertools.combinations(al, 2) ]

    el = []
    print('Adding edges for co-authors... ')
    for  coau in au_edges:
        # print(coau)
        s = aul.index(coau[0])
        t = aul.index(coau[1])
        e = aug.add_edge(aug.vertex(s), aug.vertex(t))
        el.append(e)
    
    print('Author graph has %s authors and %s co-author connects' 
        % (aug.num_vertices(), aug.num_edges()))
    return aug


def sra_machine_experiment(node_limit = 200000L):
    """
    Queries SRAdb for all machine names and experiments
    and builds  a bipartite network using them.

    Parameters
    -------------------------------------
    node_limit: the maximum number of nodes to include

    Returns a graph_tool Graph with the following properties:
    machine: boolean
    experiment: boolean
    sample:boolean
    study: boolean
    center: boolean
    entity: type of entities are 1-machine, 2-experiment, 3-sample, 4-study
    label: instrument name or experiment accession

    """
    conn = sqlite3.connect('ngs_paper/data/SRAmetadb.sqlite')
    machines_exp = pd.io.sql.read_frame(
                """select run.run_accession,run.experiment_accession,  
                    run.instrument_name, 
                    experiment.platform, experiment.instrument_model, 
                    experiment.sample_accession,
                    experiment.center_name,
                    experiment.study_accession,
                    run.run_date,total_data_blocks 
                    from run, experiment 
                    where run.experiment_accession == experiment.experiment_accession
                    limit
                    """ + str(node_limit) +';', conn)
    # so many instrument names are, that I'm going to impute putative machines
    # based on the center names; this could be augmented by the machines counts from 
    # Loman's map; I'm assuming they are missing completely at random
    machines_exp['instrument_name_imputed'] =   machines_exp.instrument_name.map(str) +   '_'  + machines_exp.instrument_model +  '_' + machines_exp.center_name
    machines_exp['instrument_name_imputed'] = machines_exp.instrument_name_imputed.str.encode('utf-8')
    machines_exp['center_name'] = machines_exp.center_name.str.encode('utf-8')

    m_e = machines_exp[['instrument_name_imputed', 
        'experiment_accession', 'sample_accession', 'study_accession', 'center_name']].dropna()
    m_e.reset_index(inplace=True)
    
    instruments = m_e.instrument_name_imputed.unique().tolist()
    experiments = m_e.experiment_accession.unique().tolist()
    samples = m_e.sample_accession.unique().tolist()
    studies = m_e.study_accession.unique().tolist()
    centers = m_e.center_name.unique().tolist()
    instruments_experiments_samples = instruments + experiments + samples + studies + centers
    node_count = long(len(instruments) + len(experiments) + len(samples) + len(studies) + len(centers))

    if node_count  >  node_limit:
        print('arrange nodes limits better!')

    # print('Graph will have %s nodes including %s instruments, %s samples, %s studies, %centres and %s experiments'%
        # (node_count, len(instruments), len(samples), len(studies), len(centers), len(experiments)))
   
    #constructing this dictionary for fast lookup of node numbers
    instr_exp_dic = dict(zip(instruments_experiments_samples, range(0, node_count)))
    g = gt.Graph()
    vs = g.add_vertex(node_count)
    
    v_machine = g.new_vertex_property('boolean')
    v_experiment = g.new_vertex_property('boolean')
    v_sample = g.new_vertex_property('boolean')
    v_study = g.new_vertex_property('boolean')
    v_center = g.new_vertex_property('boolean')
    v_label = g.new_vertex_property('string')
    v_entity = g.new_vertex_property('int')

    #add instruments
    for i in range(0, len(instruments)):
        v = vs.next()
        v_machine[v] = True
        v_experiment[v] = False
        v_sample[v] = False
        v_study[v] = False
        v_center[v] = False
        v_label[v] = instruments[i]
        v_entity[v] = 1
    print('Added %s instruments' % (len(instruments)))
    
    # add experiments
    for i in range(0, len(experiments)):
        v = vs.next()
        v_machine[v] = False
        v_experiment[v] = True
        v_sample[v] = False
        v_study[v] = False
        v_center[v] = False
        v_label[v] = experiments[i]
        v_entity[v] = 2
    print('Added %s experiments' % (len(experiments)))

    # add samples
    for i in range(0, len(samples)):
        v = vs.next()
        v_machine[v] = False
        v_experiment[v] = False
        v_sample[v] = True
        v_study[v] = False
        v_center[v] = False
        v_label[v] = samples[i]
        v_entity[v] = 3
    print('Added %s samples' % (len(samples)))

    # add studies
    for i in range(0, len(studies)):
        v = vs.next()
        v_machine[v] = False
        v_experiment[v] = False
        v_sample[v] = False
        v_study[v] = True
        v_center[v] = False
        v_label[v] = studies[i]
        v_entity[v] = 4
    print('Added %s studies' % (len(studies)))

    # add centers
    for i in range(0, len(centers)):
        v = vs.next()
        v_machine[v] = False
        v_experiment[v] = False
        v_sample[v] = False
        v_study[v] = False
        v_center[v] = True
        v_label[v] = centers[i]
        v_entity[v] = 5
    print('Added %s centers' % (len(centers)))

    g.vertex_properties['machine'] = v_machine
    g.vertex_properties['experiment'] = v_experiment
    g.vertex_properties['sample'] = v_sample
    g.vertex_properties['study'] = v_study
    g.vertex_properties['center'] = v_center
    g.vertex_properties['label'] = v_label
    g.vertex_properties['entity'] = v_entity
    
    # link machines, samples and experiments with machine as the source
    # sample and experiment as the target ... Not sure why I chose that ...

    for i in range(0, m_e.shape[0]):
        s_i = instr_exp_dic[m_e.ix[i, 'instrument_name_imputed']]
        t_i = instr_exp_dic[m_e.ix[i, 'experiment_accession']]
        t_2 = instr_exp_dic[m_e.ix[i, 'sample_accession']]
        t_3 = instr_exp_dic[m_e.ix[i, 'study_accession']]
        t_4 = instr_exp_dic[m_e.ix[i, 'center_name']]
        g.add_edge(g.vertex(s_i), g.vertex(t_i))
        g.add_edge(g.vertex(s_i), g.vertex(t_2))
        g.add_edge(g.vertex(s_i), g.vertex(t_2))
        g.add_edge(g.vertex(s_i), g.vertex(t_3))
        g.add_edge(g.vertex(s_i), g.vertex(t_4))

        if i % 10000 == 0:
            print('added %s edges' % g.num_edges())

    return g
