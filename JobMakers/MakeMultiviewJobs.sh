#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$Multiviewjobs_export"

 
for i in `seq 1 1 $(($timepoints-1))`
do
    cp "$basedirto$pth/hdf5_dataset.xml" "$basedirto$pth/hdf5_dataset.job_$i.xml"

    job="$basedirto$pth$Multiviewjobs_export/Multiview-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    b=$(($timepoints<(($i+0))?$timepoints:(($i+0)) ))
    echo "xvfb-run -a ImageJ -Xmx160g -Dmaxtimepoint=$timepoints -Dtimepoint=`seq -s ',' $i $b` -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/MultiviewReconstructOneToAll.bsh" >> "$job"

    chmod a+x "$job"
done


cd "$basedirto$pth$Multiviewjobs_export"
ls -trd $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -trd $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
