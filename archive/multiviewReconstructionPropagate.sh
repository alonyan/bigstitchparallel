#!/bin/bash

source $1

#find interest points
$repodir/JobMakers/MakeMultiviewPropJobs.sh $1
$basedirto$pth$Multiviewjobs_export/MultiviewProp.job
