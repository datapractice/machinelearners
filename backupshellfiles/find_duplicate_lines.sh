cat $(grep -v '^#' chapter_list_rmd.txt) > output.txt
cat output.txt| sed 's/[.!?]  */&\n/g' > sentences.txt
sort sentences.txt > sorted_sentences.txt
uniq -d sorted_sentences.txt > dupes.txt

