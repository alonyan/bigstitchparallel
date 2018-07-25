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

angflg="false"
if [ $angles -gt "1" ] ; then
 angflg="true"
fi

posflg="false"
if [ $pos -gt "1" ] ; then
 posflg="true"
fi

tilflg="false"
if [ $tiles -gt "1" ] ; then
 tilflg="true"
fi

job="$basedirfrom$pth$xmljobs_export/DefineXML.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "xvfb-run -a ImageJ -Ddir_from=$basedirfrom -Dpth=$pth -Dtimepoint_flag=$tptflg -Dchannel_flag=$chnflg -Dangle_flag=$tptflg -Dpos_flag=$posflg -Dtil_flag=$tilflg -DzAspect=$zAspect -- --no-splash $repodir/DefineDatasetXMLToSetsModular.bsh" >> "$job"


chmod a+x "$job"
