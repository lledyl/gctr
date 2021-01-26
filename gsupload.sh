#!/bin/bash
tput setaf 2; echo "Checking duplicate process"
PIDFILE=~/.glock.pid
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
sudo chown -R $USER:$USER /c/*
tput setaf 2; echo "Delete torrent waste files"
tput setaf 7;
find /c/ \( -name '*.srt' -o -name '*sample.mp4' -o -name '*.nfo' -o -name '*.jpeg' -o -name '*.jpg'  -o -name '*.txt' -o -name '*.url' -o -name '*.png' -o -name '*.gif' -o -name '*.htm*' -o -name '*.exe' -o -name '*.zip' \) -type f -delete
tput setaf 2;  echo "Moving files"
tput setaf 7;
mv /c/*/*.mp4 /c/rarbg
mv /c/*/*.mkv /c/rarbg
mv /c/*/*.wma /c/rarbg
mv /c/rarbg/*-A.mp4 /c
mv /c/rarbg/*-B.mp4 /c
mv /c/rarbg/*-C.mp4 /c
mv /c/rarbg/*-D.mp4 /c
mv /c/rarbg/*-E.mp4 /c
tput setaf 2; echo "Delete empty folders"
tput setaf 7;
find /c/rarbg/*  -type d -empty -delete
tput setaf 2; echo "Moving files to Google drive"
tput setaf 7;
rclone move   /c rclone_drive:folder  --min-age 61s --include-from filter.txt --size-only --delete-empty-src-dirs --ignore-existing -P --log-file=mylogfile.txt --drive-stop-on-upload-limit
tput setaf 2; echo "Cleaning transmission"
tput setaf 7;
sh .rtorrents.sh
tput setaf 2; echo "Delete lock file"
rm $PIDFILE
echo "Done"
