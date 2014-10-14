
import ml_lit_anal as ml
import gensim
from gensim import corpora
import nltk
from nltk.corpus import stopwords
from gensim import corpora, models, similarities
from itertools import chain
from operator import itemgetter

def construct_topicmodel(n_topics = 60, files='data/expect_max_WOS/', document_to_display = 1):
    """
    Loads all the files in the folder as a dataframe, runs an LDA topic model
    on them using n_topics
    """
    tm = ml.load_records(files)
    ab_title = tm.TI + ' ' + tm.AB
    documents = ab_title.dropna().tolist()
    stoplist = stopwords.words('english')
    stoplist = stoplist + ['topic', 'model','models', 'topics', 'data']
    texts = [[word for word in document.lower().split() if word not in stoplist] for document in documents]
    dictionary = corpora.Dictionary(texts)
    corpus = [dictionary.doc2bow(text) for text in texts]
    tfidf = models.TfidfModel(corpus) 
    corpus_tfidf = tfidf[corpus]
    lda = models.LdaMulticore(corpus_tfidf, id2word=dictionary, num_topics=n_topics, workers = 3)
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
