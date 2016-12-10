#!/usr/bin/zsh

# update references
#echo 'Updating bibliography libraries from zotero ....'
#cd ref_bibs
#./getrefs.sh
cd ~/book
echo "Cleaning up previous builds ...."

file="book.md"
# give list of md to pandoc to produce one latex document
if [ -f "$file" ] 
then
    rm "$file"
fi

#xargs -a chapter_list.txt pandoc -o book.latex
echo "Combining all chapters into single book file ...."
xargs -a chapter_list.txt cat >>book.md

echo "Building references, bibliography and pdf ...."
pandoc -R book.md -o book.latex --bibliography ref_bibs/uni.bib

echo "Converting latex to pdf ... "
#pdflatex book.latex
