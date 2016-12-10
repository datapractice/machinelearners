# %load_ext autoreload
# %autoreload 2

import pandas as pd
import sqlite3
import re
import os
import numpy as np
import operator
import collections
import math
import itertools
import requests
from lxml import etree


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

