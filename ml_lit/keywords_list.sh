#!/bin/bash
cat `find data -type f`|cut -f20 > keywords.txt
cat keywords.txt|sed 's/; /\n/g'|sort > keywords_sorted.text
cat keywords_sorted.text|tr '[:upper:]' '[:lower:]'|uniq -c|sort -n -r > keywords_sorted_deduped.txt
wc -l keywords_sorted_deduped.txt
