#!/bin/bash

dos2unix -n $1 /tmp/tmpmstr
mv /tmp/tmpmstr $1

source $1

#Calculate shifts
$repodir/JobMakers/MakeCalculateShiftJobs.sh $1
parallel --memfree -24G --load 90% --delay 5 -j8 --retry-failed < $basedirto$pth$shiftjobs_export/commands.txt

#Filter links and apply shifts using global optimization.
$repodir/JobMakers/MakeFilterAndOptimizeJobs.sh $1
parallel --memfree -24G --load 90% --delay 5 -j8 --retry-failed < $basedirto$pth$optjobs_export/commands.txt

#Merge the files created by different processes.
$repodir/JobMakers/MakeMergeXMLJob.sh $1
$basedirto$pth/Processing/MergeXMLs.job
