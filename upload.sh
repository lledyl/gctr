#!/bin/bash
tput setaf 2; echo "Checking duplicate process"
PIDFILE=~/.lock.pid
if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    tput setaf 1; echo "Process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      tput setaf 1; echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    tput setaf 1; echo "Could not create PID file"
    exit 1
  fi
fi

tput setaf 2; echo "No duplicate process found"
tput setaf 2; echo "Change permissions"
tput setaf 7;
sudo chown -R $USER:$USER /complete/*
tput setaf 2; echo "Moving files to Google drive"
tput setaf 7;
rclone move   /complete Downloads:folder  --min-age 61s --include-from filter.txt --size-only --delete-empty-src-dirs --ignore-existing -P --log-file=rclone.log --drive-stop-on-upload-limit
tput setaf 2; echo "Delete lock file"
rm $PIDFILE
echo "Done"
