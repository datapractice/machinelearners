
import tabulate
import ml_lit_anal as ml
import pandas as pd
import collections
df = ml.load_records('data/machine_learning_WOS/')
df = ml.clean_topics(df)
df = ml.clean_fields(df)
all_fields = sorted([e for el in df.fields.dropna() for e in el])
fset = set(all_fields)
field_counts = {e:all_fields.count(e) for e in fset}
field_counts_sorted = sorted(field_counts.iteritems(), key=lambda(k,v):(-v,k))
