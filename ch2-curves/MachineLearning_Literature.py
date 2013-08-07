# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

%load_ext autoreload
%autoreload 2
import ml_lit_anal as ml
import re

# <codecell>

df = ml.load_records('data/')
df.shape

# <codecell>

print(len(df.SC.unique()))
print df.SC.unique()

# <codecell>

#the problem is that computer science clutters everything -- get rid of it?

topics = df.SC.str.lower()
print topics.value_counts().order(ascending=False)[0:20]

# <codecell>

topics_sans = topics.str.replace('(computer science; ?)|(engineering; ?)', '')
topics_sans = topics_sans.map(lambda x: re.split(';', str(x))[0])
topics_sans.value_counts()


print topics_sans.value_counts()[0:50]
#print topics_sans.value_counts()[0:20]

# <codecell>

# the relation between supervised and unsupervised
print(len(df.TI[(df.AB.str.contains(pat = 'supervised|unsupervise', case=False, na=False))]))
print(df.TI[(df.AB.str.contains(pat = 'supervised|unsupervise', case=False, na=False))])

# <codecell>

figure(figsize=(10,10))
subplot(1,2,2)

hist(df.PY, bins=100, alpha=0.6, label= 'Machine Learning Publications by Year')
subplot(1,2,1)
df.SC.value_counts()[0:20].plot(kind='barh', alpha=0.5, grid=False)

