import pandas as pd
import matplotlib.pyplot as plt
import re
import os


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

def keyword_counts(wos_df):
    """ Returns a dictionary with keyword counts"""
    de_all = [d for de in wos_df.topics.dropna() for d in de]
    key_counts = collections.Counter(de_all)
    return key_counts


df = load_records('data/hastie_elem_WOS/')
print('There are %s records in the dataset' % df.shape[0])
df = clean_topics(df)
df = clean_fields(df)

print('%s topic fields are null' % sum(df.topics.isnull()))
print('%s abstract fields are null' % sum(df.AB.isnull()))
print('%s keywords Plus fields are null' % sum(df.ID.isnull()))
print('% s author fields are null' % sum(df.AF.isnull()))

all_fields = sorted([e for el in df.fields.dropna() for e in el])
fields_set = set(all_fields)
field_counts = {e: all_fields.count(e) for e in fields_set}

print('%s different fields appear in the literature citing Hastie (2001/2009)' % len(fields_set))
field_counts_s = sorted(field_counts.iteritems(), key=lambda(k, v):(-v, k))
field_counts_s[0:30]
major_fields = {f:v for f,v in field_counts.iteritems() if v > 3 or f is not 'computer science'}
print(len(field_counts), len(major_fields))
kw = keyword_counts(df)
kw.most_common()[:50]
#find the most commonly cited pages
hastie = df.CR.str.findall('Hastie.*?;')
hastie = hastie.map(lambda x:  x[0] if len(x) ==1 else '')
hastie_pages = hastie[hastie.str.contains('P')]
pages = hastie_pages.str.findall('\d{1,3};').map(lambda x: x[0] if len(x) ==1 else '').str.replace(';', '')
pages = pages[pages != '']
pages = pages.astype('int')
pages_counted = pages.value_counts()
pages_counted_sorted = pages_counted.sort_index()
pages_counted_sorted.to_csv('data/hastie_pages.csv')
