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

echo "finding and printing files to delete"
sudo chown -R lledyl:lledyl ~/c/ktr/*
#find ~/c/ \( -name '*SAMPLE*'  -o -name '*-sample.mp4' -o -name '*.nfo' -o -name '*.jpg'  -o -name '*.txt' -o -name '*.url' -o -name '*.png' -o -name '*.gif' -o -name '*.htm*' -o -name '*.exe' \) -type f -print
find ~/c/ \( -name '*SAMPLE*' -o -name '*-sample.mp4' -o -name '*.nfo' -o -name '*.jpg'  -o -name '*.txt' -o -name '*.url' -o -name '*.png' -o -name '*.gif' -o -name '*.htm*' -o -name '*.exe' \) -type f -delete

mv ~/c/ktr/*/*.mp4 /home/lledyl/c/ktr/
mv ~/c/dvdrip/*/*.mp4 /home/lledyl/c/dvdrip/
find ~/c/ktr/*  -type d -empty -delete
find ~/c/dvdrip/*  -type d -empty -delete

rclone copy   ~/c/ktr/ k:0220/  --min-age 61s --include-from .gfilter.txt --size-only -P
mv ~/c/ktr/*/*.mp4 /home/lledyl/c/ktr/
mv ~/c/dvdrip/*/*.mp4 /home/lledyl/c/dvdrip/
find ~/c/ktr/*  -type d -empty -delete
find ~/c/dvdrip/*  -type d -empty -delete
rclone move   ~/c/ktr/ gs:t/k/0320/  --min-age 61s --include-from .gfilter.txt --size-only --delete-empty-src-dirs --ignore-existing -P

mv ~/c/ktr/*/*.mp4 /home/lledyl/c/ktr/
mv ~/c/dvdrip/*/*.mp4 /home/lledyl/c/dvdrip/
find ~/c/ktr/*  -type d -empty -delete
find ~/c/dvdrip/*  -type d -empty -delete

rclone copy   ~/c/dvdrip/ d:0220/ --min-age 61s --include-from .gfilter.txt --size-only -P
mv ~/c/ktr/*/*.mp4 /home/lledyl/c/ktr/
mv ~/c/dvdrip/*/*.mp4 /home/lledyl/c/dvdrip/
find ~/c/ktr/*  -type d -empty -delete
find ~/c/dvdrip/*  -type d -empty -delete
rclone move   ~/c/dvdrip/ gs:t/d/0320/ --min-age 61s --include-from .gfilter.txt --size-only --delete-empty-src-dirs --ignore-existing -P

echo "finished copy"

mv ~/c/ktr/*/*.mp4 /home/lledyl/c/ktr/
mv ~/c/dvdrip/*/*.mp4 /home/lledyl/c/dvdrip/
find ~/c/ktr/*  -type d -empty -delete
find ~/dvdrip/*  -type d -empty -delete

echo "cleaning torrent queue"
sh .rtorrents.sh
echo "finished"

rm $PIDFILE
