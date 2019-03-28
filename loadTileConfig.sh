#!/bin/bash

source $1

$repodir/JobMakers/MakeLoadConfig.sh $1

$basedirto$pth/Processing/LoadTileConfig.job
