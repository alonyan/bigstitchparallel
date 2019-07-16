#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$Stabilizejobs_export"

 
for i in `seq 1 1 $(($timepoints-1))`
do
    #cp "$basedirto$pth/hdf5_dataset.xml" "$basedirto$pth/hdf5_dataset.job_$i.xml"

    job="$basedirto$pth$Stabilizejobs_export/StabilizeTP-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    b=$(($timepoints<(($i))?$timepoints:(($i)) ))
    echo "xvfb-run -a ImageJ -Xmx160g -Dtimepoint="`seq -s ',' $i $b`" -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/StabilizeTimepoints.bsh" >> "$job"

    chmod a+x "$job"
    sleep .01
done


cd "$basedirto$pth$Stabilizejobs_export"
ls -trd $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -trd $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
