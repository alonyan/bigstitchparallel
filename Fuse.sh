#!/bin/bash

dos2unix -n $1 /tmp/tmpmstr
mv /tmp/tmpmstr $1

source $1

#find interest points
$repodir/JobMakers/MakeFuseJobs.sh $1
parallel --memfree -24G --load 90% --delay 10 -j6 --retry-failed < $basedirto$pth$fusejobs_export/commands.txt

