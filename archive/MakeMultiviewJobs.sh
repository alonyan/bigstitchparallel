#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$Multiviewjobs_export"

 
for i in `seq 0 10 $(($timepoints-1))`
do
    job="$basedirto$pth$Multiviewjobs_export/Multiview-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    b=$(($timepoints<(($i+9))?$timepoints:(($i+9)) ))
    echo "xvfb-run -a ImageJ -Xmx160g -Dtimepoint=`seq -s ',' $i $b` -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/MultiviewReconstruct.bsh" >> "$job"

    chmod a+x "$job"
done


cd "$basedirto$pth$Multiviewjobs_export"
ls -d $PWD/*.job > commands.txt
