#!/bin/sh
./knit_front_matter.sh
cd ch0_introduction/
./knit_all.sh
cd ..
cd ch1_learning/
./knit_all.sh
cd ..
cd ch2_vector/
./knit_all.sh
cd ..
cd ch3_curves/
./knit_all.sh
cd ..
cd ch4_probability/
./knit_all.sh
cd ..
cd ch5_dimensionality/
./knit_all.sh
cd ..
cd ch6_topologies/
./knit_all.sh
cd ..
cd ch7_subjects/
./knit_all.sh
cd ..
cd ch8_conclusion/
./knit_all.sh
cd ..
