#!/bin/bash

### Wrapper script to call variants using platypus (merge all files) 


WORK_DIR=/home/data/wgs
ANALYSIS_DIR=${WORK_DIR}/analysis
LOG_DIR=${WORK_DIR}/logs
CONFIG_DIR=${WORK_DIR}/config
SCRIPT_DIR=/home/resources/pipelines
METADATA="/wehisan/home/allstaff/k/kondrashova.o/180802_wgs_metadata.txt"


for f in ${ANALYSIS_DIR}/*FR07888*.sorted.bam
do
	FILEBASE=`basename $f -platypus.vcf`
	SAMPLE=`echo $FILEBASE | cut -f 4 -d "_"`
	MODEL=`cat $METADATA | grep $SAMPLE | cut -f 2`
	TYPE=`cat $METADATA | grep $SAMPLE | cut -f 3`
	SAMPLE_ID=`cat $METADATA | grep $SAMPLE | cut -f 4`
	if [ ! -f ${CONFIG_DIR}/${MODEL}_file_list.txt ]
	then
		echo $f > ${CONFIG_DIR}/${MODEL}_file_list.txt
		find ${ANALYSIS_DIR}/  -name ${MODEL}*GL*-platypus.vcf -type f \
		>> ${CONFIG_DIR}/${MODEL}_file_list.txt
		${SCRIPT_DIR}/platypus_caller.sh ${CONFIG_DIR}/${MODEL}_file_list.txt \
		$ANALYSIS_DIR $LOG_DIR
	fi
done


