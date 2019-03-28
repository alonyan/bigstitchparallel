#!/bin/bash
# This function creates the jobs that convert individual .TIFF stacks to their HDF5 target.

dos2unix -n $1 /tmp/tmpmstr
mv /tmp/tmpmstr $1

source $1
 

mkdir -p "$basedirfrom$pth$hdf5jobs_export"

job="$basedirfrom$pth$hdf5jobs_export/hdf5-0.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "xvfb-run -a ImageJ -Xmx10g -Djob_number=0 -Ddir_from=$basedirfrom -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/ExportAsHDF5ToSets.bsh" >> "$job"
chmod a+x "$job"
 
for i in `seq 1 $(($timepoints*$channels*$tiles))`
do
    job="$basedirfrom$pth$hdf5jobs_export/hdf5-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx10g -Djob_number=$i -Ddir_from=$basedirfrom -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/ExportAsHDF5ToSets.bsh" >> "$job"
    chmod a+x "$job"
done


cd "$basedirfrom$pth$hdf5jobs_export"
ls -trd $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -trd $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
