#!/bin/bash
 
source ./master
 

mkdir -p "$basedirfrom$pth$shiftjobs_export"

 
for i in `seq 0 $(($timepoints-1))`
do
    job="$basedirfrom$pth$shiftjobs_export/shift-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx32g -Dtimepoint=$i -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/CalculateShifts.bsh" >> "$job"
    chmod a+x "$job"
done


cd "$basedirfrom$pth$shiftjobs_export"
ls -d $PWD/*.job > commands.txt
