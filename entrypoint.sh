#! /usr/bin/env sh

pwd
ls -al
make $* || exit 1
du -sh *.pdf
