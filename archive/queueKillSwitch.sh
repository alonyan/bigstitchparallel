#!/bin/bash

dirName='/RazorScopeData/RazorScopeImages/Jen/CorneaHSV/InfectWhole_2019Mar22/acq_5'

dictName='/Processing/filesToJobsDictionary.txt'


while [[ -s $dirName$dictName ]]; do
 sleep 0.1;
done;
 echo "file is empty"
#killall tail
killall inotifywait
