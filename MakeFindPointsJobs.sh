#!/bin/bash
 
source $1
 

mkdir -p "$basedirto$pth$beadsjobs_export"

 

    job="$basedirto$pth$beadsjobs_export/findPoints.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx24g -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/FindInterestPoints.bsh" >> "$job"
    chmod a+x "$job"




cd "$basedirto$pth$beadsjobs_export"
ls -d $PWD/*.job > commands.txt
echo "#!/bin/bash" > commands.sh
ls -d $PWD/*.job >> commands.sh
