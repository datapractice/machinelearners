# %load_ext autoreload
# %autoreload 2


import pandas as pd
import re
import os
import matplotlib
import pickle
import datetime


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

df = load_records('data/')
