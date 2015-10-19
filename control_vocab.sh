#!/bin/bash

# these lines create a simple index without chapter names
cat chapter_list_rmd.txt | xargs grep -E  -h -o --include \*.rmd '\\index{((\w+(, )?)+!?(\w+ ?))+(\|see(also)?{(\w+ ?)+})?(\|[()])?}' > index.md
sort index.md > index_u.md
uniq -c index_u.md > index_fin.md 
rm index_u.md

cat chapter_list_rmd.txt | xargs grep -E   -o --include \*.rmd '\\index{((\w+(, )?)+!?(\w+ ?))+(\|see(also)?{(\w+ ?)+})?(\|[()])?}' > index.mdO
sort index.md > index_u.md
uniq -c index_u.md > index_fin_by_chapter.md 
