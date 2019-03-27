#!/bin/bash

dirName='/RazorScopeData/RazorScopeImages/Jen/CorneaHSV/InfectWhole_2019Mar22/acq_5'

logName='/Processing/filesThatTransfered.txt'

dictName='/Processing/filesToJobsDictionary.txt'

hdfJobsFolder='/Processing/hdf5jobs'
hdfComFile='/jobQueue.txt'


mkdir -p "$dirName$hdfJobsFolder"

fullComName=$dirName$hdfJobsFolder$hdfComFile
rm -f $fullComName

touch $fullComName

echo "$dirName$hdfJobsFolder/hdf5-0.job" >> $fullComName
cat "$dirName$logName" | while read FILENAME
do
   if grep -w $FILENAME "$dirName$dictName"; then
      matchedLine=$(grep -w $FILENAME "$dirName$dictName")
   #echo "$matchedLine"
      jobNum=$(echo $matchedLine | cut -d$' ' -f 1)
      echo "$jobNum"
      echo "$dirName$hdfJobsFolder/hdf5-$jobNum.job" >> $fullComName
   fi
done

tail -f "$dirName$logName" | while read FILENAME
do
   if grep -w $FILENAME "$dirName$dictName"; then
      matchedLine=$(grep -w $FILENAME "$dirName$dictName")
   #echo "$matchedLine"
      jobNum=$(echo $matchedLine | cut -d$' ' -f 1)
      echo "$jobNum"
      echo "$dirName$hdfJobsFolder/hdf5-$jobNum.job" >> $fullComName
   fi
done
