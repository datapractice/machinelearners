#!/bin/bash
cat `find data -type f`|cut -f6 > authors.txt
cat authors.txt|sed 's/; /\n/g'|sort > authors_sorted.text
cat authors_sorted.text|tr '[:upper:]' '[:lower:]'|uniq -c|sort -n -r > authors_sorted_deduped.txt
wc -l authors_sorted_deduped.txt
