#!/bin/bash

source $1

#find interest points
$repodir/JobMakers/MakeStabilizeJobs.sh $1
$basedirto$pth$Stabilizejobs_export/MultiviewProp.job
