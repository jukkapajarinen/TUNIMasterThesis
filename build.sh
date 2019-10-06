#!/bin/bash

# Read possible --clear-pdfs from the cli args
if [[ $1 == "--clear-pdfs" ]] || [[ $2 == "--clear-pdfs" ]]; then
  clearPDFs=true;
fi

# Compile latex sources into pdf
if which pdflatex makeindex biber &>/dev/null; then
  mkdir -p ./output;
  pdflatex -output-directory output main;
  makeindex -s ./output/main.ist -t ./output/main.glg -o ./output/main.gls ./output/main.glo;
  biber --output-directory output main;
  pdflatex -output-directory output main;
  pdflatex -output-directory output main;
  [[ $clearPDFs == true ]] && rm ./output/thesis_*.pdf;
  mv ./output/main.pdf ./output/thesis_$(date +"%Y-%m-%d_%H-%M").pdf;
  rm ./config/tau-logo-fin-eps-converted-to.pdf ./output/main.* ./output/pdfa.xmpi;
else
  echo "Build commands are not available..";
fi