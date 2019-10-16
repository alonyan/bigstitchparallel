#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$Multiviewjobs_export"


    job="$basedirto$pth$Multiviewjobs_export/MultiviewProp.job"
    echo $job
    echo "#!/bin/bash" > "$job"

    echo "xvfb-run -a ImageJ -Xmx160g -Dmaxtimepoint=$timepoints -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/MultiviewReconstructPropagate.bsh" >> "$job"

    chmod a+x "$job"




