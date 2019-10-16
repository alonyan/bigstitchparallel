#!/bin/bash
 
source $1
 



 
i=1;
    job="$basedirto$pth/Processing/DuplicateFirst.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    b=$(($timepoints<(($i+0))?$timepoints:(($i+0)) ))
    echo "xvfb-run -a ImageJ -Xmx160g -Dmaxtimepoint=$timepoints -Dtimepoint=`seq -s ',' $i $b` -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/MultiviewReconstructDuplicateFirst.bsh" >> "$job"

    chmod a+x "$job"
