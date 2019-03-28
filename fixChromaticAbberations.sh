#!/bin/bash

source $1

#find interest points
$repodir/JobMakers/MakeICPJobs.sh $1
parallel --memfree -24G --load 90% --delay 5 -j12 --retry-failed < $basedirto$pth$ICPjobs_export/commands.txt


#Merge the files created by different processes.
$repodir/JobMakers/MakeMergeXMLJob.sh $1
$basedirto$pth/Processing/MergeXMLs.sh
