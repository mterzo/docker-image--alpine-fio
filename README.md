# FIO
Docker container to run FIO (https://github.com/axboe/fio) jobs using alpine

# Volumes
Using docker pass through we need 3 directories
* Results /fio/results
* Directory for IO testing /fio/test_dir
* Jobs /fio/jobs

## IO Testing
Using various diffeerent modules you may want multiple directories for 
pass-through.  /fio/test_dir is just a suggestion.

# Usage

## One off Tests
Passing arguments to FIO
```
docker run -v /some_dir>:/fio/test_di -v ${PWD}/results:/fio/results -it terzom/alpine-aio  \
    --name=randrw --ioengine=libaio -iodepth=1 -rw=randrw --bs=64k --direct=1 --size=512m   \
    --numjobs=8 --runtime=300 --group_reporting --time_based --rwmixread=70  --directory=/fio/test_dir
```

## Using AIO jobs
Use jobs directory to execute a series of jobs, all jobs in the jobs in the fio directory will be executed.
```
docker run -v /<some_dir>/:/fio/test_dir -v ${PWD}/samples:/fio/jobs -v ${PWD}/results:/fio/results -it fio
```
