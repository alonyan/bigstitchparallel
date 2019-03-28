#!/bin/bash

source $1

#find interest points
$repodir/JobMakers/MakeFuseJobs.sh $1
parallel --memfree -24G --load 90% --delay 10 -j8 --retry-failed < $basedirto$pth$fusejobs_export/commands.txt

