#/bin/bash
#pdftk testout.pdf output utestout.pdf uncompress
sed -e "s/Qoppa Software/ /" utestout.pdf > unwatermarked.pdf
sed -e "s/PDF Studio - PDF Editor for Mac, Windows, Linux. For Evaluation. http:\\/\\/www.qoppa.com\\/pdfstudio/ /" unwatermarked.pdf > unwatermarked2.pdf
pdftk unwatermarked2.pdf output fixed.pdf compress
#evince fixed.pdf

