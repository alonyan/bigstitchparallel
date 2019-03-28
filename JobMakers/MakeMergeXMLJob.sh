#!/bin/bash
 
source $1
 
procpth=/Processing
mkdir -p "$basedirto$pth$procpth"



    job="$basedirto$pth$procpth/MergeXMLs.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "xvfb-run -a ImageJ -Xmx160g -Ddir_to=$basedirto -Dpth=$pth -- --no-splash $repodir/beanshellScripts/MergeXMLs.bsh" >> "$job"
    echo $'\n' >> "$job"
    echo "# remove all temp XMLs:" >> "$job"
    echo "cd $basedirto$pth" >> "$job"
    echo $'\n' >> "$job"
    echo "array=()" >> "$job"
    echo "while IFS=  read -r -d $'\0'; do" >> "$job"
    echo "    array+=(\"\$REPLY\")" >> "$job"
    echo "done < <(find . -name \"*.job_*\" -print0)" >> "$job"

    echo $'\n' >> "$job"
    echo "for i in \"\${array[@]}\"" >> "$job"
    echo "do" >> "$job"
    echo "    echo \${i}" >> "$job"
    echo "    rm \$i" >> "$job"
    echo "done" >> "$job"
    chmod a+x "$job"

