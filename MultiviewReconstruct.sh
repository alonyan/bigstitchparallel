#!/bin/bash

source $1

#Apply first to rest
$repodir/JobMakers/MakePropFirstJob.sh $1
$basedirto$pth/Processing/DuplicateFirst.job

#Multiview Reconstruct
$repodir/JobMakers/MakeMultiviewJobs.sh $1
parallel --memfree -24G --load 90% --delay 5 -j8 --retry-failed < $basedirto$pth$Multiviewjobs_export/commands.txt

#Merge the files created by different processes.
$repodir/JobMakers/MakeMergeXMLJob.sh $1
$basedirto$pth/Processing/MergeXMLs.job
