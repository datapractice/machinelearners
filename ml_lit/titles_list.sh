#!/bin/bash
cat `find data -type f`|cut -f9 > titles.txt
cat titles.txt|sed 's/; /\n/g'|sort > titles_sorted.text
cat titles_sorted.text|tr '[:upper:]' '[:lower:]'|uniq -c|sort -n -r > titles_sorted_deduped.txt
wc -l titles_sorted_deduped.txt
