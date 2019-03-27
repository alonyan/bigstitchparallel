#!/bin/bash

#remove the 

#Monitors the directory for added files:


#this will be the input
dirName='/RazorScopeData/RazorScopeImages/Jen/CorneaHSV/InfectWhole_2019Mar22/acq_5'

logName='/Processing/filesThatTransfered.txt'

mkdir -p "$dirName/Processing"

rm -f "$dirName$logName"
touch "$dirName$logName"

ls $dirName/*/*.tif | while read FILE
do
  FILENAME=$(echo $FILE | cut -d'/' -f 8)
  echo $FILENAME
  grep -qxF $FILENAME "$dirName$logName" || echo $FILENAME >> "$dirName$logName"
done

inotifywait -qrme CLOSE_WRITE --format %w%f $dirName | while read FILE
do
  FILENAME=$(echo $FILE | cut -d'/' -f 8)
  echo $FILENAME
  grep -qxF $FILENAME "$dirName$logName" || echo $FILENAME >> "$dirName$logName"
done



