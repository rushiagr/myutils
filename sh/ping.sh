#!/bin/bash

# NOTE: borrowed from https://askubuntu.com/questions/413367/ping-multiple-ips-using-bash/413378#413378

for i in `seq ${2} ${3}`
do
    ping -c 1 ${1}.${i} > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "${1}.${i} responded."
    else
        echo "${1}.${i} did not respond."
    fi
done
