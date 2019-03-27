#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$shiftjobs_export"


fgr='fix_group_'
#IFS=' ' # space is set as delimiter
read -ra fpArr <<< "$fixPos" # str is read into an array as tokens separated by IFS

 
for i in `seq 0 $(($timepoints-1))`
do
    fixPosStr=""
    for ind in "${fpArr[@]}"; 
	do # access each element of array
    	fixPosStr="$fgr$i-$ind, $fixPosStr"
    	done
    fixPosStr="'$fixPosStr'"
    job="$basedirto$pth$shiftjobs_export/shift-$i.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx32g -Dtimepoint=$i -Ddir_to=$basedirto -Dpth=$pth -DfixPosStr=$fixPosStr -- --no-splash $repodir/beanshellScripts/CalculateShifts.bsh" >> "$job"
    chmod a+x "$job"
done


cd "$basedirto$pth$shiftjobs_export"
ls -d $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -d $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
