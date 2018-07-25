#!/bin/bash
 
source ./master
 

mkdir -p "$basedirfrom$pth$hdf5jobs_export"

job="$basedirfrom$pth$hdf5jobs_export/hdf5-0.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "xvfb-run -a ImageJ -Xmx10g -Djob_number=0 -Ddir_from=$basedirfrom -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/ExportAsHDF5ToSets.bsh" >> "$job"
chmod a+x "$job"
 
for i in `seq 1 $(($timepoints*$channels*$tiles))`
do
    job="$basedirfrom$pth$hdf5jobs_export/hdf5-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx10g -Djob_number=$i -Ddir_from=$basedirfrom -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/ExportAsHDF5ToSets.bsh" >> "$job"
    chmod a+x "$job"
done



