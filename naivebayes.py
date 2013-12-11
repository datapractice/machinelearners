# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <markdowncell>

# # based on Ng, lecture 5/6
# 
# Useful model because it is easy to understand, and works well on text classificatio

# <codecell>

from sklearn import datasets
import sklearn.naive_bayes as nb

# <codecell>

iris = datasets.load_iris()
mnb = nb.MultinomialNB()
y_pred = mnb.fit(iris.data, iris.target).predict(iris.data)
print("Number of mislabeled points : %d" % (iris.target != y_pred).sum())

# <codecell>

print(iris.DESCR)

# <codecell>


