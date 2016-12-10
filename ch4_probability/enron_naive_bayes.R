f_ham = list.files('enron1/ham', full.names = TRUE)
f_spam = list.files('enron1/spam', full.names = TRUE)
ham_count = length(f_ham) 
spam_count = length(f_spam)

ham = sapply(f_ham, readLines, warn=FALSE)
spam = sapply(f_spam, readLines, warn=FALSE)
P_ham = ham_count/(ham_count + spam_count)
P_spam = spam_count/(ham_count + spam_count)
word = 'gas'

predict_spam <- function(word) {

    ## count the occurrence of the word in each
    Nword_in_ham = sum(grepl(word, ham))
    Nword_in_spam = sum(grepl(word, spam))
    cat(Nword_in_ham, ' ham examples contain ', word,  '\n')
    cat(Nword_in_spam, ' spam examples contain ', word,  '\n')


    cat('estimated P(spam) = ', P_spam,  '\n')
    cat('estimated P(ham) = ', P_ham,  '\n')

    Pword_spam = Nword_in_spam/spam_count
    Pword_ham = Nword_in_ham/ham_count
    cat("P(spam|", word, ") = ", Pword_spam,  '\n')
    cat("P(ham|", word, ") = ", Pword_ham,  '\n')

    Pham_word = Pword_ham * P_ham
    Pspam_word = Pword_spam * P_spam
    Pword = Pspam_word + Pham_word
    Pspam_word = Pspam_word/Pword

    cat("P(spam|",word,")=", Pspam_word, '\n')
}

predict_spam('gas')
predict_spam('finance')
predict_spam('sex')

