import ml_lit_anal as ml
import gensim
import nltk
from nltk.corpus import stopwords
from nltk.stem import *
from nltk.util import ngrams
from nltk.tag import pos_tag
from gensim import corpora, models, similarities
from itertools import chain
from operator import itemgetter
from nltk.tokenize import word_tokenize
files='data/expect_max_WOS/'
tm = ml.load_records(files)
ab_title = tm.TI + ' ' + tm.AB
documents = ab_title.dropna().tolist()
abstracts = [pos_tag(word_tokenize(s)) for s in documents]
abstracts[0]
texts =  [[w[0].lower() for w in ab if w[1] in 'NNS' or w[1] in 'JJR'] for ab in abstracts]
texts =  [[w[0].lower() for w in ab if w[1] in 'VB'] for ab in abstracts]
texts_ngram = [ngrams(t, 1) for t in texts]
texts_ngram = [[' '.join(t).replace(',', '').replace('.', '') for t in tex] for tex in texts_ngram]
dictionary = corpora.Dictionary(texts_ngram)
corpus = [dictionary.doc2bow(text) for text in texts_ngram]
tfidf = models.TfidfModel(corpus)
corpus_tfidf = tfidf[corpus]
workers = 3
n_topics = 20
iterate=150
lda = models.LdaMulticore(corpus_tfidf, id2word=dictionary, iterations=iterate, num_topics=n_topics, workers = workers)
for i in range(0, n_topics):
        temp = lda.show_topic(i, 10)
        terms = []
        for term in temp:
            terms.append(term[1])
        print "Top 10 terms for topic #" + str(i) + ": "+ ", ".join(terms)
        print



def construct_topicmodel(n_topics = 60, files='data/expect_max_WOS/', workers = 3, iterate=50, document_to_display = 1):
    """
    Loads all the files in the folder as a dataframe, runs an LDA topic model
    on them using n_topics
    """
    tm = ml.load_records(files)
    ab_title = tm.TI + ' ' + tm.AB
    documents = ab_title.dropna().tolist()
    stoplist = stopwords.words('english')
    stoplist = stoplist + ['em', 'topic', 'model','models', 'topics', 'data','lda', 'acm', 'comp', 'ieee', 'paper', 'sci', 'doi', 'latent', 'allocation', 'res', 'conference', 'data', 'int', 'can', 'topic','latent', 'dirichlet', 'topics', 'model', 'models']
    stemmer = PorterStemmer()
    texts = [[stemmer.stem(word) for word in document.lower().split() if word not in stoplist] for document in documents]
    print ("loaded and stemmed %s documents"%len(texts))
    texts_ngram = [ngrams(t, 2) for t in texts]
    texts_ngram = [[''.join(t).replace(',', '').replace('.', '') for t in tex] for tex in texts_ngram]
    dictionary = corpora.Dictionary(texts_ngram)
    corpus = [dictionary.doc2bow(text) for text in texts_ngram]
    tfidf = models.TfidfModel(corpus)
    corpus_tfidf = tfidf[corpus]
    lda = models.LdaMulticore(corpus_tfidf, id2word=dictionary, iterations=iterate, num_topics=n_topics, workers = workers)
    for i in range(0, n_topics):
         temp = lda.show_topic(i, 10)
         terms = []
         for term in temp:
             terms.append(term[1])
         print "Top 10 terms for topic #" + str(i) + ": "+ ", ".join(terms)
    print
    print 'Which LDA topic maximally describes a document?\n'
    print 'Original document: ' + documents[document_to_display]
    print 'Preprocessed document: ' + str(texts[document_to_display])
    #print 'Matrix Market format: ' + str(corpus[document_to_display])
    print 'Topic probability mixture: ' + str(lda[corpus[document_to_display]])
    print 'Maximally probable topic: topic #' + str(max(lda[corpus[document_to_display]],key=itemgetter(1))[0])
    return {'model':lda, 'corpus':corpus, 'text':texts, 'documents':documents}

def predict_document_topic(model, corpus, texts, documents, document_to_display):
    print
    print 'Which LDA topic maximally describes a document?\n'
    print 'Original document: ' + documents[document_to_display]
    print 'Preprocessed document: ' + str(texts[document_to_display])
    print 'Matrix Market format: ' + str(corpus[document_to_display])
    print 'Topic probability mixture: ' + str(model[corpus[document_to_display]])
    print 'Maximally probable topic: topic #' + str(max(model[corpus[document_to_display]],key=itemgetter(1))[0])
    max_topic = max(model[corpus[document_to_display]],key=itemgetter(1))[0]
    print model.show_topic(max_topic)

def predict_document(res, document_to_display):
    model = res['model']
    corpus = res['corpus']
    documents = res['documents']
    texts = res['text']
    predict_document_topic(model, corpus, texts, documents, document_to_display)

def example():
    res = construct_topicmodel(60, 'data/topicmodel_WOS/', 90)
    predict_document(res, 833)
    model = res['model']


