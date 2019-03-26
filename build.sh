#!/bin/bash
if which pdflatex makeindex biber &>/dev/null
then
  mkdir -p ./output;
  pdflatex -output-directory output main;
  makeindex -s ./output/main.ist -t ./output/main.glg -o ./output/main.gls ./output/main.glo;
  biber --output-directory output main;
  pdflatex -output-directory output main;
  pdflatex -output-directory output main;
else
  echo "Build commands are not available..";
fi