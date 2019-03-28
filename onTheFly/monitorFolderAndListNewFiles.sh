#!/bin/bash

#remove the 

#Monitors the directory for added files. When it finds one, it adds it to a log of files that transfered.


#this will be the input
source $1

dirName="$basedirfrom$pth"

logName='/Processing/filesThatTransfered.txt'

mkdir -p "$dirName/Processing"

#rm -f "$dirName$logName"
true >"$dirName$logName"

#first list all existing files
ls $dirName/*/*.tif | while read FILE
do
  FILENAME=$(echo $FILE | cut -d'/' -f 8)
  echo $FILENAME
  grep -qxF $FILENAME "$dirName$logName" || echo $FILENAME >> "$dirName$logName"
done

#then start a watch for any new arrivals
inotifywait -qrme CLOSE_WRITE --format %w%f $dirName | while read FILE
do
  FILENAME=$(echo $FILE | cut -d'/' -f 8)
  echo $FILENAME
  grep -qxF $FILENAME "$dirName$logName" || echo $FILENAME >> "$dirName$logName"
done



