#!/bin/bash

# Read possible --clear-pdfs from the cli args
if [[ $1 == "--clear-pdfs" ]] || [[ $2 == "--clear-pdfs" ]]; then
  clearPDFs=true;
fi

# Read possible --open-pdf from the cli args
if [[ $1 == "--open-pdf" ]] || [[ $2 == "--open-pdf" ]]; then
  openPDF=true;
fi

# Compile latex sources into pdf
if which pdflatex makeindex biber &>/dev/null; then
  mkdir -p ./output;
  pdflatex -output-directory output main;
  makeindex -s ./output/main.ist -t ./output/main.glg -o ./output/main.gls ./output/main.glo;
  biber --output-directory output main;
  pdflatex -output-directory output main;
  pdflatex -output-directory output main;

  # Clear and save pdf
  timestamp=$(date +"%Y-%m-%d_%H-%M");
  [[ $clearPDFs == true ]] && rm ./output/thesis_*.pdf;
  mv ./output/main.pdf ./output/thesis_$timestamp.pdf;
  rm ./config/tau-logo-fin-eps-converted-to.pdf ./output/main.* ./output/pdfa.xmpi;

  # Create symlink thesis_latest.pdf to freshly created pdf
  cd ./output/ && ln -fs thesis_$timestamp.pdf thesis_latest.pdf && cd ..;

  # Try to auto-open the pdf
  [[ $openPDF == true ]] && which open && open ./output/thesis_$timestamp.pdf &
  [[ $openPDF == true ]] && which xdg-open && xdg-open ./output/thesis_$timestamp.pdf &
else
  echo "Build commands are not available..";
fi