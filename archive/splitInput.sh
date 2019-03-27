#!/bin/bash
 
source $1
timepoint=7
spc=_
IFS=' ' # space is set as delimiter
foo=""
read -ra fpArr <<< "$fixPos" # str is read into an array as tokens separated by IFS
for ind in "${fpArr[@]}"; do # access each element of array
    foo="$foo fix_group_$timepoint$spc$ind,"
done
echo $foo
