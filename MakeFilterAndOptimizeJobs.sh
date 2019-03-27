#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$optjobs_export"


fgr='fix_group_'
#IFS=' ' # space is set as delimiter
read -ra fpArr <<< "$fixPos" # str is read into an array as tokens separated by IFS

fixPosStr=""
for i in `seq 0 $(($timepoints-1))`
do
    for ind in "${fpArr[@]}"; 
	do # access each element of array
    	fixPosStr="$fgr$i-$ind, $fixPosStr"
    	done
done
fixPosStr="'$fixPosStr'"

#echo ${fixPosStr}

#find all job xmls
cd "$basedirto$pth"

array=()
while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
done < <(find . -name "*.job_*" -name "*.xml" -print0 )

#echo ${array[@]}

counter=0
# make a filt job for each xml 
for i in "${array[@]}"
do
    job="$basedirto$pth$optjobs_export/opt-$counter.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx32g -Ddir_to=$basedirto -Dpth=$pth -DfixPosStr=$fixPosStr -DxmlName=$i -- --no-splash $repodir/beanshellScripts/FiltAndOptSpecificXML.bsh" >> "$job"
    chmod a+x "$job"
    counter=$(($counter+1))
done


cd "$basedirto$pth$optjobs_export"
ls -d $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -d $PWD/*.job >> commands.sh
chmod a+x ./commands.sh
