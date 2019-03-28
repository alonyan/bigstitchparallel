#!/bin/bash

source $1

#find interest points
$repodir/JobMakers/MakeFindPointsJobs.sh $1
parallel --memfree -24G --load 90% --delay 5 -j12 --retry-failed < $basedirto$pth$beadsjobs_export/commands.txt


#Merge the files created by different processes.
$basedirto$pth/Processing/MergeXMLs.sh

