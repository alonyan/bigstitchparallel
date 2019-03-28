#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$beadsjobs_export"

 
for i in `seq 0 $(($timepoints-1))`
do
    job="$basedirto$pth$beadsjobs_export/findPoints-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx48g -Ddir_to=$basedirto -Dpth=$pth -Dtimepoint=$i -- --no-splash $repodir/beanshellScripts/FindInterestPoints.bsh" >> "$job"
    chmod a+x "$job"
done


echo "$basedirto$pth$beadsjobs_export"
cd "$basedirto$pth$beadsjobs_export"
ls -trd $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -trd $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
