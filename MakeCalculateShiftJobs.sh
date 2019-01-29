#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$shiftjobs_export"

 
for i in `seq 0 $(($timepoints-1))`
do
    job="$basedirto$pth$shiftjobs_export/shift-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx32g -Dtimepoint=$i -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/CalculateShifts.bsh" >> "$job"
    chmod a+x "$job"
done


cd "$basedirto$pth$shiftjobs_export"
ls -d $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -d $PWD/*.job >> commands.sh
chmod ug+x ./commands.sh
