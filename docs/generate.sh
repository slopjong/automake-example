#!/bin/sh

command -v dot >/dev/null 2>&1 || { echo >&2 "I require the dot tool from the graphviz package but it's not installed. Aborting."; exit 1; }

N="autoconf-automake-process-simplified"

m4 \
  --define=LABEL_executable="executable" \
  --define=LABEL_input_file="input file" \
  --define=LABEL_output_file="output file" \
  --define=LABEL_process="process" \
  --define=LABEL_influences="influences" \
  --define=LABEL_creates="creates" \
  "${N}.dot.prem4" > "${N}.dot"
dot \
  -Tpng \
  -Nfontname=FreeSans \
  < "${N}.dot" \
  > "${N}.png"

#m4 \
#  --define=LABEL_executable="exécutable" \
#  --define=LABEL_input_file="fichier d'entrée" \
#  --define=LABEL_output_file="fichier de sortie" \
#  --define=LABEL_process="procès" \
#  --define=LABEL_influences="influencer" \
#  --define=LABEL_creates="créer" \
#  "${N}.dot.prem4" > "${N}-fr.dot"
#dot \
#  -Tsvg \
#  -Nfontname=FreeSans \
#  < "${N}-fr.dot" \
#  > "${N}-fr.svg"

rm *.dot
