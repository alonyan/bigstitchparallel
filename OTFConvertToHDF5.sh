#!/bin/bash
#this function reads the master file, creates jobs for each setup, monitors the directory where the data lands, and converts it to HDF5.
#it can run on the fly while imaging is happening, or later at any time. Ideally this should be started as soon as the first files are transfered.

dos2unix -n $1 /tmp/tmpmstr
mv /tmp/tmpmstr $1
source $1
$repodir/JobMakers/MakeHDFExportJobsSets.sh $1

$repodir/onTheFly/monitorFolderAndListNewFiles.sh $1&
$repodir/onTheFly/readNewFilesAndSubmitJobs.sh $1
