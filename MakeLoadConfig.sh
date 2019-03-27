#!/bin/bash
 
source $1
 
procpth=/Processing

mkdir -p "$basedirto$pth$procpth"



    job="$basedirto$pth$procpth/LoadTileConfig.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx160g -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/LoadTileConfig.bsh" >> "$job"
    chmod a+x "$job"




#cd "$basedirto$pth$beadsjobs_export"
#ls -d $PWD/*.job > commands.txt
#echo "#!/bin/bash" > commands.sh
#ls -d $PWD/*.job >> commands.sh
#chmod a+x ./commands.sh
