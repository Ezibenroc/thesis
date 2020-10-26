#! /usr/bin/env sh

echo "Hello $1"
make
du -sh *.pdf
file *.pdf
time=$(date)
echo "::set-output name=time::$time"
