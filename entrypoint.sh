#! /usr/bin/env sh
set -e

pwd
ls -al

echo
make $* || exit 1
du -sh *.pdf

echo
./tools/check_uncited_references.bash references.bib *.tex
./tools/check_unreferenced_labels.bash *.tex
./tools/check_missing_refs.bash

echo
nb_pages=$(pdfinfo thesis.pdf | grep Pages | sed 's/[^0-9]*//') 2> /dev/null
echo "::set-output name=nb_pages::$nb_pages"
file_size=$(du -sh thesis.pdf | cut -f1)
echo "::set-output name=file_size::$file_size"
