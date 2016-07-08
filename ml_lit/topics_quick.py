from gensim import corpora
import gensim.models
ab = open('ab_ti.txt', 'r')
documents = ab.readlines()
stoplist = set('for a of the and to in'.split())
texts = [[word for word in document.lower().split() if word not in stoplist]
                   for document in documents]
# dictionary = corpora.Dictionary(texts)
# dictionary.save('abti_dict.dic')
dictionary = corpora.Dictionary()
dictionary = dictionary.load('abti_dict.dic')
# corpus = [dictionary.doc2bow(text) for text in texts]
# corpora.MmCorpus.serialize('ti_abstracts.mm', corpus)
corpus = corpora.MmCorpus('ti_abstracts.mm')
# model = models.LdaModel(corpus, id2word=dictionary, num_topics=100)
model = gensim.models.LdaMulticore(corpus, id2word=dictionary,
                                   num_topics=100)
