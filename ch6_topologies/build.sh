#!/bin/sh 

./knit_all.sh
./pandoc.sh
evince ch_genomic_topologies.pdf
