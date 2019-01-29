#!/bin/bash
xvfb-run -a ImageJ -Xmx24g -Dtimepoint=5 -Dmaxtimepoint=96 -Ddir_to=blabla -Ddir_to=/RazorScopeData/RazorScopeSets -Dpth=/Zach/CorneaWound/CorneaWound24h_2018Oct26/acq_4 -- --no-splash /home/wollmanlab/Documents/Repos/bigstitchparallel/test.bsh
