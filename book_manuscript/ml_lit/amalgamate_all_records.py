#!/usr/bin/python
# coding: utf-8


import os
import sys
sys.path.append(os.path.relpath('../ml_lit'))
import ml_lit_anal as mla
import pandas as pd
import sqlite3

fields_to_use = ['anchor','DE', 'AU', 'SC', 'WC', 'TI', 'PY', 'TC','UT','CR' ]

def load_clean_select_name(dir):
    full_dir = 'data/' + dir + '/'
    df = mla.load_records(full_dir)
    df = mla.clean_topics(df)
    df = mla.clean_fields(df)
    df['anchor'] = dir
    df_sel = df[fields_to_use]
    return df_sel



if len(sys.argv) >1:
    dirs = sys.argv
else:
    dirs = os.listdir('data')

df_all = pd.DataFrame()

for d in dirs:
    print 'loading directory ' + d
    df = load_clean_select_name(d)
    df_all = df_all.append(df, ignore_index=True)


df_all.CR = df_all.CR.str.decode('utf8')
con = sqlite3.connect('all_refs.sqlite3')

df_all[fields_to_use].to_sql(flavor = 'sqlite', name = 'basic_refs', con = con, if_exists='replace')
con.commit()
con.close()

# res = con.execute('select * from basic_refs where TI like "%random forest%" OR DE like "%support vector machine%" order by TC desc;')
# q = res.fetchall()
print df_all.shape

