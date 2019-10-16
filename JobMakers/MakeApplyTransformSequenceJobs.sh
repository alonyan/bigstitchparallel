#!/bin/bash
 
source $1
 



 
    job="$basedirto$pth/Processing/ApplySequence.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx160g -Dmaxtimepoint=$timepoints -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/DriftCorrectionApplyTransformSequence.bsh" >> "$job"

    chmod a+x "$job"
