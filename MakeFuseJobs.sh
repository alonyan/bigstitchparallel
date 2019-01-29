#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$fusejobs_export"
mkdir -p "$basedirto$pth$fused_dir"

 
for i in `seq 0 $(($timepoints-1))`
do
    job="$basedirto$pth$fusejobs_export/fuse-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx180g -Dtimepoint=$i -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/fuseTimepoint.bsh" >> "$job"
    chmod a+x "$job"
done


cd "$basedirto$pth$fusejobs_export"
ls -trd $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -trd $PWD/*.job >> commands.sh
