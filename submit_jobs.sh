#!/bin/bash

for file in `ls ${1} | grep ".job$"`
do
	batch < "${1}/$file"
done
