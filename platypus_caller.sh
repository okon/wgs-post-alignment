#!/bin/bash

#####
#####  platypus_caller.sh
#####
#####  Created by Olga Kondrashova on 13/08/18
#####

#Parameters for PBS job scheduler:
#PBS -N platypus_caller
#PBS -l nodes=1:ppn=4,mem=16gb
#PBS -m bea
#PBS -l walltime=12:00:00
#PBS -e home/kondrashova.o/logs/logs.out

module load platypus


FILE_LIST=$1
ANALYSIS_DIR=$2
LOG_DIR=$3

REF_GENOME=/wehisan/bioinf/bioinf-data/Papenfuss_lab/projects/reference_genomes/human_new/no_alt/hg38_no_alt.fa

FILEBASE=`basename $FILE_LIST _file_list.txt`

platypus callVariants --bamFiles=${FILE_LIST} --refFile=${REF_GENOME} \
--output=${ANALYSIS_DIR}/${FILEBASE}.vcf --logFileName={LOG_DIR}/${FILEBASE}_platypus.log \
--nCPU 4 --bufferSize 1000000 --maxReads 50000000