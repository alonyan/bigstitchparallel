#!/bin/bash

dos2unix -n $1 /tmp/tmpmstr
mv /tmp/tmpmstr $1

source $1

$repodir/JobMakers/MakeLoadConfig.sh $1

$basedirto$pth/Processing/LoadTileConfig.job
