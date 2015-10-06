#!/bin/bash

grep -E -r -h -o --include \*.rmd '\\index{((\w+(, )?)+!?(\w+ ?))+}' .> index.md
uniq -c index.md index_u.md
sort index_u.md > index_fin.md

