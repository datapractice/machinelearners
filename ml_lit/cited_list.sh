#!/bin/bash
cat `find data -type f`|cut -f30 > cited.txt
cat cited.txt|sed 's/; /\n/g'|sort > cited_sorted.text
cat cited_sorted.text|tr '[:upper:]' '[:lower:]'|uniq -c|sort -n -r > cited_sorted_deduped.txt
wc -l cited_sorted_deduped.txt
