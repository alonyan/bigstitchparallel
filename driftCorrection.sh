#!/bin/bash
dos2unix -n $1 /tmp/tmpmstr
mv /tmp/tmpmstr $1

source $1

#find interest points
$repodir/JobMakers/MakeStabilizeJobs.sh $1
$basedirto$pth$Stabilizejobs_export/commands.sh
#parallel --memfree -24G --load 90% --delay 5 -j8 --retry-failed < $basedirto$pth$Stabilizejobs_export/commands.txt


#Merge the files created by different processes.
#$repodir/JobMakers/MakeMergeXMLJob.sh $1
#$basedirto$pth/Processing/MergeXMLs.job

#Apply Transforms to align everything together
#$repodir/JobMakers/MakeApplyTransformSequenceJobs.sh $1
#$basedirto$pth/Processing/ApplySequence.job
