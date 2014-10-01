f_ham = list.files('enron1/ham', full.names = TRUE)
f_spam = list.files('enron1/spam', full.names = TRUE)
ham_count = length(f_ham) 
spam_count = length(f_spam)

word = 'gas'

ham = sapply(f_ham, readLines, warn=FALSE)
spam = sapply(f_spam, readLines, warn=FALSE)


## count the occurrence of the word in each
Nword_in_ham = sum(grepl(word, ham))
Nword_in_spam = sum(grepl(word, spam))
print (paste(Nword_in_ham, ' ham examples contain ', word))
print (paste(Nword_in_spam, ' spam examples contain ', word))

P_ham = ham_count/(ham_count + spam_count)
P_spam = spam_count/(ham_count + spam_count)

cat('estimated P(spam) = ', P_spam)
cat('estimated P(ham) = ', P_ham)

Pword_spam = Nword_in_spam/spam_count
Pword_ham = Nword_in_ham/ham_count
cat("P(spam|", word, ") = ", Pword_spam)
cat("P(ham|", word, ") = ", Pword_ham)
