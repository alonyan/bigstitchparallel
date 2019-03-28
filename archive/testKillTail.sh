#!/bin/bash 
 true >jobqueue;
    tail -n+0 -f jobqueue | 
       parallel -E "stopNow" ; echo "GNU Parallel is now done"
       (seq 1000 >> jobqueue &);
       echo "Done appending dummy data forcing tail to exit)"
    echo "tail exited";
    mv j2 jobqueue
  
