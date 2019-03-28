#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$fusejobs_export"
mkdir -p "$basedirto$pth$fused_dir"

 
for i in `seq 0 $(($timepoints-1))`
do
	for j in `seq 1 $(($channels))`
	do
	    job="$basedirto$pth$fusejobs_export/fuse-$((3*$i+$j)).job"
	    echo $job
	    echo "#!/bin/bash" > "$job"
	    echo "xvfb-run -a ImageJ -Xmx24g -Dtimepoint=$i -Dchannel=$j -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/fuseTimepoint.bsh" >> "$job"
	    chmod a+x "$job"
	done
done


cd "$basedirto$pth$fusejobs_export"
ls -trd $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -trd $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
