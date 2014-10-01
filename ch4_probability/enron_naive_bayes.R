f_ham = list.files('enron1/ham', full.names = TRUE)
f_spam = list.files('enron1/spam', full.names = TRUE)
ham_count = length(f_ham) 
spam_count = length(f_spam)

word = 'gas'

ham = sapply(f_ham, readLines, warn=FALSE)
spam = sapply(f_spam, readLines, warn=FALSE)

P_ham = ham_count/(ham_count + spam_count)
P_spam = spam_count/(ham_count + spam_count)

## count the occurrence of the word in each
word_in_ham = sum(grepl(word, ham))
word_in_spam = sum(grepl(word, spam))
