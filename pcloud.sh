#!/bin/bash

PIDFILE=/home/$USER/plock.pid

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi
echo "moving files"
rclone move pcloud:pCloud\ Save pcloud_b: --min-age 10m --transfers 4 --drive-chunk-size 32M  --size-only  --ignore-existing --delete-empty-src-dirs --delete-after -P
echo "finished"
rm $PIDFILE
