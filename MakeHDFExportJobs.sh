#!/bin/bash
 
source ./master
 

mkdir -p "$dir$hdf5jobs_export"

job="$dir$hdf5jobs_export/hdf5-0.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "xvfb-run -a ImageJ -Xmx10g -Djob_number=0 -Ddir=$dir -- --no-splash $repodir/ExportAsHDF5.bsh" >> "$job"
chmod a+x "$job"
 
for i in `seq 1 $(($timepoints*$channels*$tiles))`
do
    job="$dir$hdf5jobs_export/hdf5-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx10g -Djob_number=$i -Ddir=$dir -- --no-splash $repodir/ExportAsHDF5.bsh" >> "$job"
    chmod a+x "$job"
done



