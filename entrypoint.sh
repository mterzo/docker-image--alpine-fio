#!/bin/bash

exec > >(tee /fio/results/output-${HOSTNAME}.log)

FIO=/usr/local/bin/fio
JOB_DIR=/fio/jobs

if [ ! -z "$(ls -A ${JOB_DIR}/*.fio 2> /dev/null)" ]; then
    for job in ${JOB_DIR}/*.fio
    do
        ${FIO} $@ ${job}
    done
else
    ${FIO} $@
fi
