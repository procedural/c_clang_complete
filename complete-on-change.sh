#!/bin/bash

prev_stat=0

while true
do
  curr_stat=$(stat -c %Z "${1}")
  if [ $curr_stat -ne $prev_stat ]
  then
    clear && clear
    ./complete.sh "${1}"
    prev_stat=$curr_stat
  fi
done
