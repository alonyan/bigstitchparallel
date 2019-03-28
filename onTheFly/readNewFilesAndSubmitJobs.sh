#!/bin/bash

#Monitors the list of transfered files. Once a file arrives, adds the job to a job queue using a dictionary that matches file name to job number. Removes that line from a dictionary.

source $1


QUEUE_END="EndHere"
dirName="$basedirfrom$pth"
logName='/Processing/filesThatTransfered.txt'
dictName='/Processing/filesToJobsDictionary.txt'
hdfJobsFolder='/Processing/hdf5jobs'
hdfQueFile='/jobQueue.txt'
hdfComFile='/commands.txt'


mkdir -p "$dirName$hdfJobsFolder"

fullComName=$dirName$hdfJobsFolder$hdfComFile
fullQueName=$dirName$hdfJobsFolder$hdfQueFile

#Make empty queue file and start tailing. Add any new line to the queue for parallel execution
true > $fullQueName
tail -n+0 -f $fullQueName | parallel --memfree -24G --load 90% --delay 10 -j12 --retry-failed -E $QUEUE_END &

tailprocess=`ps ax | grep -v grep | grep "tail -n+0 -f $fullQueName" | awk '{print $1}'`

#First, job-0
echo "$dirName$hdfJobsFolder/hdf5-0.job" > $fullQueName

#add all existing files
cat "$dirName$logName" | while read FILENAME 
do
   if grep -w $FILENAME "$dirName$dictName"; then
      matchedLine=$(grep -w $FILENAME "$dirName$dictName")
   #echo "$matchedLine"
      jobNum=$(echo $matchedLine | cut -d$' ' -f 1)
      echo "$jobNum"
      echo "$dirName$hdfJobsFolder/hdf5-$jobNum.job" >> $fullQueName
   fi
done 

#then start a watch for any new arrivals
tail -f "$dirName$logName" | while read FILENAME 
do
   if grep -w $FILENAME "$dirName$dictName"; then
      matchedLine=$(grep -w $FILENAME "$dirName$dictName")
   #echo "$matchedLine"
      jobNum=$(echo $matchedLine | cut -d$' ' -f 1)
      #echo "$jobNum"
      grep -qxF "$dirName$hdfJobsFolder/hdf5-$jobNum.job" $fullQueName || echo "$dirName$hdfJobsFolder/hdf5-$jobNum.job" >> $fullQueName
   fi
done &


#While there are still stuff in the dictionary, wait
a=1;
b=0;
while [ $a -ne $b ]; do
a=$(wc -l < $fullComName)
b=$(wc -l < $fullQueName)
 echo "I'm waiting"
 sleep 1;
done;
sleep 1;
# The dictionary is empty, so we don't need to watch the folder anymore
killall inotifywait
#We add the termination signal to the queue
echo $QUEUE_END >> $fullQueName
#echo "Waiting for queued jobs to complete"
#while [ `ps | grep 'perl /usr/local/bin/parallel' | egrep -v 'grep' | wc -l | tr -d " "` -gt 0 ]; do
#  sleep 1
#done

# ^ prepare to kill tail
kill -9 $tailprocess 
echo "tail process killed"


