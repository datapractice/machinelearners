#!/usr/bin/zsh

rm book.rmd
xargs -a chapter_list.txt cat >>book.rmd
