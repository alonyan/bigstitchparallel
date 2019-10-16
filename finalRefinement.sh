#!/bin/bash
dos2unix -n $1 /tmp/tmpmstr
mv /tmp/tmpmstr $1

source $1

#find interest points
$repodir/JobMakers/MakeFinalRefineJobs.sh $1
#$basedirto$pth$Finalrefinejobs_export/commands.sh

parallel --memfree -24G --load 90% --delay 5 -j8 --retry-failed < $basedirto$pth$Stabilizejobs_export/commands.txt


#Merge the files created by different processes.
$repodir/JobMakers/MakeMergeXMLJob.sh $1
$basedirto$pth/Processing/MergeXMLs.job

