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
