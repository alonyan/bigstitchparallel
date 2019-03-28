#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$ICPjobs_export"

 
for i in `seq 0 1 $(($timepoints-1))`
do
    job="$basedirto$pth$ICPjobs_export/ICP-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    b=$(($timepoints<(($i+0))?$timepoints:(($i+0)) ))
    echo "xvfb-run -a ImageJ -Xmx160g -Dtimepoint="`seq -s ',' $i $b`" -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/ICPRefinement.bsh" >> "$job"

    chmod a+x "$job"
done


cd "$basedirto$pth$ICPjobs_export"
ls -trd $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -trd $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
