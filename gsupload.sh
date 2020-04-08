#!/bin/bash
echo "checking if running..."
PIDFILE=~/.glock.pid
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

sudo chown -R $USER:$USER /c/*

find /c/ \( -name '*.srt' -o -name '*sample.mp4' -o -name '*.nfo' -o -name '*.jpg'  -o -name '*.txt' -o -name '*.url' -o -name '*.png' -o -name '*.gif' -o -name '*.htm*' -o -name '*.exe' -o -name '*.zip' \) -type f -delete

sudo chown -R $USER:$USER /c/*
mv /c/*/*.mp4 /c/
mv /c/*/*.mkv /c/
mv /c/*/*.wma /c/
find /c/*  -type d -empty -delete
rclone copy   /c/ gs:temp/  --min-age 61s --include-from gfilter.txt --size-only -P

sudo chown -R $USER:$USER /c/*
mv /c/*/*.mp4 ~/c/
mv /c/*/*.mkv /c/
mv /c/*/*.wma /c/
find /c/*  -type d -empty -delete
rclone move   /c/ gs:temp/  --min-age 61s --include-from gfilter.txt --size-only --delete-empty-src-dirs --ignore-existing -P

sh .rtorrents.sh

rm $PIDFILE



