#!/bin/bash
#Tail a temp file, pipe it into GNU Parallel.  
#Generally FIFOish but don't count on it, no guarantees about execution order between setup and tear-down

#Tips: 
#I threw this together for a network based load - 
#  for disk-bound (esp magnetic hard drives) loads, lower -j to 1 or switch to --semaphore
#  most load you can probably just omit -j and run with defaults. (One concurrent job per CPU core)

#todo:
  #functionize for easier reuse
  #autogenerate temp files somewhere safe
  #Use parallel's USR1 signal output to provide completion countdown

#Setup
QUEUE_END="EndHere"
true > jobqueue
tail -n+0 -f jobqueue | parallel -j 10 -E $QUEUE_END 


#Each line in the jobqueue should be a complete command
for JOB in `cat jobs.txt`; do
  echo $JOB > jobqueue
done

#End the queue, wait for completion, terminate tail
echo $QUEUE_END >> jobqueue
echo "Waiting for queued jobs to complete"
while [ `ps | grep 'perl /usr/local/bin/parallel' | egrep -v 'grep' | wc -l | tr -d " "` -gt 0 ]; do
  sleep 1
done
touch killtail
mv killtail jobqueue
rm jobqueue
