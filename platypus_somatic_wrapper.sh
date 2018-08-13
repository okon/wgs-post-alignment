#!/bin/bash

### Script to start variant calling on all bams


WORK_DIR=/home/data/wgs
ANALYSIS_DIR=${WORK_DIR}/analysis
LOG_DIR=${WORK_DIR}/logs
SCRIPT_DIR=/home/resources/pipelines
METADATA="/wehisan/home/allstaff/k/kondrashova.o/180802_wgs_metadata.txt"


for f in ${ANALYSIS_DIR}/*-platypus.vcf
do
	FILEBASE=`basename $f -platypus.vcf`
	somaticMutationDetector.py --inputVCF=$f --outputVCF
done


