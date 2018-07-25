#!/bin/bash
 
source ./master


mkdir -p "$basedirfrom$pth$xmljobs_export"

chnflg="false"
if [ $channels -gt "1" ] ; then
 chnflg="true"
fi

tptflg="false"
if [ $timepoints -gt "1" ] ; then
 tptflg="true"
fi

job="$dir$xmljobs_export/DefineXML.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "xvfb-run -a ImageJ -Ddir_from=$basedirfrom -Dpth=$pth -Dtimepoint_flag=$tptflg -Dchannel_flag=$chnflg -DzAspect=$zAspect -- --no-splash $repodir/DefineDatasetXML.bsh" >> "$job"


chmod a+x "$job"
